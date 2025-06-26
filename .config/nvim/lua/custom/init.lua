vim.opt.number = true         -- Show absolute line numbers
vim.opt.relativenumber = true -- Also show relative numbers

vim.api.nvim_create_user_command("Tree", function()
  vim.cmd("NvimTreeToggle")
end, {})

vim.api.nvim_create_user_command("Terminal", function()
  vim.cmd("split")
  vim.cmd("terminal")
end, {})

