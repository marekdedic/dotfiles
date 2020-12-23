set nocompatible
filetype off

let g:polyglot_disabled = ['autoindent']

call plug#begin('~/.vim/plugged')

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'terryma/vim-multiple-cursors'
Plug 'haya14busa/incsearch.vim'
Plug 'sheerun/vim-polyglot'
Plug 'w0rp/ale'
Plug 'airblade/vim-gitgutter'
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-sleuth'
Plug 'joom/latex-unicoder.vim'
Plug 'jpalardy/vim-slime'
Plug 'JuliaEditorSupport/julia-vim'
Plug 'junegunn/fzf.vim'

source /usr/share/doc/fzf/examples/fzf.vim

call plug#end()

set laststatus=2
set t_Co=256

syntax on
set number
set relativenumber
set tabstop=4
set shiftwidth=4
set splitbelow
set splitright
set wildmode=longest,full
set wildmenu
set ttyfast
set mouse=a
set lazyredraw
set background=dark
set cmdheight=2
if !has('nvim')
	set ttymouse=sgr
endif
if has('persistent_undo')
	set undofile
	set undodir=$HOME/.vim/undo
endif
autocmd BufWritePost * if &diff == 1 | diffupdate | endif

map <C-T> :Rg<CR>

vnoremap <C-X> "+x
vnoremap <C-C> "+y

let g:slime_target = "tmux"
let g:slime_default_config = {"socket_name": "default", "target_pane": "{right-of}"}
let g:slime_dont_ask_default = 1

map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

let g:rustfmt_autosave=1
let g:tex_flavor = "latex"
let g:airline_powerline_fonts = 1
let g:airline_skip_empty_sections = 1
let g:gitgutter_max_signs = 1024
let g:gitgutter_sign_added = '•'
let g:gitgutter_sign_modified = '•'
let g:gitgutter_sign_removed = '•'
let g:gitgutter_sign_removed_first_line = '•'
let g:gitgutter_sign_modified_removed = '•'
set updatetime=250
let g:ale_sign_column_always = 1
let g:default_julia_version = '1.5'
