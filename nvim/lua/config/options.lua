-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Use basedpyright instead of pyright for python LSP
vim.g.lazyvim_python_lsp = "basedpyright"

-- Search recursively in subdirectories
vim.opt.path:append("**")

-- Disable automatic comment continuation when entering a new line after a comment
vim.opt.formatoptions:remove({ "c", "r", "o" })

-- Type "cc" for CodeCompanion shortcut
vim.cmd([[cab cc CodeCompanion]])
