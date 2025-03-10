--[[ Keymap Prefix Organization
  <leader>s - Search operations (Telescope)
  <leader>c - Code operations (LSP, formatting)
  <leader>b - Buffer operations
  <leader>w - Window operations
  <leader>f - File operations
  <leader>g - Git operations
  <leader>u - UI toggles
  <leader>x - Lists (quickfix, location)
  <leader><tab> - Tab operations
--]]

-- Near the top of your keymaps.lua:
local wk_ok, wk = pcall(require, "which-key")
if wk_ok then
  wk.register({
    ["<leader>"] = {
      s = { name = "[S]earch" },
      c = { name = "[C]ode" },
      b = { name = "[B]uffer" },
      w = { name = "[W]indow" },
      f = { name = "[F]ile" },
      g = { name = "[G]it" },
      u = { name = "[U]I Toggle" },
      x = { name = "Lists" },
      ["<tab>"] = { name = "Tabs" },
    }
  })
end

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`
local map = vim.keymap.set

-- [[ Basic Keymaps ]]
-- Set <space> as the leader key
-- See `:help mapleader`
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
map('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- TIP: Disable arrow keys in normal mode
map('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
map('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
map('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
map('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')


-- Basic navigation (these are defaults but included for completeness)
map({ 'n', 'x' }, 'j', 'j', { desc = 'Down' })
map({ 'n', 'x' }, '<Down>', '<Down>', { desc = 'Down' })
map({ 'n', 'x' }, 'k', 'k', { desc = 'Up' })
map({ 'n', 'x' }, '<Up>', '<Up>', { desc = 'Up' })

-- Window navigation
map('n', '<C-h>', '<C-w>h', { desc = 'Go to Left Window' })
map('n', '<C-j>', '<C-w>j', { desc = 'Go to Lower Window' })
map('n', '<C-k>', '<C-w>k', { desc = 'Go to Upper Window' })
map('n', '<C-l>', '<C-w>l', { desc = 'Go to Right Window' })

-- Window resizing
map('n', '<C-Up>', '<cmd>resize +2<CR>', { desc = 'Increase Window Height' })
map('n', '<C-Down>', '<cmd>resize -2<CR>', { desc = 'Decrease Window Height' })
map('n', '<C-Left>', '<cmd>vertical resize -2<CR>', { desc = 'Decrease Window Width' })
map('n', '<C-Right>', '<cmd>vertical resize +2<CR>', { desc = 'Increase Window Width' })

-- Move lines
-- NOTE: These may conflict with OS/terminal shortcuts
map({ 'n', 'i', 'v' }, '<A-j>', function()
  if vim.fn.mode() == 'i' then
    return '<Esc><cmd>m .+1<CR>==gi'
  elseif vim.fn.mode() == 'n' then
    return '<cmd>m .+1<CR>=='
  else
    return ":m '>+1<CR>gv=gv"
  end
end, { expr = true, desc = 'Move Down' })

map({ 'n', 'i', 'v' }, '<A-k>', function()
  if vim.fn.mode() == 'i' then
    return '<Esc><cmd>m .-2<CR>==gi'
  elseif vim.fn.mode() == 'n' then
    return '<cmd>m .-2<CR>=='
  else
    return ":m '<-2<CR>gv=gv"
  end
end, { expr = true, desc = 'Move Up' })

-- Buffer navigation
map('n', '<S-h>', '<cmd>bprevious<CR>', { desc = 'Prev Buffer' })
map('n', '<S-l>', '<cmd>bnext<CR>', { desc = 'Next Buffer' })
map('n', '[b', '<cmd>bprevious<CR>', { desc = 'Prev Buffer' })
map('n', ']b', '<cmd>bnext<CR>', { desc = 'Next Buffer' })
map('n', '<leader>bb', '<cmd>e #<CR>', { desc = 'Switch to Other Buffer' })
map('n', '<leader>`', '<cmd>e #<CR>', { desc = 'Switch to Other Buffer' })

-- Buffer management
map('n', '<leader>bd', '<cmd>bd<CR>', { desc = 'Delete Buffer' })
map('n', '<leader>bo', '<cmd>%bd|e#|bd#<CR>', { desc = 'Delete Other Buffers' })
map('n', '<leader>bD', '<cmd>bd!<CR>', { desc = 'Delete Buffer and Window' })

-- Clear search with <Esc>
map({ 'i', 'n', 's' }, '<Esc>', function()
  if vim.fn.mode() == 'n' then
    vim.cmd('nohl')
  end
  return '<Esc>'
end, { expr = true, desc = 'Escape and Clear hlsearch' })

-- Clear search, diff update and redraw
map('n', '<leader>ur', '<cmd>nohlsearch<CR><cmd>diffupdate<CR><cmd>redraw<CR>', { desc = 'Redraw / Clear hlsearch / Diff Update' })

-- Better search navigation
map({ 'n', 'x', 'o' }, 'n', 'n', { desc = 'Next Search Result' })
map({ 'n', 'x', 'o' }, 'N', 'N', { desc = 'Prev Search Result' })

-- Save file
-- NOTE: <C-s> might be captured by terminal for flow control
map({ 'i', 'x', 'n', 's' }, '<C-s>', '<cmd>w<CR><Esc>', { desc = 'Save File' })

-- Better help access
map('n', '<leader>K', '<cmd>help <C-r><C-w><CR>', { desc = 'Keywordprg' })

-- Comments (requires a comment plugin like Comment.nvim)
map('n', 'gco', function()
  -- Check if Comment.nvim is available
  local ok, comment = pcall(require, 'Comment.api')
  if ok then
    comment.insert.linewise.below()
  else
    vim.notify('Comment.nvim not available', vim.log.levels.WARN)
  end
end, { desc = 'Add Comment Below' })

map('n', 'gcO', function()
  -- Check if Comment.nvim is available
  local ok, comment = pcall(require, 'Comment.api')
  if ok then
    comment.insert.linewise.above()
  else
    vim.notify('Comment.nvim not available', vim.log.levels.WARN)
  end
end, { desc = 'Add Comment Above' })

-- Lazy plugin manager
map('n', '<leader>l', '<cmd>Lazy<CR>', { desc = 'Lazy' })

-- File operations
map('n', '<leader>fn', '<cmd>enew<CR>', { desc = 'New File' })

-- Quickfix and Location list
map('n', '<leader>xl', '<cmd>lopen<CR>', { desc = 'Location List' })
map('n', '<leader>xq', '<cmd>copen<CR>', { desc = 'Quickfix List' })
map('n', '[q', '<cmd>cprevious<CR>', { desc = 'Previous Quickfix' })
map('n', ']q', '<cmd>cnext<CR>', { desc = 'Next Quickfix' })

-- Formatting
-- NOTE: This may conflict with your existing <leader>f mapping for telescope
map({ 'n', 'v' }, '<leader>cf', function()
  -- Check if conform.nvim is available
  local ok, conform = pcall(require, 'conform')
  if ok then
    conform.format({ async = true, lsp_format = 'fallback' })
  else
    vim.lsp.buf.format({ async = true })
  end
end, { desc = 'Format' })

-- Diagnostics
map('n', '<leader>cd', vim.diagnostic.open_float, { desc = 'Line Diagnostics' })
map('n', ']d', vim.diagnostic.goto_next, { desc = 'Next Diagnostic' })
map('n', '[d', vim.diagnostic.goto_prev, { desc = 'Prev Diagnostic' })

-- Go to next/prev error/warning
map('n', ']e', function()
  vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
end, { desc = 'Next Error' })
map('n', '[e', function()
  vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })
end, { desc = 'Prev Error' })
map('n', ']w', function()
  vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.WARN })
end, { desc = 'Next Warning' })
map('n', '[w', function()
  vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.WARN })
end, { desc = 'Prev Warning' })

-- Toggle options
-- Auto format
map('n', '<leader>uf', function()
  vim.g.autoformat = not vim.g.autoformat
  vim.notify('Global autoformat ' .. (vim.g.autoformat and 'enabled' or 'disabled'))
end, { desc = 'Toggle Auto Format (Global)' })

map('n', '<leader>uF', function()
  vim.b.autoformat = not vim.b.autoformat
  vim.notify('Buffer autoformat ' .. (vim.b.autoformat and 'enabled' or 'disabled'))
end, { desc = 'Toggle Auto Format (Buffer)' })

-- Spelling
map('n', '<leader>us', function()
  vim.opt.spell = not vim.opt.spell:get()
  vim.notify('Spell ' .. (vim.opt.spell:get() and 'enabled' or 'disabled'))
end, { desc = 'Toggle Spelling' })

-- Word wrap
map('n', '<leader>uw', function()
  vim.opt.wrap = not vim.opt.wrap:get()
  vim.notify('Wrap ' .. (vim.opt.wrap:get() and 'enabled' or 'disabled'))
end, { desc = 'Toggle Wrap' })

-- Line numbers
map('n', '<leader>uL', function()
  vim.opt.relativenumber = not vim.opt.relativenumber:get()
  vim.notify('Relative line numbers ' .. (vim.opt.relativenumber:get() and 'enabled' or 'disabled'))
end, { desc = 'Toggle Relative Number' })

map('n', '<leader>ul', function()
  vim.opt.number = not vim.opt.number:get()
  vim.notify('Line numbers ' .. (vim.opt.number:get() and 'enabled' or 'disabled'))
end, { desc = 'Toggle Line Numbers' })

-- Diagnostics
map('n', '<leader>ud', function()
  vim.diagnostic.config({ virtual_text = not vim.diagnostic.config().virtual_text })
  vim.notify('Diagnostics ' .. (vim.diagnostic.config().virtual_text and 'enabled' or 'disabled'))
end, { desc = 'Toggle Diagnostics' })

-- Conceal
map('n', '<leader>uc', function()
  local conceallevel = vim.opt.conceallevel:get()
  if conceallevel == 0 then
    vim.opt.conceallevel = 2
  else
    vim.opt.conceallevel = 0
  end
  vim.notify('Conceal level: ' .. vim.opt.conceallevel:get())
end, { desc = 'Toggle Conceal Level' })

-- Tabline
map('n', '<leader>uA', function()
  vim.opt.showtabline = vim.opt.showtabline:get() == 0 and 2 or 0
  vim.notify('Tabline ' .. (vim.opt.showtabline:get() == 2 and 'enabled' or 'disabled'))
end, { desc = 'Toggle Tabline' })

-- Treesitter highlight
map('n', '<leader>uT', function()
  if vim.b.ts_highlight then
    vim.treesitter.stop()
    vim.notify('Treesitter highlight disabled')
  else
    vim.treesitter.start()
    vim.notify('Treesitter highlight enabled')
  end
  vim.b.ts_highlight = not vim.b.ts_highlight
end, { desc = 'Toggle Treesitter Highlight' })

-- Background
map('n', '<leader>ub', function()
  if vim.opt.background:get() == 'dark' then
    vim.opt.background = 'light'
  else
    vim.opt.background = 'dark'
  end
  vim.notify('Background: ' .. vim.opt.background:get())
end, { desc = 'Toggle Dark Background' })

-- Git commands (requires a git plugin like gitsigns.nvim)
map('n', '<leader>gb', function()
  -- Check if gitsigns is available
  local ok, gitsigns = pcall(require, 'gitsigns')
  if ok then
    gitsigns.blame_line()
  else
    vim.notify('Gitsigns not available', vim.log.levels.WARN)
  end
end, { desc = 'Git Blame Line' })

map({ 'n', 'x' }, '<leader>gB', function()
  -- Check if gitlinker is available
  local ok, gitlinker = pcall(require, 'gitlinker')
  if ok then
    gitlinker.get_buf_range_url('n', { action_callback = gitlinker.actions.open_in_browser })
  else
    vim.notify('Gitlinker not available', vim.log.levels.WARN)
  end
end, { desc = 'Git Browse (open)' })

map({ 'n', 'x' }, '<leader>gY', function()
  -- Check if gitlinker is available
  local ok, gitlinker = pcall(require, 'gitlinker')
  if ok then
    gitlinker.get_buf_range_url('n')
  else
    vim.notify('Gitlinker not available', vim.log.levels.WARN)
  end
end, { desc = 'Git Browse (copy)' })

-- Quit
map('n', '<leader>qq', '<cmd>qa<CR>', { desc = 'Quit All' })

-- Inspect
map('n', '<leader>ui', function()
  local pos = vim.inspect(vim.fn.getpos('.'))
  local cursor = vim.fn.getcurpos()
  local bufnr = vim.api.nvim_get_current_buf()
  local line = vim.api.nvim_buf_get_lines(bufnr, cursor[2] - 1, cursor[2], false)[1]
  vim.notify(
    string.format(
      'Cursor: %s, Line: %s\nPosition: %s',
      vim.inspect(cursor),
      vim.inspect(line),
      pos
    )
  )
end, { desc = 'Inspect Pos' })

-- Terminal
map('n', '<leader>fT', function()
  vim.cmd('terminal')
  vim.cmd('startinsert')
end, { desc = 'Terminal (cwd)' })

map('n', '<leader>ft', function()
  -- Get the project root directory
  local root_dir = vim.fn.getcwd()
  vim.cmd('terminal')
  vim.cmd('startinsert')
  -- Change to root directory
  vim.api.nvim_chan_send(vim.b.terminal_job_id, 'cd ' .. root_dir .. '\n')
end, { desc = 'Terminal (Root Dir)' })

map('n', '<C-/>', function()
  -- Get the project root directory
  local root_dir = vim.fn.getcwd()
  vim.cmd('terminal')
  vim.cmd('startinsert')
  -- Change to root directory
  vim.api.nvim_chan_send(vim.b.terminal_job_id, 'cd ' .. root_dir .. '\n')
end, { desc = 'Terminal (Root Dir)' })

-- Hide terminal
map('t', '<C-/>', '<C-\\><C-n><cmd>hide<CR>', { desc = 'Hide Terminal' })

-- Window management
map('n', '<leader>-', '<cmd>split<CR>', { desc = 'Split Window Below' })
map('n', '<leader>|', '<cmd>vsplit<CR>', { desc = 'Split Window Right' })
map('n', '<leader>wd', '<cmd>close<CR>', { desc = 'Delete Window' })

-- Window zoom
map('n', '<leader>wm', function()
  -- Check if zoom.nvim is available
  local ok, zoom = pcall(require, 'zoom-toggle')
  if ok then
    zoom.toggle()
  else
    -- Fallback implementation
    if vim.t.zoomed then
      vim.cmd('wincmd =')
      vim.t.zoomed = false
    else
      vim.cmd('vertical resize | resize')
      vim.t.zoomed = true
    end
  end
end, { desc = 'Toggle Zoom Mode' })

map('n', '<leader>uZ', function()
  -- Check if zoom.nvim is available
  local ok, zoom = pcall(require, 'zoom-toggle')
  if ok then
    zoom.toggle()
  else
    -- Fallback implementation
    if vim.t.zoomed then
      vim.cmd('wincmd =')
      vim.t.zoomed = false
    else
      vim.cmd('vertical resize | resize')
      vim.t.zoomed = true
    end
  end
end, { desc = 'Toggle Zoom Mode' })

-- Zen mode
map('n', '<leader>uz', function()
  -- Check if zen-mode is available
  local ok, zen = pcall(require, 'zen-mode')
  if ok then
    zen.toggle()
  else
    vim.notify('Zen-mode not available', vim.log.levels.WARN)
  end
end, { desc = 'Toggle Zen Mode' })

-- Tab management
map('n', '<leader><tab>l', '<cmd>tablast<CR>', { desc = 'Last Tab' })
map('n', '<leader><tab>o', '<cmd>tabonly<CR>', { desc = 'Close Other Tabs' })
map('n', '<leader><tab>f', '<cmd>tabfirst<CR>', { desc = 'First Tab' })
map('n', '<leader><tab><tab>', '<cmd>tabnew<CR>', { desc = 'New Tab' })
map('n', '<leader><tab>]', '<cmd>tabnext<CR>', { desc = 'Next Tab' })
map('n', '<leader><tab>d', '<cmd>tabclose<CR>', { desc = 'Close Tab' })
map('n', '<leader><tab>[', '<cmd>tabprevious<CR>', { desc = 'Previous Tab' })

-- Snippet navigation (requires a snippet engine like LuaSnip)
map('s', '<Tab>', function()
  -- Check if LuaSnip is available
  local ok, luasnip = pcall(require, 'luasnip')
  if ok then
    if luasnip.jumpable(1) then
      return '<Plug>luasnip-jump-next'
    else
      return '<Tab>'
    end
  else
    return '<Tab>'
  end
end, { expr = true, desc = 'Jump Next' })

map({ 'i', 's' }, '<S-Tab>', function()
  -- Check if LuaSnip is available
  local ok, luasnip = pcall(require, 'luasnip')
  if ok then
    if luasnip.jumpable(-1) then
      return '<Plug>luasnip-jump-prev'
    else
      return '<S-Tab>'
    end
  else
    return '<S-Tab>'
  end
end, { expr = true, desc = 'Jump Previous' })

-- [[ Search Operations (Telescope) ]]
-- Add this section after your basic keymaps and before other specialized sections

-- Load telescope builtin functions
local telescope_ok, builtin = pcall(require, 'telescope.builtin')
if telescope_ok then
  -- Basic telescope keymaps
  map('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
  map('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
  map('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
  map('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
  map('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
  map('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
  map('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
  map('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
  map('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
  map('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

  -- Fuzzy search in current buffer
  map('n', '<leader>/', function()
    builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
      winblend = 10,
      previewer = false,
    })
  end, { desc = '[/] Fuzzily search in current buffer' })

  -- Search in open files
  map('n', '<leader>s/', function()
    builtin.live_grep {
      grep_open_files = true,
      prompt_title = 'Live Grep in Open Files',
    }
  end, { desc = '[S]earch [/] in Open Files' })

  -- Search neovim config files
  map('n', '<leader>sn', function()
    builtin.find_files { cwd = vim.fn.stdpath 'config' }
  end, { desc = '[S]earch [N]eovim files' })
  
  -- LSP-related telescope keymaps (only active when LSP is attached)
  -- These will be set up in your LSP configuration
end

-- Return the module
return {}