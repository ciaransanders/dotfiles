return {
  {
    "olimorris/codecompanion.nvim",
    version = "^18.0.0",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
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
      },
      adapters = {
        acp = {
          claude_code = function()
            return require("codecompanion.adapters").extend("claude_code", {}) -- looks for env variable CLAUDE_CODE_OAUTH_TOKEN
          end,
        },
        https = {
          anthropic = function()
            return require("codecompanion.adapters").extend("anthropic", {}) -- looks for env variable ANTHROPIC_API_KEY
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
    },
    cmd = {
      "CodeCompanion",
      "CodeCompanionChat",
      "CodeCompanionActions",
    },
  },
}
