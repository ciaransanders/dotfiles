return {
  {
    "olimorris/codecompanion.nvim",
    version = "^19.0.0",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "ravitemer/codecompanion-history.nvim",
      "lalitmee/codecompanion-spinners.nvim",
    },
    opts = {
      extensions = {
        history = {
          enabled = true,
          opts = {
            expiration_days = 21,
            picker = "snacks",
            auto_generate_title = true,
            title_generation_opts = {
              adapter = { name = "anthropic", model = "claude-haiku-4-5" },
              model = "claude-haiku-4-5",
              -- The first title only sees the opening message. Re-title after
              -- the 2nd, 4th and 6th prompts once there is real context.
              refresh_every_n_prompts = 2,
              max_refreshes = 3,
              format_title = function(title)
                -- Keep nil and the "Deciding title..." placeholders untouched.
                if not title or title:match("%.%.%.$") then
                  return title
                end
                title = vim.trim(title:gsub("^[Tt]itle:%s*", ""):gsub('["`*#]', ""))
                return (title:gsub("[%.%s]+$", ""))
              end,
            },
          },
        },
        spinner = {
          opts = {
            style = "snacks",
            default_icon = "󰚩",
          },
        },
      },
      interactions = {
        chat = {
          opts = {
            completion_provider = "blink",
          },
          adapter = "claude_code",
        },
        inline = {
          adapter = "anthropic",
        },
        cli = {
          agent = "claude_code",
          agents = {
            claude_code = {
              cmd = "claude",
              args = {},
              description = "Claude Code CLI",
              provider = "terminal",
            },
          },
        },
      },
      adapters = {
        acp = {
          claude_code = function()
            return require("codecompanion.adapters").extend("claude_code", {
              env = {
                CLAUDE_CODE_OAUTH_TOKEN = "CLAUDE_CODE_PRO_SUBSCRIPTION_AUTH_TOKEN",
                -- The spawned process inherits Neovim's env, which includes
                -- ANTHROPIC_API_KEY (needed by the `anthropic` HTTP adapter). If
                -- left set, Claude Code reports apiKeySource=ANTHROPIC_API_KEY
                -- and can bill API credits. Blank it for THIS subprocess only so
                -- auth is purely the OAuth token -> Pro subscription.
                ANTHROPIC_API_KEY = function()
                  return ""
                end,
              },
            })
          end,
        },
        http = {
          anthropic = function()
            return require("codecompanion.adapters").extend("anthropic", {
              -- The inline default model (claude-sonnet-5) rejects `temperature`
              -- ("`temperature` is deprecated for this model"), but the adapter
              -- only strips it for opus-4-7/opus-4-8/fable. Never send it.
              schema = {
                temperature = {
                  enabled = function()
                    return false
                  end,
                },
                -- Stop the adapter auto-enabling adaptive thinking. This adapter
                -- is used by inline edits and by the history auto title-generation
                -- (claude-haiku-4-5), whose API rejects `thinking.type="adaptive"`
                -- ("adaptive thinking is not supported on this model"). Off by
                -- default; still toggleable per-chat.
                extended_thinking = {
                  default = function()
                    return false
                  end,
                },
              },
            }) -- looks for env variable ANTHROPIC_API_KEY
          end,
        },
      },
      display = {
        chat = {
          show_tools_processing = true,
          window = {
            -- Set env variable CC_CHAT_ONLY=1 to launch a chat only buffer.
            -- Example use case: in ~/.aliases => alias ai='CC_CHAT_ONLY=1 nvim -c "CodeCompanionChat"'
            layout = vim.env.CC_CHAT_ONLY == "1" and "buffer" or "vertical",
          },
        },
        diff = {
          provider = "inline",
          provider_opts = {
            inline = {
              layout = "float",
              opts = {
                dim = 0,
              },
            },
          },
        },
      },
    },
    config = function(_, opts)
      require("codecompanion").setup(opts)

      -- codecompanion-history hardcodes its title prompt ("max 5 words", built from
      -- the first message only), which produces near-identical titles. It has no
      -- option to change the prompt, so wrap the request and supply our own.
      local config = require("codecompanion.config")
      local TitleGenerator = require("codecompanion._extensions.history.title_generator")
      local make_request = TitleGenerator._make_adapter_request

      local function excerpt(msg, limit)
        local role = msg.role == config.constants.USER_ROLE and "User" or "Assistant"
        local content = vim.trim(msg.content)
        -- Truncate by characters, not bytes: string.sub can split a multi-byte
        -- UTF-8 char (em dash, emoji, icons), which the API rejects as invalid JSON.
        if vim.fn.strchars(content) > limit then
          content = vim.fn.strcharpart(content, 0, limit) .. " [truncated]"
        end
        return role .. ": " .. content
      end

      TitleGenerator._make_adapter_request = function(self, chat, _, callback)
        local messages = vim.tbl_filter(function(msg)
          return msg.content
            and vim.trim(msg.content) ~= ""
            and (msg.role == config.constants.USER_ROLE or msg.role == config.constants.LLM_ROLE)
            and not (msg.opts and (msg.opts.tag or msg.opts.reference or msg.opts.context_id))
        end, chat.messages or {})

        -- Always include the opening message (it states the original goal) plus
        -- the most recent exchange, so refreshes don't lose the overall topic.
        local parts = {}
        local start = math.max(2, #messages - 5)
        if messages[1] then
          table.insert(parts, excerpt(messages[1], 1500))
        end
        if start > 2 then
          table.insert(parts, "[...]")
        end
        for i = start, #messages do
          table.insert(parts, excerpt(messages[i], 800))
        end

        local previous = chat.opts.title
            and not chat.opts.title:match("%.%.%.$")
            and ("\nCurrent title (replace it if it is vague or outdated): " .. chat.opts.title .. "\n")
          or ""

        local prompt = string.format(
          [[Write a title for the chat below. It will be shown in a list of many other chats that are mostly about programming, Neovim and dotfiles, so it must make this chat easy to tell apart from the rest.

Rules:
- 4 to 9 words.
- Name the concrete subject: the specific tool, plugin, language, file, function, command or error message involved.
- Say what was being done to it: e.g. fix, configure, debug, explain, compare, refactor, write, migrate.
- Never use vague filler like "Help", "Question", "Issue", "Code", "Assistance", "Discussion" or a bare topic like "Neovim Config" or "Lua Help".
- Plain text only: no quotes, no markdown, no trailing punctuation, no "Title:" prefix.

Examples:
Bad: Neovim Plugin Help
Good: Fix blink.cmp completions missing in CodeCompanion chat
Bad: Shell Question
Good: Zsh alias to launch Neovim in chat-only mode
Bad: Python Error
Good: Debug pandas KeyError when merging CSV exports
%s
Chat:
%s

Respond with only the title.]],
          previous,
          table.concat(parts, "\n\n")
        )

        return make_request(self, chat, prompt, callback)
      end
    end,
    keys = {
      { "<leader>ap", "<cmd>CodeCompanionActions<CR>", desc = "Action Palette" },
      { "<leader>ai", "<cmd>CodeCompanionChat Toggle<CR>", desc = "Toggle Chat" },
      { "<leader>an", "<cmd>CodeCompanionChat<CR>", desc = "New Chat" },
      { "<leader>aa", "<cmd>CodeCompanionChat Add<cr>", mode = "v", desc = "Add selection to CodeCompanion chat" },
      { "<leader>ac", "<cmd>CodeCompanionCLI<CR>", desc = "Toggle CLI" },
    },
    cmd = {
      "CodeCompanion",
      "CodeCompanionChat",
      "CodeCompanionActions",
    },
  },
}
