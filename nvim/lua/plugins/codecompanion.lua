return {
  {
    "olimorris/codecompanion.nvim",
    version = "^19.0.0",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "lalitmee/codecompanion-spinners.nvim",
    },
    opts = {
      extensions = {
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
          keymaps = {
            -- `gh` (chat history) runs /resume. ACP chats list and load the agent's
            -- own sessions, so it only works before the first message is sent.
            resume = {
              modes = { n = "gh" },
              description = "Resume a previous session",
              callback = function(chat)
                local config = require("codecompanion.config")
                require("codecompanion.interactions.chat.slash_commands").new():execute({
                  label = "resume",
                  config = config.interactions.chat.slash_commands.resume,
                }, chat)
              end,
            },
          },
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
                -- Stop the adapter auto-enabling adaptive thinking for inline edits.
                -- Some models (e.g. claude-haiku-4-5) reject `thinking.type="adaptive"`
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
