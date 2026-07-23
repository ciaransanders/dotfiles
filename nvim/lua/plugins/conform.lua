return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      htmldjango = { "djhtml" },
      python = { "isort" },
    },
    formatters = {
      djhtml = {
        command = "djhtml",
        args = { "-" },
        stdin = true,
      },
    },
  },
  keys = {
    {
      "<leader>ct",
      function()
        require("conform").format({
          formatters = { "rustywind" },
        })
      end,
      desc = "Format tailwindcss classes",
    },
  },
}
