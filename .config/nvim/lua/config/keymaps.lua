-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("i", "jk", "<ESC>", { desc = "Exit to normal mode" })
vim.keymap.set("i", "kj", "<ESC>", { desc = "Exit to normal mode" })
vim.keymap.set("n", ";", ":", { desc = "Command mode" })
vim.keymap.set({ "n", "i" }, "<C-l>", "$", { desc = "Jump to end" })
vim.keymap.set({ "n", "i" }, "<C-h>", "^", { desc = "Jump to beginning" })
