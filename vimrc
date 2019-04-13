set number
set relativenumber
set splitright
set cursorline
set incsearch               " incremebtally highlight search pattern
set hlsearch                " highlight search results
set nocompatible            " be iMproved, required
filetype off                " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Extra editing features
Plugin 'Valloric/YouCompleteMe'
Plugin 'jiangmiao/auto-pairs'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'scrooloose/nerdcommenter'
Plugin 'Yggdroot/indentLine'
Plugin 'haya14busa/is.vim'

" Distraction free
Plugin 'junegunn/goyo.vim'
Plugin 'junegunn/limelight.vim'

" Status/tabline bar
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'tpope/vim-fugitive'

" Theming
Plugin 'chriskempson/base16-vim'

" Python
Plugin 'nvie/vim-flake8'

call vundle#end()               " required
filetype plugin indent          " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this linet number

" Remap leader key
let mapleader = ","

" show whitespace
let &showbreak = '↪ '
set listchars=tab:»·,eol:¬,extends:…,precedes:…,nbsp:·,trail:~
set list

" netrw settings
let g:netrw_banner=0        " Disable banner
let g:netrw_browse_split=4  " Open in prior window
let g:netrw_altv=1          " Open splits to the right
let g:netrw_liststyle=3     " Tree view
autocmd FileType netrw set1 bufhidden=delete


" Standard editor spacing settings
set tabstop=4
set softtabstop=4
set shiftwidth=4
set noexpandtab

" Shortcut to wrap text
command! -nargs=* Wrap set wrap linebreak nolist

" Python settings
au BufNewFile,BufRead *.py
    \ set tabstop=4     |
    \ set softtabstop=4 |
    \ set shiftwidth=4  |
    \ set textwidth=87  |
    \ set colorcolumn=88|
    \ highlight ColorColumn ctermbg=235|
    \ set expandtab     |
    \ set autoindent    |
    \ set fileformat=unix
au BufWritePost *.py call Flake8()

" YouCompleteMe
let g:ycm_global_ycm_extra_conf = "~/.vim/.ycm_extra_conf.py"
let g:ycm_autoclose_preview_window_after_completion = 1
" Search for header files in include folder
let &path.="src/include, /usr/include"

" Vim Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline_powerline_fonts = 1

" Yggdroot IndentLine
let g:indentLine_concealcursor = 0

" Theming
syntax on
if filereadable(expand("~/.vimrc_background"))
    let base16colorspace=256
    source ~/.vimrc_background
endif

" C/C++ compiler Mappings
map <F4> :w<CR>:!gcc % -o %<<CR>
map <F5> :w<CR>:!g++ % -o %<<CR>
map <F6> :!./%<<CR>

" Goyo Config
let g:goyo_width = 120
" Ensure :q to quit even when Goyo is active
function! s:goyo_enter()
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
command EndOfLine normal! $
