-- Language servers don't understand Django's lazy model references like
-- `ForeignKey("app_label.Model")` (or `"Model"` for the same app), so `gd` on them
-- finds nothing. Resolve them by hand: grep the app's models for `class Model`.
-- Assumes the app label matches the app's directory name (Django's default).
-- Returns false when the cursor isn't on such a string, so `gd` can fall back to the LSP.
local function goto_django_model()
  if vim.bo.filetype ~= "python" then
    return false
  end
  local ok, node = pcall(vim.treesitter.get_node)
  while ok and node and node:type() ~= "string" do
    node = node:parent()
  end
  if not (ok and node) then
    return false
  end

  local str = vim.treesitter.get_node_text(node, 0):match("^%a*['\"]+(.-)['\"]+$") or ""
  local app, model = str:match("^([%w_]+)%.(%u[%w_]*)$")
  if not app then
    model = str:match("^%u[%w_]*$")
    if not model then
      return false
    end
    -- Same-app reference: the app is the dir holding models.py (or the models/ package)
    local dir = vim.fs.dirname(vim.api.nvim_buf_get_name(0))
    app = vim.fs.basename(vim.fs.basename(dir) == "models" and vim.fs.dirname(dir) or dir)
  end

  local root = vim.fs.root(0, { "manage.py", ".git" }) or vim.fn.getcwd()
  local hits = vim.fn.systemlist({
    "rg",
    "--vimgrep",
    "-g",
    "**/" .. app .. "/models.py",
    "-g",
    "**/" .. app .. "/models/*.py",
    "^\\s*class " .. model .. "\\b",
    root,
  })
  local file, lnum, col = (hits[1] or ""):match("^(.-):(%d+):(%d+):")
  if not file then
    vim.notify(("Couldn't find model `%s` in app `%s`"):format(model, app), vim.log.levels.WARN)
    return true
  end
  vim.cmd("normal! m'") -- so <C-o> jumps back
  vim.cmd.edit(vim.fn.fnameescape(file))
  vim.api.nvim_win_set_cursor(0, { tonumber(lnum), tonumber(col) - 1 })
  return true
end

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

      -- Overrides LazyVim's `gd` (same lhs, added later, so this one wins)
      opts.servers["*"] = opts.servers["*"] or {}
      opts.servers["*"].keys = opts.servers["*"].keys or {}
      table.insert(opts.servers["*"].keys, {
        "gd",
        function()
          if not goto_django_model() then
            Snacks.picker.lsp_definitions()
          end
        end,
        desc = "Goto Definition",
        has = "definition",
      })

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
