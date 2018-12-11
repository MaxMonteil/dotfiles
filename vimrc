set number
set relativenumber
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Code auto completion
Plugin 'Valloric/YouCompleteMe'
Plugin 'jiangmiao/auto-pairs'

" Search highlighting
Plugin 'haya14busa/incsearch.vim'

" Distraction free
Plugin 'junegunn/goyo.vim'
Plugin 'junegunn/limelight.vim'

" Status/tabline bar
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

" Theming
Plugin 'dikiaap/minimalist'

" Python
Plugin 'nvie/vim-flake8'

call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this linet number

" Standard editor spacing settings
set tabstop=4
set softtabstop=4
set shiftwidth=4
set noexpandtab

" Shortcut to wrap text
command! -nargs=* Wrap set wrap linebreak nolist

" Python settings
au BufNewFile,BufRead *.py
	\ set tabstop=4		|
	\ set softtabstop=4	|
	\ set shiftwidth=4	|
	\ set textwidth=79	|
	\ set colorcolumn=80|
	\ highlight ColorColumn ctermbg=235|
	\ set expandtab		|
	\ set autoindent	|
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

" Theming
set t_Co=256
syntax on
colorscheme minimalist
let g:airline_theme='minimalist'
highlight Search ctermbg=blue ctermfg=black guibg=blue guifg=black

" C/C++ compiler Mappings
map <F4> :w<CR>:!gcc % -o %<<CR>
map <F5> :w<CR>:!g++ % -o %<<CR>
map <F6> :!./%<<CR>

" Incsearch
map / <Plug>(incsearch-forward)
map ? <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
set hlsearch
let g:incsearch#auto_nohlsearch = 1
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)

" Goyo Config
let g:goyo_width = 120
" Ensure :q to quit even when Goyo is active
function! s:goyo_enter()
	execute 'Limelight'
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
