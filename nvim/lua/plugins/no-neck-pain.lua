return {
  {
    "shortcuts/no-neck-pain.nvim",
    opts = {
      width = 130,
      autocmds = {
        enableOnVimEnter = true,
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
