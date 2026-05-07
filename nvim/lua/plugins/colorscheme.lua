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
        RenderMarkdownH1Bg = { bg = "#1D2021", fg = "#b8bb26" },
        RenderMarkdownH2Bg = { bg = "#1D2021", fg = "#fabd2f" },
        RenderMarkdownH3Bg = { bg = "#1D2021", fg = "#83a598" },
        RenderMarkdownH4Bg = { bg = "#1D2021", fg = "#d3869b" },
        RenderMarkdownH5Bg = { bg = "#1D2021", fg = "#8ec07c" },
        RenderMarkdownH6Bg = { bg = "#1D2021", fg = "#fe8019" },
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
