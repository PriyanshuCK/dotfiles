-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "<leader>r", function()
  vim.cmd("w")
  vim.cmd("vsplit | terminal g++ -std=c++17 -O2 -Wall % && ./a.out < input.txt")
end, { desc = "Compile & Run C++" })
