return {
  {
    "folke/snacks.nvim",
    opts = {
      scroll = { enabled = false },
      picker = {
        exclude = {
          "**/migrations**/",
        },
        win = {
          input = {
            keys = {
              ["<a-e>"] = { "toggle_excluded", mode = { "i", "n" } },
            },
          },
        },
        toggles = {
          exclude_toggle = "e",
        },
        actions = {
          toggle_excluded = function(p)
            -- Store the initial excluded files as the default
            if not p.default_exclude then
              p.default_exclude = vim.deepcopy(p.opts.exclude)
            end

            if vim.deep_equal(p.opts.exclude, p.default_exclude) then
              -- Clear the excluded files list
              p.opts.exclude = {}
              -- Add the indicator character to the title
              p.opts["exclude_toggle"] = true
            else
              -- Restore the default excluded files list
              p.opts.exclude = vim.deepcopy(p.default_exclude)
              -- Remove the indicator character from the title
              p.opts["exclude_toggle"] = false
            end

            -- Refresh the picker to reflect the changes
            p:find(p.opts)
          end,
        },
      },
    },
  },
}
