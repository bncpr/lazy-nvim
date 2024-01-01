-- every spec file under the "plugins" directory will be loaded automatically by lazy.nvim
--
-- In your plugin files, you can:
-- * add extra plugins
-- * disable/enabled LazyVim plugins
-- * override the configuration of LazyVim plugins
return {
  --
  --   -- change trouble config
  --   {
  --     "folke/trouble.nvim",
  --     -- opts will be merged with the parent spec
  --     opts = { use_diagnostic_signs = true },
  --   },
  --
  --   -- disable trouble
  --   { "folke/trouble.nvim", enabled = false },
  --
  -- add symbols-outline
  -- {
  --   "simrat39/symbols-outline.nvim",
  --   cmd = "SymbolsOutline",
  --   keys = { { "<leader>cs", "<cmd>SymbolsOutline<cr>", desc = "Symbols Outline" } },
  --   config = true,
  -- },
  --
  --   -- override nvim-cmp and add cmp-emoji
  --   {
  --     "hrsh7th/nvim-cmp",
  --     dependencies = { "hrsh7th/cmp-emoji" },
  --     ---@param opts cmp.ConfigSchema
  --     opts = function(_, opts)
  --       table.insert(opts.sources, { name = "emoji" })
  --     end,
  --   },
  --
  -- change some telescope options and a keymap to browse plugin files
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      -- add a keymap to browse plugin files
      -- stylua: ignore
      {
        "<leader>fp",
        function() require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root }) end,
        desc = "Find Plugin File",
      },
    },
    -- change some options
    -- opts = {
    --   defaults = {
    --     layout_strategy = "horizontal",
    --     layout_config = { prompt_position = "top" },
    --     sorting_strategy = "ascending",
    --     winblend = 0,
    --   },
    -- },
  },

  -- add telescope-fzf-native
  {
    "telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      config = function()
        require("telescope").load_extension("fzf")
      end,
    },
  },
  --
  -- add pyright to lspconfig
  {
    "neovim/nvim-lspconfig",
    init = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      -- change a keymap
      -- keys[#keys + 1] = { "K", "<cmd>echo 'hello'<cr>" }
      -- disable a keymap
      -- keys[#keys + 1] = { "K", false }
      -- add a keymap
      -- keys[#keys + 1] = { "H", "<cmd>echo 'hello'<cr>" }
      keys[#keys + 1] = {
        "<leader>ca",
        function()
          require("actions-preview").code_actions()
        end,
      }
    end,
    opts = {
      -- LSP Server Settings
      servers = {
        pylsp = {
          mason = false,
          keys = {
            {
              "<leader>co",
              function()
                vim.lsp.buf.code_action({
                  apply = true,
                  context = {
                    only = { "source.organizeImports" },
                    diagnostics = {},
                  },
                })
              end,
              desc = "Organize Imports",
            },
          },
          plugins = {
            pycodestyle = {
              -- ignore = { "W391" },
              -- maxLineLength = 100,
              enabled = false,
            },
            flake8 = { enabled = false },
            autopep8 = { enabled = false },
            mccabe = { enabled = false },
            pyflakes = { enabled = false },
            pylint = { enabled = false },
            yapf = { enabled = false },
            ruff = { enabled = true, lineLength = 120 },
            isort = { enabled = true },
            rope_autoimport = { enabled = true },
          },
        },
      },
      setup = {
        -- pylsp = function()
        --   require("lazyvim.util").lsp.on_attach(function(client, _)
        --     if client.name == "pylsp" then
        --       vim.lsp.set_log_level("trace")
        --       if vim.fn.has("nvim-0.5.1") == 1 then
        --         require("vim.lsp.log").set_format_func(vim.inspect)
        --       end
        --     end
        --   end)
        -- end,
      },
    },
  },
  --
  --   -- add tsserver and setup with typescript.nvim instead of lspconfig
  --   {
  --     "neovim/nvim-lspconfig",
  --     dependencies = {
  --       "jose-elias-alvarez/typescript.nvim",
  --       init = function()
  --         require("lazyvim.util").on_attach(function(_, buffer)
  --           -- stylua: ignore
  --           vim.keymap.set( "n", "<leader>co", "TypescriptOrganizeImports", { buffer = buffer, desc = "Organize Imports" })
  --           vim.keymap.set("n", "<leader>cR", "TypescriptRenameFile", { desc = "Rename File", buffer = buffer })
  --         end)
  --       end,
  --     },
  --     ---@class PluginLspOpts
  --     opts = {
  --       ---@type lspconfig.options
  --       servers = {
  --         -- tsserver will be automatically installed with mason and loaded with lspconfig
  --         tsserver = {},
  --       },
  --       -- you can do any additional lsp server setup here
  --       -- return true if you don't want this server to be setup with lspconfig
  --       ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
  --       setup = {
  --         -- example to setup with typescript.nvim
  --         tsserver = function(_, opts)
  --           require("typescript").setup({ server = opts })
  --           return true
  --         end,
  --         -- Specify * to use this function as a fallback for any server
  --         -- ["*"] = function(server, opts) end,
  --       },
  --     },
  --   },
  --
  --   -- for typescript, LazyVim also includes extra specs to properly setup lspconfig,
  --   -- treesitter, mason and typescript.nvim. So instead of the above, you can use:
  --   { import = "lazyvim.plugins.extras.lang.typescript" },
  --
  -- add more treesitter parsers
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "tsx",
        "typescript",
        "vim",
        "yaml",
        "c",
        "cpp",
        "go",
      },
    },
  },

  --   -- since `vim.tbl_deep_extend`, can only merge tables and not lists, the code above
  --   -- would overwrite `ensure_installed` with the new value.
  --   -- If you'd rather extend the default config, use the code below instead:
  --   {
  --     "nvim-treesitter/nvim-treesitter",
  --     opts = function(_, opts)
  --       -- add tsx and treesitter
  --       vim.list_extend(opts.ensure_installed, {
  --         "tsx",
  --         "typescript",
  --       })
  --     end,
  --   },
  --
  --   -- the opts function can also be used to change the default opts:
  --   {
  --     "nvim-lualine/lualine.nvim",
  --     event = "VeryLazy",
  --     opts = function(_, opts)
  --       table.insert(opts.sections.lualine_x, "😄")
  --     end,
  --   },
  --
  --   -- or you can return new options to override all the defaults
  --   {
  --     "nvim-lualine/lualine.nvim",
  --     event = "VeryLazy",
  --     opts = function()
  --       return {
  --         --[[add your custom lualine config here]]
  --       }
  --     end,
  --   },
  --
  --   -- use mini.starter instead of alpha
  --   { import = "lazyvim.plugins.extras.ui.mini-starter" },
  --
  -- add jsonls and schemastore packages, and setup treesitter for json, json5 and jsonc
  -- { import = "lazyvim.plugins.extras.lang.json" },
  --
  --   -- add any tools you want to have installed below
  --   {
  --     "williamboman/mason.nvim",
  --     opts = {
  --       ensure_installed = {
  --         "stylua",
  --         "shellcheck",
  --         "shfmt",
  --         "flake8",
  --       },
  --     },
  --   },
  --
}
