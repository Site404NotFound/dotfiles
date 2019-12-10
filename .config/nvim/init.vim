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
"    Minimalist Vim Plugin Manager
"    https://github.com/junegunn/vim-plug
"""""""""""""""""""""""""""""""""""""""""""""""

call plug#begin()

" gruvbox colorscheme
" Retro groove color scheme for Vim
" https://github.com/morhetz/gruvbox
Plug 'morhetz/gruvbox'

" badwolf colorscheme
" Modern Day bright color scheme for Vim
" https://github.com/sjl/badwolf
" Plug 'sjl/badwolf'

" nord colorscheme
" An arctic, north-bluish clean and elegant Vim color theme
" https://github.com/arcticicestudio/nord-vim
" Plug 'arcticicestudio/nord-vim'

" vim-surround
" Quoting/parenthesizing made easy
" https://github.com/tpope/vim-surround
Plug 'tpope/vim-surround'

" vim-polyglot
" A solid language pack for Vim.
" https://github.com/sheerun/vim-polyglot
Plug 'sheerun/vim-polyglot'

" neomake
" Asynchronous linting and make framework for Neovim/Vim
" https://github.com/neomake/neomake
Plug 'neomake/neomake'

" NERDTree
" A tree explorer plugin for vim.
" https://github.com/scrooloose/nerdtree
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

" fzf.vim
" A command-line fuzzy finder
" https://github.com/junegunn/fzf
" Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'

" vim-gitgutter
" A Vim plugin which shows a git diff in the gutter (sign column) and stages/undoes hunks
" https://github.com/airblade/vim-gitgutter
Plug 'airblade/vim-gitgutter'

" vim-airlines
" lean & mean status/tabline for vim that's light as air
" https://github.com/vim-airline/vim-airline
Plug 'vim-airline/vim-airline'

" lightline
" A light and configurable statusline/tabline plugin for Vim
" https://github.com/itchyny/lightline.vim
" Plug 'itchyny/lightline.vim'

" vim-multiple-cursors
" True Sublime Text style multiple selections for Vim
" https://github.com/terryma/vim-multiple-cursors
Plug 'terryma/vim-multiple-cursors'

" Ale Linting Engine
" Asynchronous linting/fixing for Vim and Language Server Protocol (LSP) integration
" https://github.com/w0rp/ale
Plug 'w0rp/ale'

" Deoplete
" Dark powered asynchronous completion framework for neovim/Vim8
" https://github.com/Shougo/deoplete.nvim
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
let g:deoplete#enable_at_startup = 1

" Vim Tmux Navigator
" Seamless navigation between tmux panes and vim splits
" https://github.com/christoomey/vim-tmux-navigator
Plug 'christoomey/vim-tmux-navigator'

" Multiple Cursors
" True Sublime Text style multiple selections for Vim
" https://github.com/terryma/vim-multiple-cursors
Plug 'terryma/vim-multiple-cursors'

" Update &runtimepath and initialize plugin system
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
" => Deoplete configuration
"""""""""""""""""""""""""""""""""""""""""""""""

let g:deoplete#enable_at_startup = 1
let g:deoplete#omni_patterns = {}
let g:deoplete#omni_patterns.java = '[^. *\t]\.\w*'
let g:deoplete#sources = {}
let g:deoplete#sources._ = []
let g:deoplete#file#enable_buffer_path = 1

"""""""""""""""""""""""""""""""""""""""""""""""
" => Java Complete
"""""""""""""""""""""""""""""""""""""""""""""""

autocmd FileType java setlocal omnifunc=javacomplete#Complete

"""""""""""""""""""""""""""""""""""""""""""""""
" => Neomake
"""""""""""""""""""""""""""""""""""""""""""""""

autocmd! BufWritePost,BufEnter * Neomake

"""""""""""""""""""""""""""""""""""""""""""""""
" => Neoformat
"""""""""""""""""""""""""""""""""""""""""""""""

augroup astyle
  autocmd!
  autocmd BufWritePre * Neoformat
augroup END

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
