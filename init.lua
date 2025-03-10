--[[
  Author: denast
  Initially forked from kickstart.nvim:
  https://github.com/nvim-lua/kickstart.nvim
--]]

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- Load configuration modules
require('config.options')  -- General Neovim options
require('config.keymaps')  -- Key mappings
require('config.autocmds') -- Autocommands

-- Bootstrap lazy.nvim
require('config.lazy')

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
