return {
  {
    "ellisonleao/gruvbox.nvim",
    opts = {
      transparent_mode = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
      overrides = {
        TreesitterContextBottom = { underline = true, sp = "#665c54" },
        TreesitterContextLineNumberBottom = { underline = true, sp = "#665c54" },
        IlluminatedWordText = { underline = true },
        IlluminatedWordRead = { underline = true },
        IlluminatedWordWrite = { underline = true },
        StatusLine = { bg = "NONE" },
        CursorLine = { bg = "#282828" },
        CursorLineNr = { bg = "NONE" },
        Visual = { bg = "#3C3836" },
        RenderMarkdownCode = { bg = "#1D2021" },
        Folded = { bg = "#282828" },
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
