return {
  {
    "folke/neoconf.nvim",
    cmd = "Neoconf",
    opts = {},
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = { "folke/neoconf.nvim" },
    opts = function(_, opts)
      opts.inlay_hints = { enabled = false }
      opts.servers = opts.servers or {}

      -- Per-project override: read `django_settings_module` from a project's
      -- `.neoconf.json` (e.g. ~/project/.neoconf.json). Falls back to
      -- djlsp's own auto-detection everywhere else.
      local mod = require("neoconf").get("djlsp.django_settings_module")
      if mod then
        opts.servers.djlsp = {
          init_options = {
            django_settings_module = mod,
          },
        }
      end
    end,
  },
}
