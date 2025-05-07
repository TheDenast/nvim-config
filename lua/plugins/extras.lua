-- Extra or experimental plugins
-- hello world! hello world!
return {
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
