-- Telescope fuzzy finder
return {
  -- NOTE: Plugins can specify dependencies.
  --
  -- The dependencies are proper plugin specifications as well - anything
  -- you do for a plugin at the top level, you can do for a dependency.
  --
  -- Use the `dependencies` key to specify the dependencies of a particular plugin

  { -- Fuzzy Finder (files, lsp, etc)
    "nvim-telescope/telescope.nvim",
    event = "VimEnter",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { -- If encountering errors, see telescope-fzf-native README for installation instructions
        "nvim-telescope/telescope-fzf-native.nvim",

        -- `build` is used to run some command when the plugin is installed/updated.
        -- This is only run then, not every time Neovim starts up.
        build = "make",

        -- `cond` is a condition used to determine whether this plugin should be
        -- installed and loaded.
        cond = function()
          return vim.fn.executable("make") == 1
        end,
      },
      { "nvim-telescope/telescope-ui-select.nvim" },

      -- Useful for getting pretty icons, but requires a Nerd Font.
      { "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
    },
    keys = {
      -- Basic telescope keymaps
      {
        "<leader>sh",
        function()
          require("telescope.builtin").help_tags()
        end,
        desc = "[H]elp",
      },
      {
        "<leader>sk",
        function()
          require("telescope.builtin").keymaps()
        end,
        desc = "[K]eymaps",
      },
      {
        "<leader>sf",
        function()
          require("telescope.builtin").find_files()
        end,
        desc = "[F]iles",
      },
      {
        "<leader>ss",
        function()
          require("telescope.builtin").builtin()
        end,
        desc = "[S]elect Telescope",
      },
      {
        "<leader>sw",
        function()
          require("telescope.builtin").grep_string()
        end,
        desc = "[W]ord",
      },
      {
        "<leader>sg",
        function()
          require("telescope.builtin").live_grep()
        end,
        desc = "[G]rep",
      },
      {
        "<leader>sd",
        function()
          require("telescope.builtin").diagnostics()
        end,
        desc = "[D]iagnostics",
      },
      {
        "<leader>sr",
        function()
          require("telescope.builtin").resume()
        end,
        desc = "[R]esume",
      },
      {
        "<leader>s.",
        function()
          require("telescope.builtin").oldfiles()
        end,
        desc = 'Recent Files ("." for repeat)',
      },
      {
        "<leader><leader>",
        function()
          require("telescope.builtin").buffers()
        end,
        desc = "[ ] Find existing buffers",
      },

      -- Fuzzy search in current buffer
      {
        "<leader>/",
        function()
          require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
            winblend = 10,
            previewer = false,
          }))
        end,
        desc = "[/] Fuzzily search in current buffer",
      },

      -- Search in open files
      {
        "<leader>s/",
        function()
          require("telescope.builtin").live_grep({
            grep_open_files = true,
            prompt_title = "Live Grep in Open Files",
          })
        end,
        desc = "[S]earch [/] in Open Files",
      },

      -- Search neovim config files
      {
        "<leader>sn",
        function()
          require("telescope.builtin").find_files({ cwd = vim.fn.stdpath("config") })
        end,
        desc = "[S]earch [N]eovim files",
      },
    },
    config = function()
      -- Telescope is a fuzzy finder that comes with a lot of different things that
      -- it can fuzzy find! It's more than just a "file finder", it can search
      -- many different aspects of Neovim, your workspace, LSP, and more!
      --
      -- The easiest way to use Telescope, is to start by doing something like:
      --  :Telescope help_tags
      --
      -- After running this command, a window will open up and you're able to
      -- type in the prompt window. You'll see a list of `help_tags` options and
      -- a corresponding preview of the help.
      --
      -- Two important keymaps to use while in Telescope are:
      --  - Insert mode: <c-/>
      --  - Normal mode: ?
      --
      -- This opens a window that shows you all of the keymaps for the current
      -- Telescope picker. This is really useful to discover what Telescope can
      -- do as well as how to actually do it!

      -- [[ Configure Telescope ]]
      -- See `:help telescope` and `:help telescope.setup()`
      require("telescope").setup({
        -- You can put your default mappings / updates / etc. in here
        --  All the info you're looking for is in `:help telescope.setup()`
        --
        -- defaults = {
        --   mappings = {
        --     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
        --   },
        -- },
        -- pickers = {}
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown(),
          },
        },
      })

      -- Enable Telescope extensions if they are installed
      pcall(require("telescope").load_extension, "fzf")
      pcall(require("telescope").load_extension, "ui-select")
    end,
  },
}

