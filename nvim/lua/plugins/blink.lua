return {
  {
    "saghen/blink.cmp",
    opts = {
      completion = {
        -- Disable automatic selection of the first item
        list = {
          selection = {
            preselect = false,
            auto_insert = false,
          },
        },
      },
      cmdline = {
        completion = {
          menu = {
            auto_show = false, -- don't show auto completion suggestions in command mode by default
          },
        },
      },
    },
  },
}
