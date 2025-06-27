-- vim.opt.number = true         -- Show absolute line numbers
vim.opt.relativenumber = true -- Also show relative numbers

vim.api.nvim_create_user_command("Tree", function()
  vim.cmd("NvimTreeToggle")
end, {})

vim.g.copilot_no_tab_map = true
vim.keymap.set('i', 'gha', 'copilot#Accept("\\<CR>")', { expr = true, replace_keycodes = false })
vim.keymap.set('i', 'ghp', 'copilot#Previous()', { expr = true, replace_keycodes = false })
vim.keymap.set('i', 'ghn', 'copilot#Next()', { expr = true, replace_keycodes = false })
vim.keymap.set('i', 'ghd', 'copilot#Dismiss()', { expr = true, replace_keycodes = false })


-- Delete operations go to black hole register (don't go to clipboard)
vim.keymap.set('n', 'd', '"_d', { noremap = true })
vim.keymap.set('n', 'D', '"_D', { noremap = true })
vim.keymap.set('n', 'dd', '"_dd', { noremap = true })
vim.keymap.set('v', 'd', '"_d', { noremap = true })

-- Change operations go to black hole register (don't go to clipboard)
vim.keymap.set('n', 'c', '"_c', { noremap = true })
vim.keymap.set('n', 'C', '"_C', { noremap = true })
vim.keymap.set('n', 'cc', '"_cc', { noremap = true })
vim.keymap.set('v', 'c', '"_c', { noremap = true })

vim.keymap.set('n', '<leader>[', '<C-o>', { desc = 'Jump back' })
vim.keymap.set('n', '<leader>]', '<C-i>', { desc = 'Jump forward' })

-- Configure which-key for better help display
local wk_ok, wk = pcall(require, "which-key")
if wk_ok then
  wk.register({
    ["["] = { "<C-o>", "󰁍 Jump back in jump list" },
    ["]"] = { "<C-i>", "󰁔 Jump forward in jump list" },
  }, { prefix = "<leader>" })
end
