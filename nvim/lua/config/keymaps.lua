-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "<C-L>", "20zl")
vim.keymap.set("n", "<C-H>", "20zh")
vim.keymap.set("v", "<C-L>", "<Cmd>normal! 20zl<CR>20l")
vim.keymap.set("v", "<C-H>", "<Cmd>normal! 20zh<CR>20h")
