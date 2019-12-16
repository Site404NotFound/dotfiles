"""""""""""""""""""""""""""""""""""""""""""""""
" => General Vim Settings
"""""""""""""""""""""""""""""""""""""""""""""""

set encoding=utf-8          " The encoding displayed
set fileencoding=utf-8      " The encoding written to file
syntax enable               " Enable syntax highlight
set ttyfast                 " Faster redrawing
set lazyredraw              " Only redraw when necessary
set cursorline              " Find the current line quickly.
set splitbelow              " Horizontal split below current
set splitright              " Vertical split to right of current
set noerrorbells            " Disable beeps and alerts
set autoread                " Automatically reload file when changes are made
set t_Co=256                " Set terminal to use 256 colors
set nocp                    " Disable compatible mode

"""""""""""""""""""""""""""""""""""""""""""""""
" => Vim-Plug Plugin List
"""""""""""""""""""""""""""""""""""""""""""""""

call plug#begin()

Plug 'morhetz/gruvbox'
Plug 'tpope/vim-surround'
Plug 'sheerun/vim-polyglot'
Plug 'neomake/neomake'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-gitgutter'
Plug 'vim-airline/vim-airline'
Plug 'terryma/vim-multiple-cursors'
Plug 'w0rp/ale'
Plug 'christoomey/vim-tmux-navigator'
Plug 'terryma/vim-multiple-cursors'

if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
let g:deoplete#enable_at_startup = 1

call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""
" => Plugin Related Configs
"""""""""""""""""""""""""""""""""""""""""""""""

" Neomake async hooks
" When writing a buffer (no delay)
call neomake#configure#automake('w')

" NERDTree Toggle on/off with Ctrl+e
let NERDTreeShowHidden=1
map <silent> <C-e> :NERDTreeToggle<CR>

" close NERDTree after a file is opened
let g:NERDTreeQuitOnOpen=1

" To use fzf in Vim, add the following line to your .vimrc:
set rtp+=/usr/local/opt/fzf

" make FZF respect gitignore if `ag` is installed
if (executable('ag'))
    let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -g ""'
endif

"""""""""""""""""""""""""""""""""""""""""""""""
" => Linter Related Configs
"""""""""""""""""""""""""""""""""""""""""""""""

" fix files on save
let g:ale_fix_on_save = 1

" lint after 1000ms after changes are made both on insert mode and normal mode
let g:ale_lint_on_text_changed = 'always'
let g:ale_lint_delay = 1000

" use emojis for errors and warnings
let g:ale_sign_error = "✗ "
let g:ale_sign_warning = "⚠ "

" fixer configurations
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\}

"""""""""""""""""""""""""""""""""""""""""""""""
" => Visual Related Configs
"""""""""""""""""""""""""""""""""""""""""""""""

set termguicolors
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

" set colorscheme
let g:gruvbox_italic=1
colorscheme gruvbox
let g:airline_theme='gruvbox'

" long lines as just one line (have to scroll horizontally)
set nowrap

" line numbers
set number
set relativenumber

" show the status line all the time
set laststatus=2

" toggle invisible characters
set invlist
set list
" set listchars=tab:¦\ ,eol:¬,trail:⋅,extends:❯,precedes:❮
set listchars=tab:¦\ ,eol:¬,trail:⋅

" disable scrollbars (real hackers don't use scrollbars)
set guioptions-=r
set guioptions-=R
set guioptions-=l
set guioptions-=L

"""""""""""""""""""""""""""""""""""""""""""""""
" => Keymappings
"""""""""""""""""""""""""""""""""""""""""""""""

" Use x to write/quit
" cmap x wq

" dont use arrowkeys
" Assigns arrow keys to No Operation (NOP) in Normal, Visual, Select, and
" Operator-pending modes
noremap <Up>    <NOP>
noremap <Down>  <NOP>
noremap <Left>  <NOP>
noremap <Right> <NOP>

" really, just dont
" Assigns arrows keys to No Operation (NOP) in Insert Mode
" TODO: I BELIEVE THE MAPPING HERE IS WHY I CAN'T DO PREVIOUS PANE IN TMUX.
" Need to fix eventually
inoremap <Up>    <NOP>
inoremap <Down>  <NOP>
inoremap <Left>  <NOP>
inoremap <Right> <NOP>

" copy and paste to/from Vim and the clipboard
nnoremap <C-y> +y
vnoremap <C-y> +y
nnoremap <C-p> +P
vnoremap <C-p> +P

" access system clipboard
set clipboard=unnamed

" swapfiles location
" Set tmp dir as swap file location
set backupdir=/tmp//
set directory=/tmp//

" map fzf to ctrl+p
nnoremap <C-p> :Files<CR>

" YouCompleteMe Key Mappings
nnoremap ,dl    :YcmCompleter GoToDeclaration<CR>
nnoremap ,df    :YcmCompleter GoToDefinition<CR>
nnoremap ,#     :YcmCompleter GoToReferences<CR>

"""""""""""""""""""""""""""""""""""""""""""""""
" => Indentation
"""""""""""""""""""""""""""""""""""""""""""""""

" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
" :help smarttab
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

" Auto indent
" Copy the indentation from the previous line when starting a new line
set ai

" Smart indent
" Automatically inserts one extra level of indentation in some cases, and works for C-like files
set si

let g:airline_powerline_fonts = 1
let g:airline#extensions#branch#enabled=1
let g:airline#extensions#fugitiveline#enabled = 1
