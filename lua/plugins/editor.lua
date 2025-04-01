-- Editor enhancement plugins
return {
  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  -- Git integration
  {
    'lewis6991/gitsigns.nvim',
    event = { "BufReadPost", "BufWritePost", "BufNewfile" },
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
    keys = {
      { '<leader>gb', function() require('gitsigns').blame_line() end, desc = 'Git Blame Line' },
      {
        '<leader>gB',
        function()
          local ok, gitlinker = pcall(require, 'gitlinker')
          if ok then
            gitlinker.get_buf_range_url('n', { action_callback = gitlinker.actions.open_in_browser })
          else
            vim.notify('Gitlinker not available', vim.log.levels.WARN)
          end
        end,
        mode = { 'n', 'x' },
        desc = 'Git Browse (open)'
      },
      {
        '<leader>gY',
        function()
          local ok, gitlinker = pcall(require, 'gitlinker')
          if ok then
            gitlinker.get_buf_range_url('n')
          else
            vim.notify('Gitlinker not available', vim.log.levels.WARN)
          end
        end,
        mode = { 'n', 'x' },
        desc = 'Git Browse (copy)'
      },
    },
  },

  -- NOTE: Plugins can also be configured to run Lua code when they are loaded.
  --
  -- This is often very useful to both group configuration, as well as handle
  -- lazy loading plugins that don't need to be loaded immediately at startup.
  --
  -- For example, in the following configuration, we use:
  --  event = 'VimEnter'
  --
  -- which loads which-key before all the UI elements are loaded. Events can be
  -- normal autocommands events (`:help autocmd-events`).
  --
  -- Then, because we use the `opts` key (recommended), the configuration runs
  -- after the plugin has been loaded as `require(MODULE).setup(opts)`.

  { -- Useful plugin to show you pending keybinds.
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts_extend = { "spec" },
    opts = {
      preset = "helix",
      defaults = {},
      spec = {
        {
          mode = { "n", "v" },
          { "<leader>e", desc = "File [E]xplorer" },
          { "<leader><tab>", group = "Tabs" },
          { "<leader>c", group = "[C]ode" },
          { "<leader>f", group = "[F]ile" },
          { "<leader>g", group = "[G]it" },
          { "<leader>q", group = "[Q]uit" },
          { "<leader>s", group = "[S]earch" },
          { "<leader>u", group = "[U]i", icon = { icon = "󰙵 ", color = "cyan" } },
          { "<leader>x", group = "[X]diagnostics/quickfix", icon = { icon = "󱖫 ", color = "green" } },
          {
            "<leader>b",
            group = "buffer",
            expand = function()
              return require("which-key.extras").expand.buf()
            end,
          },
          {
            "<leader>w",
            group = "windows",
            proxy = "<c-w>",
            expand = function()
              return require("which-key.extras").expand.win()
            end,
          },
          -- better descriptions
          { "gx", desc = "Open with system app" },
        },
      },
    },
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Keymaps (which-key)",
      },
      {
        "<c-w><space>",
        function()
          require("which-key").show({ keys = "<c-w>", loop = true })
        end,
        desc = "Window Hydra Mode (which-key)",
      },
    },
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)
      if not vim.tbl_isempty(opts.defaults) then
        LazyVim.warn("which-key: opts.defaults is deprecated. Please use opts.spec instead.")
        wk.register(opts.defaults)
      end
    end,
  },
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs', -- Sets main module to use for opts
    keys = {
      {
        '<leader>uT',
        function()
          if vim.b.ts_highlight then
            vim.treesitter.stop()
            vim.notify('Treesitter highlight disabled')
          else
            vim.treesitter.start()
            vim.notify('Treesitter highlight enabled')
          end
          vim.b.ts_highlight = not vim.b.ts_highlight
        end,
        desc = 'Toggle Treesitter Highlight'
      },
    },
    -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
    opts = {
      ensure_installed = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc' },
      -- Autoinstall languages that are not installed
      auto_install = true,
      highlight = {
        enable = true,
        -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
        --  If you are experiencing weird indenting issues, add the language to
        --  the list of additional_vim_regex_highlighting and disabled languages for indent.
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = { enable = true, disable = { 'ruby' } },
    },
    -- There are additional nvim-treesitter modules that you can use to interact
    -- with nvim-treesitter. You should go explore a few and see what interests you:
    --
    --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
    --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
    --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
  }
}
