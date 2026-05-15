local Plug = vim.fn['plug#']

vim.call('plug#begin', vim.fn.stdpath('data') .. '/plugged')

-- Color scheme
Plug('tjdevries/colorbuddy.nvim')
Plug('lalitmee/cobalt2.nvim')

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
vim.o.signcolumn = "yes"
vim.g.gitgutter_sign_added = ''
vim.g.gitgutter_sign_modified = ''
vim.g.gitgutter_sign_removed = ''
vim.g.gitgutter_sign_removed_first_line = ''
vim.g.gitgutter_sign_modified_removed = ''

vim.o.termguicolors = true

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

-- Enhanced UI for cmdline, messages, and notifications
Plug('MunifTanjim/nui.nvim')
Plug('rcarriga/nvim-notify')
Plug('folke/noice.nvim')

-- Fuzzy searching with Telescope
Plug('nvim-lua/plenary.nvim')
Plug('nvim-telescope/telescope.nvim', {tag = "v0.2.2"})
Plug('nvim-telescope/telescope-fzf-native.nvim', { ['do'] = 'make' })
Plug('kyazdani42/nvim-web-devicons')
vim.keymap.set('n', '<C-T>', '<Cmd>lua project_files()<CR>', {}) -- Ctrl-T to pick by file name
vim.keymap.set('n', '<C-G>', '<Cmd>Telescope live_grep<CR>', {}) -- Ctrl-G to pick by file contents

-- Copilot autocompletion
Plug('zbirenbaum/copilot.lua')
Plug('fang2hou/blink-copilot')

vim.call('plug#end')

vim.o.laststatus = 2 -- Always show status line
vim.o.mouse = 'a' -- Mouse click moves cursor
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

-- Color scheme
require('colorbuddy').colorscheme('cobalt2')
require('cobalt2')

local c = require('cobalt2.palette')
local custom = {
  bg = '#132738', -- Ghostty Cobalt2 background (overrides cobalt2.nvim's #193549)
  doc_bg = '#1460d2', -- Ghostty ANSI blue (palette 4), not in cobalt2.nvim palette
}

-- Match Ghostty's Cobalt2 background
vim.api.nvim_set_hl(0, 'Normal', { bg = custom.bg, fg = c.white })
vim.api.nvim_set_hl(0, 'NormalNC', { bg = custom.bg, fg = c.white })
vim.api.nvim_set_hl(0, 'LineNr', { bg = custom.bg, fg = c.light_grey })
vim.api.nvim_set_hl(0, 'FoldColumn', { bg = custom.bg, fg = c.dark_grey })
vim.api.nvim_set_hl(0, 'NonText', { bg = custom.bg, fg = c.dark_grey })
vim.api.nvim_set_hl(0, 'FloatBorder', { bg = custom.bg, fg = c.blue })

-- Git gutter colors
vim.api.nvim_set_hl(0, 'GitGutterAdd', { fg = c.green, ctermfg = 2 })
vim.api.nvim_set_hl(0, 'GitGutterChange', { fg = c.yellow, ctermfg = 4 })
vim.api.nvim_set_hl(0, 'GitGutterDelete', { fg = c.red, ctermfg = 1 })

-- Blink menu colors
vim.api.nvim_set_hl(0, 'BlinkCmpMenu', { bg = c.darker_blue, fg = c.white })
vim.api.nvim_set_hl(0, 'BlinkCmpMenuBorder', { bg = c.darker_blue, fg = c.white })
vim.api.nvim_set_hl(0, 'BlinkCmpDoc', { bg = custom.doc_bg, fg = c.white })
vim.api.nvim_set_hl(0, 'BlinkCmpDocBorder', { bg = custom.doc_bg, fg = c.white })
vim.api.nvim_set_hl(0, 'BlinkCmpSignatureHelp', { bg = custom.doc_bg, fg = c.white })
vim.api.nvim_set_hl(0, 'BlinkCmpSignatureHelpBorder', { bg = custom.doc_bg, fg = c.white })

-- Underline diagnostics without changing text color
vim.api.nvim_set_hl(0, 'DiagnosticUnderlineError', { undercurl = true, sp = c.red })
vim.api.nvim_set_hl(0, 'DiagnosticUnderlineWarn', { undercurl = true, sp = c.yellow })
vim.api.nvim_set_hl(0, 'DiagnosticUnderlineInfo', { undercurl = true, sp = c.blue })
vim.api.nvim_set_hl(0, 'DiagnosticUnderlineHint', { undercurl = true, sp = c.grey })

require('nvim-treesitter.configs').setup({
  ensure_installed = "all",
  ignore_install = { "ipkg" },
  highlight = {
    enable = true
  }
})

require('noice').setup({
  lsp = {
    override = {
      ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
      ['vim.lsp.util.stylize_markdown'] = true,
    },
  },
  presets = {
    command_palette = true,     -- cmdline and popup menu float together
    long_message_to_split = true, -- long :messages go to a split instead of a pager
  },
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
    default = { 'lsp', 'path', 'buffer', 'copilot' },
    providers = {
      copilot = {
        name = 'copilot',
        module = 'blink-copilot',
        score_offset = 100,
        async = true,
      },
    },
  },
})

-- Copilot is routed through blink-copilot, so disable its default suggestion and panel windows
require('copilot').setup({
  suggestion = { enabled = false },
  panel = { enabled = false },
})

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
  sh = { 'shellcheck' },
  bash = { 'shellcheck' },
  zsh = { 'shellcheck' },
  yaml = { 'yamllint' },
  css = { 'stylelint' },
  php = { 'phpstan', 'phpcs', 'phpmd' },
}
vim.api.nvim_create_autocmd({ 'BufReadPost', 'BufWritePost' }, {
  callback = function() require('lint').try_lint() end,
})
