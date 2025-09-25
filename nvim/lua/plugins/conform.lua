return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      htmldjango = { "djlint" },
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
