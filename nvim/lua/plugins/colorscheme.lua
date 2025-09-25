return {
  {
    "ellisonleao/gruvbox.nvim",
    opts = {
      transparent_mode = true,
      overrides = {
        TreesitterContextBottom = { underline = true, sp = "#665c54" },
        TreesitterContextLineNumberBottom = { underline = true, sp = "#665c54" },
        IlluminatedWordText = { bg = "#665c54", underline = false },
        IlluminatedWordRead = { bg = "#665c54", underline = false },
        IlluminatedWordWrite = { bg = "#665c54", underline = false },
      },
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox",
    },
  },
}
