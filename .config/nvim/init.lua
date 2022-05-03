local Plug = vim.fn['plug#']

vim.call('plug#begin', vim.fn.stdpath('data') .. '/plugged')

Plug('nvim-treesitter/nvim-treesitter', {commit = '394e7f8', ['do'] = ':TSUpdate'}) -- Syntax highlighting
Plug('mg979/vim-visual-multi') -- Multiple cursors
Plug('joom/latex-unicoder.vim') -- Ctrl-L converts latex code to actual symbols, as in \alpha -> α

-- Automatically set tab width with defaults being tabs of width 4
Plug('tpope/vim-sleuth')
vim.o.expandtab = false
vim.o.tabstop = 4
vim.o.shiftwidth = 4

-- Code completion
Plug('neoclide/coc.nvim', {branch = 'release'})
Plug('fannheyward/coc-julia', {['do'] = 'yarn install --frozen-lockfile'})
Plug('marlonfan/coc-phpls', {['do'] = 'yarn install --frozen-lockfile'})
Plug('fannheyward/coc-pyright', {['do'] = 'yarn install --frozen-lockfile'})
Plug('coc-extensions/coc-svelte', {['do'] = 'yarn install --frozen-lockfile'})
Plug('fannheyward/coc-texlab', {['do'] = 'yarn install --frozen-lockfile'})
Plug('neoclide/coc-tsserver', {['do'] = 'yarn install --frozen-lockfile'})
Plug('neoclide/coc-css', {['do'] = 'yarn install --frozen-lockfile'})
vim.api.nvim_command('autocmd CursorHold * call CocActionAsync(\'highlight\')') -- Automatically highlight all occurences of symbol under cursor
vim.api.nvim_set_keymap('n', 'gd', '<Plug>(coc-definition)', {}) -- go to definition
vim.api.nvim_set_keymap('n', 'gi', '<Plug>(coc-implementation)', {}) -- go to implementation
vim.api.nvim_set_keymap('n', 'gr', '<Plug>(coc-references)', {}) -- go to references

-- Linters
Plug('w0rp/ale')
vim.g.ale_sign_column_always = 1
vim.g.ale_disable_lsp = 1

-- git changes next to line numbers
Plug('airblade/vim-gitgutter')
vim.api.nvim_command('highlight GitGutterAdd guifg=#009900 ctermfg=2')
vim.api.nvim_command('highlight GitGutterChange guifg=#7BB2D9 ctermfg=4')
vim.api.nvim_command('highlight GitGutterDelete guifg=#FF2222 ctermfg=1')
vim.g.gitgutter_sign_added = ''
vim.g.gitgutter_sign_modified = ''
vim.g.gitgutter_sign_removed = ''
vim.g.gitgutter_sign_removed_first_line = ''
vim.g.gitgutter_sign_modified_removed = ''

-- Use terminal colors
vim.o.termguicolors = true

-- Pretty statusline
Plug('vim-airline/vim-airline')
vim.g.airline_powerline_fonts = 1
vim.g.airline_skip_empty_sections = 1

-- Send commands to REPL
Plug('jpalardy/vim-slime')
vim.g.slime_target = "tmux"
vim.g.slime_default_config = {socket_name = "default", target_pane = "{last}"}
vim.g.slime_dont_ask_default = 1

-- Fuzzy searching with Telescope
Plug('nvim-lua/plenary.nvim')
Plug('nvim-telescope/telescope.nvim', {tag = "nvim-0.6"})
Plug('nvim-telescope/telescope-fzf-native.nvim', { ['do'] = 'make' })
Plug('kyazdani42/nvim-web-devicons')
vim.api.nvim_set_keymap('n', '<C-T>', '<Cmd>lua project_files()<CR>', {}) -- Ctrl-T to pick by file name
vim.api.nvim_set_keymap('n', '<C-G>', '<Cmd>Telescope live_grep<CR>', {}) -- Ctrl-G to pick by file contents

vim.call('plug#end')

vim.o.laststatus = 2 -- Always show status line
vim.o.cmdheight = 2 -- Status line accross 2 lines
vim.o.mouse = 'a' -- Mouse click moves cursor
vim.o.lazyredraw = true -- Faster macros
vim.o.updatetime = 250 -- Time to recalculate git gutter and autosave after stopping typing (ms)
vim.api.nvim_set_keymap('v', '<C-C>', '"+y', {}) -- Ctrl-C to copy to OS clipboard

-- Line numbering
vim.o.number = true
vim.o.relativenumber = true

-- When splitting, the new window will be on the bottom or on the right
vim.o.splitbelow = true
vim.o.splitright = true

-- Undo history is not erased when vim is closed
if vim.fn.has('persistent_undo') == 1 then
	vim.o.undofile = true
	vim.o.undodir = vim.fn.stdpath('data') .. '/undo'
end

require('nvim-treesitter.configs').setup({
  ensure_installed = "all", -- Installs all language parsers
  highlight = {
    enable = true
  }
})

local actions = require('telescope.actions')
require('telescope').setup({
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = actions.close -- Esc closes the picker right away (instead of going to normal mode first)
      },
    },
  }
})
require('telescope').load_extension('fzf')
project_files = function() -- git_files picker with fallback to find_files when not inside a git repo
  local ok = pcall(require'telescope.builtin'.git_files, {})
  if not ok then require'telescope.builtin'.find_files({}) end
end
