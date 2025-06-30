require("nvchad.configs.lspconfig").defaults()

vim.lsp.config['tofu'] = {
  cmd = { 'tofu-ls-wrapper' },
  filetypes = { 'terraform' },
  get_language_id = function(_, _)
    return 'opentofu'
  end,
  root_markers = { '.terraform', '.git' }
}

local servers = { "tofu", "gopls" }
vim.lsp.enable(servers)
