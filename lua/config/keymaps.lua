-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set({ "n", "x" }, "U", "<cmd>redo<cr>")
vim.keymap.set({ "n", "x" }, "gw", "*N", { desc = "Search word under cursor" })
-- Better viewing
vim.keymap.set("n", "n", "nzz")
vim.keymap.set("n", "N", "Nzz")
vim.keymap.set("n", "g,", "g,zvzz")
vim.keymap.set("n", "g;", "g;zvzz")

-- Scrolling
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Paste
vim.keymap.set("n", "]p", "o<Esc>p", { desc = "Paste below" })
vim.keymap.set("n", "]P", "O<Esc>p", { desc = "Paste above" })

-- Insert blank line
vim.keymap.set("n", "]<Space>", "o<Esc>")
vim.keymap.set("n", "[<Space>", "O<Esc>")

-- Auto indent
vim.keymap.set("n", "i", function()
  if #vim.fn.getline(".") == 0 then
    return [["_cc]]
  else
    return "i"
  end
end, { expr = true })
