return {
  -- JSON schemas for better JSON editing (package.json, tsconfig.json, etc.)
  {
    "b0o/schemastore.nvim",
    ft = { "json", "jsonc" },
  },
  
  -- Emmet for HTML/JSX expansion
  {
    "mattn/emmet-vim",
    ft = { "html", "css", "javascript", "typescript", "javascriptreact", "typescriptreact" },
    config = function()
      vim.g.user_emmet_leader_key = '<C-z>'
      vim.g.user_emmet_settings = {
        javascript = {
          extends = 'jsx',
        },
        typescript = {
          extends = 'tsx',
        },
      }
    end,
  },
  
  -- Better syntax highlighting for TypeScript and JSX
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, {
          "typescript",
          "tsx",
          "javascript",
          "jsdoc",
          "json",
          "html",
          "css",
          "dockerfile",
        })
      end
    end,
  },
  
  -- Package.json management
  {
    "vuki656/package-info.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    ft = "json",
    config = function()
      require("package-info").setup({
        colors = {
          up_to_date = "#3C4048",
          outdated = "#fc7b7b",
        },
        icons = {
          enable = true,
          style = {
            up_to_date = "|  ",
            outdated = "|  ",
          },
        },
        autostart = true,
        hide_up_to_date = false,
        hide_unstable_versions = false,
      })
    end,
  },
} 