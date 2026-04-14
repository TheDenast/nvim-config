-- Extra or experimental plugins
return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown", "norg", "org", "codecompanion" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      heading = {
        icons = { "󰎤 ", "󰎧 ", "󰎪 ", "󰎭 ", "󰎱 ", "󰎳 " },
      },
      code = {
        sign = false,
        width = "block",
        right_pad = 1,
      },
      checkbox = {
        unchecked = { icon = "󰄱 " },
        checked = { icon = "󰱒 " },
        custom = {
          todo = { raw = "[-]", rendered = "󰥔 ", highlight = "RenderMarkdownTodo" },
        },
      },
      bullet = {
        icons = { "●", "○", "◆", "◇" },
      },
    },
    keys = {
      { "<leader>um", "<cmd>RenderMarkdown toggle<cr>", desc = "Toggle Markdown Render" },
    },
  },
  { -- funny plugin to create an accumulating snowfall effect over your code
    "marcussimonsen/let-it-snow.nvim",
    cmd = "LetItSnow", -- Wait with loading until command is run
    opts = {},
  },
  {
    "karb94/neoscroll.nvim",
    opts = {},
  },
  {
    "wakatime/vim-wakatime",
    lazy = false,
    config = function()
      vim.g.wakatime_CLIPath = os.getenv("HOME") .. "/.wakatime/wakatime-cli"
    end,
  },
}
