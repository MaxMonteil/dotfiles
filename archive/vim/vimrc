set cursorline
set guicursor=      " Keep cursor as a block

set hlsearch
set incsearch
set noequalalways
set noshowcmd
set number
set relativenumber
set splitright
set nocompatible

" Specify a directory for plugins
call plug#begin('~/.local/share/nvim/plugged')

" Sensible defaults
Plug 'tpope/vim-sensible'

" Extra editing features
Plug 'Yggdroot/indentLine'
Plug 'haya14busa/is.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'jiangmiao/auto-pairs'

" Completion
Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install() }}

" Linting
Plug 'w0rp/ale'

" Distraction free
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'

" Status/tabline bar
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Theming
Plug 'chriskempson/base16-vim'

" Initialize plugin system
call plug#end()

" Fuzzy file searching
set path+=**

command! MakeTags !ctags -R .

" Remap leader key
let mapleader = ","

" Quicker window navigation
nmap <silent> <C-h> :wincmd h<CR>
nmap <silent> <C-j> :wincmd j<CR>
nmap <silent> <C-k> :wincmd k<CR>
nmap <silent> <C-l> :wincmd l<CR>

" Show whitespace
let &showbreak = '↪ '
set listchars=tab:··,eol:¬,extends:…,precedes:…,nbsp:·,trail:~
set list

" Clear search highlighting with double Leader
nnoremap <silent> <Leader><Leader> :nohlsearch<CR>

" netrw settings
let g:netrw_banner=0            " Disable banner
let g:netrw_browse_split=0      " Open in previous window
let g:netrw_winsize=-188        " Default width for new window splits
let g:netrw_altv=4              " Open splits to the right
let g:netrw_liststyle=3         " Tree view
let g:netrw_localrmdir='rm -r'  " Allow removal of non empty local directories
autocmd FileType netrw set1 bufhidden=delete

" Coc
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" point neovim to python environments
let g:python_host_prog = '/home/max/.local/share/virtualenvs/neovim2/bin/python'
let g:python3_host_prog = '/home/max/.local/share/virtualenvs/neovim3/bin/python'

" Standard editor space settings
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

" Shortcut to wrap text
command! -nargs=* Wrap set wrap linebreak nolist

" Python settings
au BufNewFile,BufRead *.py
    \ setlocal tabstop=4     |
    \ setlocal softtabstop=4 |
    \ setlocal shiftwidth=4  |
    \ setlocal textwidth=87  |
    \ setlocal colorcolumn=88|
    \ highlight ColorColumn ctermbg=235|
    \ setlocal expandtab     |
    \ setlocal autoindent    |
    \ setlocal fileformat=unix

" Use <tab> to move through completions
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <expr><s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

" ale
let g:ale_sign_column_always = 1
let g:ale_set_highlights = 0
let g:ale_sign_error = '⚑'
let g:ale_sign_warning = '⚐'
let g:ale_linters = {
\	'python': ['flake8'],
\}

" Vim Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline#extensions#ale#enabled = 1
let g:airline_powerline_fonts = 1

" Yggdroot IndentLine
let g:indentLine_concealcursor = 0

" Scrooloose nerdcommenter
let g:NERDDefaultAlign = 'left'
let g:NERDCommentEmptyLines = 1

" Theming
syntax on
if filereadable(expand("~/.vimrc_background"))
    let base16colorspace=256
    source ~/.vimrc_background
endif
" Enable transparent backgrounds
hi Normal ctermbg=None
hi NonText ctermbg=None

" C/C++ compiler Mappings
map <F4> :w<CR>:!gcc % -o %<<CR>
map <F5> :w<CR>:!g++ % -o %<<CR>
map <F6> :!./%<<CR>

" Goyo Config
let g:goyo_width = 120
" Ensure :q to quit even when Goyo is active
function! s:goyo_enter()
    let &showbreak = ''
    execute 'set nocursorline'
    execute 'Limelight'
    execute 'set ft=markdown'
    let b:quitting = 0
    let b:quitting_bang = 0
    autocmd QuitPre <buffer> let b:quitting = 1
    cabbrev <buffer> q! let b:quitting_bang = 1 <bar> q!
endfunction

function! s:goyo_leave()
    execute 'Limelight!'
    " Quit Vim if this is the only remaining buffer
    if b:quitting && len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1
        if b:quitting_bang
            qa!
        else
            qa
        endif
    endif
endfunction

autocmd! User GoyoEnter call <SID>goyo_enter()
autocmd! User GoyoLeave call <SID>goyo_leave()

" Single word command for jrnl to place cursor at the end of the line
command! EndOfLine normal! $
