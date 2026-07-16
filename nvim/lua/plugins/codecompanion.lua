return {
  {
    "olimorris/codecompanion.nvim",
    version = "^19.0.0",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "ravitemer/codecompanion-history.nvim",
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
              adapter = "anthropic",
              model = "claude-haiku-4-5",
            },
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
              },
            }) -- looks for env variable ANTHROPIC_API_KEY
          end,
        },
      },
      display = {
        chat = {
          show_tools_processing = true,
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
