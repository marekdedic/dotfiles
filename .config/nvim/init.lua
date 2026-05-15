local Plug = vim.fn['plug#']

vim.call('plug#begin', vim.fn.stdpath('data') .. '/plugged')

Plug('nvim-treesitter/nvim-treesitter', {tag = 'v0.10.0', ['do'] = ':TSUpdate'}) -- Syntax highlighting
vim.g.tex_flavor = "latex" -- Treat ".tex" files as LaTeX by default
Plug('mg979/vim-visual-multi') -- Multiple cursors
Plug('joom/latex-unicoder.vim') -- Ctrl-L converts latex code to actual symbols, as in \alpha -> α

-- Automatically set tab width with defaults being tabs of width 4
Plug('tpope/vim-sleuth')
vim.o.expandtab = false
vim.o.tabstop = 4
vim.o.shiftwidth = 4

-- LSP & completion
Plug('neovim/nvim-lspconfig')
Plug('mason-org/mason.nvim')
Plug('mason-org/mason-lspconfig.nvim')
Plug('saghen/blink.cmp', {tag = 'v1.*'})

-- Linting (only tools not available as a LSP)
Plug('mfussenegger/nvim-lint')

-- git changes next to line numbers
Plug('airblade/vim-gitgutter')
vim.api.nvim_set_hl(0, 'GitGutterAdd', {fg = '#009900', ctermfg = 2})
vim.api.nvim_set_hl(0, 'GitGutterChange', {fg = '#7BB2D9', ctermfg = 4})
vim.api.nvim_set_hl(0, 'GitGutterDelete', {fg = '#FF2222', ctermfg = 1})
vim.o.signcolumn = "yes"
vim.g.gitgutter_sign_added = ''
vim.g.gitgutter_sign_modified = ''
vim.g.gitgutter_sign_removed = ''
vim.g.gitgutter_sign_removed_first_line = ''
vim.g.gitgutter_sign_modified_removed = ''

-- Use terminal colors
vim.o.termguicolors = false

-- When breaking a line, start at the same indentation
vim.o.breakindent = true

-- Pretty statusline
Plug('vim-airline/vim-airline')
vim.g.airline_powerline_fonts = 1
vim.g.airline_skip_empty_sections = 1

-- Unified navigation between vim splits and tmux panes
Plug('christoomey/vim-tmux-navigator')
vim.g.tmux_navigator_no_mappings = 1
vim.keymap.set('n', '<A-left>', '<Cmd>TmuxNavigateLeft<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<A-down>', '<Cmd>TmuxNavigateDown<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<A-up>', '<Cmd>TmuxNavigateUp<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<A-right>', '<Cmd>TmuxNavigateRight<CR>', { noremap = true, silent = true })

-- Send commands to REPL
Plug('jpalardy/vim-slime')
vim.g.slime_target = "tmux"
vim.g.slime_default_config = {socket_name = "default", target_pane = "{last}"}
vim.g.slime_dont_ask_default = 1

-- Fuzzy searching with Telescope
Plug('nvim-lua/plenary.nvim')
Plug('nvim-telescope/telescope.nvim', {tag = "v0.2.2"})
Plug('nvim-telescope/telescope-fzf-native.nvim', { ['do'] = 'make' })
Plug('kyazdani42/nvim-web-devicons')
vim.keymap.set('n', '<C-T>', '<Cmd>lua project_files()<CR>', {}) -- Ctrl-T to pick by file name
vim.keymap.set('n', '<C-G>', '<Cmd>Telescope live_grep<CR>', {}) -- Ctrl-G to pick by file contents

-- Copilot autocompletion
Plug('github/copilot.vim')

vim.call('plug#end')

vim.o.laststatus = 2 -- Always show status line
vim.o.cmdheight = 2 -- Status line accross 2 lines
vim.o.mouse = 'a' -- Mouse click moves cursor
vim.o.lazyredraw = true -- Faster macros
vim.o.updatetime = 250 -- Time to recalculate git gutter and autosave after stopping typing (ms)
vim.keymap.set('v', '<C-C>', '"+y', {}) -- Ctrl-C to copy to OS clipboard

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
  ensure_installed = "all",
  ignore_install = { "ipkg" },
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

-- Completion
require('blink.cmp').setup({
  completion = {
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 500,
    },
    ghost_text = {
      enabled = true,
    },
  },
  keymap = {
    preset = 'default',
    ['<CR>'] = { 'select_and_accept', 'fallback' },
  },
  signature = {
    enabled = true,
  },
  sources = {
    default = { 'lsp', 'path', 'buffer' },
  },
})

-- Fix blink menu colors
vim.api.nvim_set_hl(0, 'BlinkCmpMenu',                { ctermbg = 8,  ctermfg = 15 })
vim.api.nvim_set_hl(0, 'BlinkCmpMenuBorder',          { ctermbg = 8,  ctermfg = 15 })
vim.api.nvim_set_hl(0, 'BlinkCmpDoc',                 { ctermbg = 4,  ctermfg = 15 })
vim.api.nvim_set_hl(0, 'BlinkCmpDocBorder',           { ctermbg = 4,  ctermfg = 15 })
vim.api.nvim_set_hl(0, 'BlinkCmpSignatureHelp',       { ctermbg = 4,  ctermfg = 15 })
vim.api.nvim_set_hl(0, 'BlinkCmpSignatureHelpBorder', { ctermbg = 4,  ctermfg = 15 })

-- LSP management
require('mason').setup()
require('mason-lspconfig').setup({
  ensure_installed = {
    'pyright',
    'ruff',
    'ts_ls',
    'eslint',
    'jsonls',
    'julials',
    'cssls',
    'intelephense',
    'texlab',
    'svelte',
  },
})

vim.lsp.enable({ 'pyright', 'ruff', 'ts_ls', 'eslint', 'jsonls', 'cssls', 'intelephense', 'texlab', 'svelte', 'julials' })

vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
})

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', 'ft', vim.lsp.buf.format, opts)

    -- Highlight all occurences of symbol under cursor
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client and client.supports_method('textDocument/documentHighlight') then
      local group = vim.api.nvim_create_augroup('lsp_highlight_' .. ev.buf, { clear = true })
      vim.api.nvim_create_autocmd('CursorHold', {
        buffer = ev.buf, group = group, callback = vim.lsp.buf.document_highlight,
      })
      vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        buffer = ev.buf, group = group, callback = vim.lsp.buf.clear_references,
      })
    end
  end,
})

-- Additional linters not available as an LSP
require('lint').linters_by_ft = {
  sh   = { 'shellcheck' },
  bash = { 'shellcheck' },
  zsh  = { 'shellcheck' },
  yaml = { 'yamllint' },
  css  = { 'stylelint' },
  php  = { 'phpstan', 'phpcs', 'phpmd' },
}
vim.api.nvim_create_autocmd({ 'BufReadPost', 'BufWritePost' }, {
  callback = function() require('lint').try_lint() end,
})
