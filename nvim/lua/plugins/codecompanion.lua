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
            return require("codecompanion.adapters").extend("claude_code", {}) -- looks for env variable CLAUDE_CODE_OAUTH_TOKEN
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
      { "<leader>ac", "<cmd>CodeCompanionChat Toggle<CR>", desc = "Toggle Chat" },
      { "<leader>aa", "<cmd>CodeCompanionChat Add<cr>", mode = "v", desc = "Add selection to CodeCompanion chat" },
      { "<leader>as", "<cmd>CodeCompanionCLI Toggle<CR>", desc = "Toggle CLI" },
    },
    cmd = {
      "CodeCompanion",
      "CodeCompanionChat",
      "CodeCompanionActions",
    },
  },
}
