return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    opts = {
      heading = {
        sign = true,
        position = "inline",
        icons = {
          "󰼏 ",
          " 󰼐 ",
          "  󰼑 ",
          "   󰼒 ",
          "    󰼓 ",
          "     󰼔 ",
        },
        width = "block",
        left_pad = 1,
        right_pad = 1,
      },
      checkbox = {
        enabled = true,
      },
      -- Always show HTML comments (e.g. <!-- TODO -->) instead of hiding them off the cursor line
      html = {
        comment = { conceal = false },
      },
    },
  },
}
