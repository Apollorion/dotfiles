return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "github/copilot.vim",
    lazy = false,
  },

  -- test new blink
  -- { import = "nvchad.blink.lazyspec" },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "html",
        "css",
        "terraform",
      },
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
    },
  },

  -- {
  --   "RRethy/vim-illuminate",
  --   event = "VeryLazy",
  --   config = function()
  --     require("illuminate").configure {
  --       providers = {
  --         "lsp",
  --         "treesitter",
  --         "regex",
  --       },
  --       delay = 100,
  --       filetype_overrides = {},
  --       filetypes_denylist = {
  --         "dirvish",
  --         "fugitive",
  --         "alpha",
  --         "NvimTree",
  --         "lazy",
  --         "neogitstatus",
  --         "Trouble",
  --         "lir",
  --         "Outline",
  --         "spectre_panel",
  --         "toggleterm",
  --         "DressingSelect",
  --         "TelescopePrompt",
  --       },
  --       under_cursor = true,
  --     }
  --   end,
  -- },

  {
    "rmagatti/auto-session",
    lazy = false,

    ---enables autocomplete for opts
    ---@module "auto-session"
    ---@type AutoSession.Config
    opts = {
      suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
      -- log_level = 'debug',
    },
  },

  { "kosayoda/nvim-lightbulb" },

  { "lewis6991/gitsigns.nvim" },

  {
    "zbirenbaum/neodim",
    event = "LspAttach",
    config = function()
      require("neodim").setup {
        hide = {
          virtual_text = false,
          signs = false,
          underline = false,
        },
      }
    end,
  },

  -- {
  --   "ray-x/navigator.lua",
  --   dependencies = {
  --     { "ray-x/guihua.lua", run = "cd lua/fzy && make" },
  --     { "neovim/nvim-lspconfig" },
  --   },
  --   event = "LspAttach",
  --   config = function()
  --     require("navigator").setup()
  --   end,
  -- },

  {
    "ray-x/navigator.lua",
    dependencies = {
      { "ray-x/guihua.lua", build = "cd lua/fzy && make" },
      { "neovim/nvim-lspconfig" },
    },
    lazy = false, -- Load immediately, not on LspAttach
    priority = 1000, -- High priority
    config = function()
      require("navigator").setup {
        debug = false, -- Enable debug mode
        lsp = {
          disable_lsp = false,
        },
      }
    end,
  },

  {
    "romgrk/barbar.nvim",
    dependencies = {
      "lewis6991/gitsigns.nvim", -- OPTIONAL: for git status
      "nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
    },
    init = function()
      vim.g.barbar_auto_setup = false
    end,
    event = "VimEnter",
    opts = {
      -- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
      -- animation = true,
      -- insert_at_start = true,
      -- …etc.
    },
    version = "^1.0.0", -- optional: only update when a new 1.x version is released
  },

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "SmiteshP/nvim-navbuddy",
        dependencies = {
          "SmiteshP/nvim-navic",
          "MunifTanjim/nui.nvim",
        },
        opts = { lsp = { auto_attach = true } },
      },
    },
    -- your lsp config or other stuff
  },

  -- Three-way merge and conflict resolution
  {
    "sindrets/diffview.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    lazy = false,
    config = function()
      require("diffview").setup {
        enhanced_diff_hl = true,
        view = {
          default = {
            layout = "diff2_horizontal",
          },
          merge_tool = {
            layout = "diff3_horizontal", -- 3-way merge layout
            disable_diagnostics = true,
            winbar_info = true,
          },
        },
        file_panel = {
          listing_style = "tree",
          tree_options = {
            flatten_dirs = true,
            folder_statuses = "only_folded",
          },
        },
        hooks = {
          diff_buf_read = function(bufnr)
            -- Keymaps for merge conflicts
            vim.keymap.set("n", "<leader>co", "<cmd>diffget //2<CR>", { buffer = bufnr, desc = "Get from ours" })
            vim.keymap.set("n", "<leader>ct", "<cmd>diffget //3<CR>", { buffer = bufnr, desc = "Get from theirs" })
          end,
        },
      }
    end,
  },
  {
    "akinsho/git-conflict.nvim",
    version = "*",
    config = function()
      require("git-conflict").setup {
        default_mappings = true,
        default_commands = true,
        disable_diagnostics = false,
        list_opener = "copen",
        highlights = {
          incoming = "DiffAdd",
          current = "DiffText",
        },
      }
    end,
  },
  {
    "tpope/vim-fugitive",
  },
}
