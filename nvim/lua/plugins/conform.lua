return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      htmldjango = { "djhtml" },
      python = { "ruff_organize_imports", "ruff_format" },
    },
    formatters = {
      djhtml = {
        command = "djhtml",
        -- Pass the buffer's indent width explicitly; otherwise djhtml guesses
        -- from the file, which can disagree with a project's .editorconfig.
        args = function(_, ctx)
          return { "--tabwidth", tostring(vim.bo[ctx.buf].shiftwidth), "-" }
        end,
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
