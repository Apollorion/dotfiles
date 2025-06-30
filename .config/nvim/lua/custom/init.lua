vim.opt.number = true -- Show absolute line numbers
vim.opt.relativenumber = true -- Also show relative numbers

vim.api.nvim_create_user_command("Tree", function()
  vim.cmd "NvimTreeToggle"
end, {})

vim.g.copilot_no_tab_map = true
vim.keymap.set("i", "gha", 'copilot#Accept("\\<CR>")', { expr = true, replace_keycodes = false })
vim.keymap.set("i", "ghp", "copilot#Previous()", { expr = true, replace_keycodes = false })
vim.keymap.set("i", "ghn", "copilot#Next()", { expr = true, replace_keycodes = false })
vim.keymap.set("i", "ghd", "copilot#Dismiss()", { expr = true, replace_keycodes = false })

vim.keymap.set("n", "bp", ":BufferPick<CR>", { noremap = true, silent = true, desc = "Pick a buffer" })

vim.keymap.set("n", "<leader>[", "<C-o>", { desc = "Jump back" })
vim.keymap.set("n", "<leader>]", "<C-i>", { desc = "Jump forward" })

-- Configure which-key for better help display
local wk_ok, wk = pcall(require, "which-key")
if wk_ok then
  wk.add {
    { "<leader>[", "<C-o>", desc = "󰁍 Jump back in jump list" },
    { "<leader>]", "<C-i>", desc = "󰁔 Jump forward in jump list" },
  }
end

require("nvim-lightbulb").setup {
  autocmd = { enabled = true },
}

require("gitsigns").setup {}

-- Ensure navigator keymaps are always set after LSP attach
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local bufnr = args.buf
    
    -- Always set navigator keymap when LSP attaches
    vim.keymap.set('n', 'gr', function()
      require('navigator.reference').reference()
    end, { buffer = bufnr, desc = 'Navigator references', silent = true })
    
    vim.keymap.set('n', 'gd', function()
      require('navigator.definition').definition()
    end, { buffer = bufnr, desc = 'Navigator definition', silent = true })
  end,
})

require("custom.cheatsheet")

-- Delete operations go to black hole register (don't go to clipboard)
vim.keymap.set("n", "d", '"_d', { noremap = true })
vim.keymap.set("n", "D", '"_D', { noremap = true })
vim.keymap.set("n", "dd", '"_dd', { noremap = true })
vim.keymap.set("v", "d", '"_d', { noremap = true })

-- Change operations go to black hole register (don't go to clipboard)
vim.keymap.set("n", "c", '"_c', { noremap = true })
vim.keymap.set("n", "C", '"_C', { noremap = true })
vim.keymap.set("n", "cc", '"_cc', { noremap = true })
vim.keymap.set("v", "c", '"_c', { noremap = true })

vim.api.nvim_create_user_command('Mk', function(opts)
  if not opts.args or opts.args == "" then
    vim.notify("Error: No filename provided", vim.log.levels.ERROR)
    return
  end
  vim.cmd("edit " .. vim.fn.fnameescape(opts.args))
  vim.cmd("write ++p")
end, {
  desc = 'Create directories and write file (:write ++p wrapper)',
  nargs = 1,
  complete = 'file',
})
