local icons = LazyVim.config.icons

local colors = {
  black = "#282828",
  white = "#ebdbb2",
  red = "#fb4934",
  green = "#b8bb26",
  blue = "#83a598",
  yellow = "#fe8019",
  gray = "#a89984",
  darkgray = "#3c3836",
  lightgray = "#504945",
  inactivegray = "#7c6f64",
  transparent = "NONE",
}

local gruvbox = {
  normal = {
    a = { bg = colors.gray, fg = colors.black, gui = "bold" },
    b = { bg = colors.lightgray, fg = colors.white },
    c = { bg = colors.transparent, fg = colors.white },
  },
  insert = {
    a = { bg = colors.blue, fg = colors.black, gui = "bold" },
    b = { bg = colors.lightgray, fg = colors.white },
    c = { bg = colors.transparent, fg = colors.white },
  },
  visual = {
    a = { bg = colors.yellow, fg = colors.black, gui = "bold" },
    b = { bg = colors.lightgray, fg = colors.white },
    c = { bg = colors.transparent, fg = colors.white },
  },
  replace = {
    a = { bg = colors.red, fg = colors.black, gui = "bold" },
    b = { bg = colors.lightgray, fg = colors.white },
    c = { bg = colors.transparent, fg = colors.white },
  },
  command = {
    a = { bg = colors.green, fg = colors.black, gui = "bold" },
    b = { bg = colors.lightgray, fg = colors.white },
    c = { bg = colors.transparent, fg = colors.white },
  },
  inactive = {
    a = { bg = colors.red, fg = colors.gray, gui = "bold" },
    b = { bg = colors.transparent, fg = colors.gray },
    c = { bg = colors.transparent, fg = colors.gray },
  },
}

return {
  {
    "nvim-lualine/lualine.nvim",
    opts = {
      options = {
        theme = gruvbox,
      },
      sections = {
        lualine_c = {
          LazyVim.lualine.root_dir(),
          {
            "diagnostics",
            symbols = {
              error = icons.diagnostics.Error,
              warn = icons.diagnostics.Warn,
              info = icons.diagnostics.Info,
              hint = icons.diagnostics.Hint,
            },
          },
          { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
          { "filename", path = 1 },
        },
      },
    },
  },
}
