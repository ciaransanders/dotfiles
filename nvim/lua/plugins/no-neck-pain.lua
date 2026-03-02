return {
  {
    "shortcuts/no-neck-pain.nvim",
    enabled = false,
    opts = {
      width = 140,
      autocmds = {
        enableOnVimEnter = true,
        enableOnTabEnter = true,
        skipEnteringNoNeckPainBuffer = true,
      },
      integrations = {
        dashboard = {
          enabled = true,
        },
      },
    },
  },
}
