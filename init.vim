set cursorline
set guicursor=      " Keep cursor as a block
set mouse=
set termguicolors

set hlsearch
set incsearch
set noshowcmd
set number
set relativenumber
set splitright
set nocompatible
set wildignorecase  " Ignore text case when using tab to complete (:b, :fin)
set wildignore+=*/node_modules/*,*/dist/*
set smartcase

set isfname+=@-@
set includeexpr=substitute(v:fname,'^@\/','./src/','')

" Specify a directory for plugins
call plug#begin('~/.local/share/nvim/plugged')

" Sensible defaults
Plug 'tpope/vim-sensible'

" Project Management
Plug 'mhinz/vim-startify'                   " Fancy start screen

" Extra editing features
Plug 'Yggdroot/indentLine'                  " Show indent levels
Plug 'haya14busa/is.vim'                    " Improves incremental search
Plug 'tpope/vim-repeat'                     " Lets plugins use '.' to repeat commands
Plug 'tpope/vim-surround'                   " Mappings for better surrounding pairs
Plug 'tomtom/tcomment_vim'                  " Comment stuff out
Plug 'jiangmiao/auto-pairs'                 " Automatically close character pairs
Plug 'bagrat/vim-buffet'                    " Better buffer and tabs management

" Completion and Linting
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Project searching
Plug 'jremmen/vim-ripgrep'

" Tags management
Plug 'ludovicchabant/vim-gutentags'

" Distraction free
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'

" Status/tabline bar
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'edkolev/tmuxline.vim'

" Language specific
" Plug 'sheerun/vim-polyglot'                 " All
Plug 'posva/vim-vue'                        " Vue
Plug 'pangloss/vim-javascript'              " Javascript
Plug 'vim-python/python-syntax'             " Python
Plug 'jackguo380/vim-lsp-cxx-highlight'     " C/C++
Plug 'mechatroner/rainbow_csv'              " CSV
Plug 'StanAngeloff/php.vim', {'for': 'php'} " PHP
Plug 'stephpy/vim-php-cs-fixer'             " PHP
Plug 'jwalton512/vim-blade'                 " PHP Blade templates

" Theming
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }

" Initialize plugin system
call plug#end()

" Fuzzy file searching
set path+=**

" Remap leader key
let mapleader = " "

" Quicker window navigation
nmap <silent> <C-h> :wincmd h<CR>
nmap <silent> <C-j> :wincmd j<CR>
nmap <silent> <C-k> :wincmd k<CR>
nmap <silent> <C-l> :wincmd l<CR>

" Cycle through open buffers with Tab and Shift+Tab arrow keys
nnoremap <silent> <Tab> :bnext<CR>
nnoremap <silent> <S-Tab> :bprevious<CR>

" Quickfix
" Open Quickfix across full width of window
autocmd filetype qf wincmd J

" Map <leader>q to :copen in normal mode
nnoremap <leader>q :copen<CR>

" Close quickfix window after selecting an entry or pressing Escape
augroup CloseQuickfix
  autocmd!
  " Close quickfix window on <CR>
  autocmd filetype qf nnoremap <buffer><silent> <CR> <CR>:cclose<CR>:call DeleteQuickfixBuffer()<CR>
  " Close quickfix window on <Esc>
  autocmd filetype qf nnoremap <buffer><silent> <Esc> :cclose<CR>:call DeleteQuickfixBuffer()<CR>
augroup END

function! DeleteQuickfixBuffer()
    " Only attempt to delete if the current buffer is a quickfix buffer
    if &buftype == 'quickfix'
        silent! bdelete!
    endif
endfunction

" Show whitespace
let &showbreak = '↪ '
set listchars=tab:··,eol:¬,extends:…,precedes:…,nbsp:·,trail:~
set list

" Clear search highlighting with double Leader
nnoremap <silent> <Leader><Leader> :nohlsearch<CR>

" Vim Buffet
let g:buffet_powerline_separators = 1
let g:buffet_tab_icon = "\uf00a"
let g:buffet_left_trunc_icon = "\uf0a8"
let g:buffet_right_trunc_icon = "\uf0a9"

" Vim Startify
let g:startify_change_to_vcs_root = 1
let g:startify_change_to_dir = 1
let g:startify_session_persistence = 1
let g:startify_files_number = 5
let g:startify_bookmarks = [
  \ {'c': '~/.config/nvim/coc-settings.json'},
  \ {'n': '~/.config/nvim/init.vim'},
  \ {'t': '~/.config/tmux/tmux.conf'},
\ ]

" Vim Coc
" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" coc-explorer
let g:coc_explorer_global_presets = {
  \   '.vim': {
  \     'root-uri': '~/.vim',
  \   },
  \   'floating': {
  \     'position': 'floating',
  \     'floating-position': 'center-top',
  \     'open-action-strategy': 'sourceWindow',
  \   },
  \ }

nmap <space>e :CocCommand explorer<CR>
nmap <space>f :CocCommand explorer --preset floating<CR>
autocmd BufEnter * if (winnr("$") == 1 && &filetype == 'coc-explorer') | q | endif

" ---------------------------------------
" Completion (:h coc-completion)
" ---------------------------------------

" Use <CR> to confirm completion
inoremap <expr> <cr>
  \ coc#pum#visible() ? coc#_select_confirm() :
  \ "\<CR>"

" Use <tab> and <S-tab> to navigate completion list
inoremap <silent><expr> <TAB>
  \ coc#pum#visible() ? coc#pum#next(1) :
  \ CheckBackSpace() ? "\<Tab>" :
  \ coc#refresh()

inoremap <expr><S-TAB>
  \ coc#pum#visible() ? coc#pum#prev(1) :
  \ "\<C-h>"

function! CheckBackSpace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Point neovim to python environments
let g:python_host_prog = '/home/max/.local/share/virtualenvs/neovim2/bin/python'
let g:python3_host_prog = '/home/max/.local/share/virtualenvs/neovim3-i4srHafD/bin/python'

" Vim Gutentags
" command! MakeTags !ctags -R .
" Gutentag config source: https://www.reddit.com/r/vim/comments/d77t6j/guide_how_to_setup_ctags_with_gutentags_properly/
let g:gutentags_add_default_project_roots = 0
let g:gutentags_project_root = ['package.json', '.git']
let g:gutentags_cache_dir = expand('~/.cache/vim/ctags/')         " Place all tag files in the same location
command! -nargs=0 GutentagsClearCache call system('rm ' . g:gutentags_cache_dir . '/*') " Command to clear cache
let g:gutentags_generate_on_new = 1
let g:gutentags_generate_on_missing = 1
let g:gutentags_generate_on_write = 1
let g:gutentags_generate_on_empty_buffer = 0
let g:gutentags_ctags_extra_args = [
            \ '--tag-relative=yes',
            \ '--fields=+ailmnS',
            \ ]
let g:gutentags_ctags_exclude = [
            \ '*.git', '*.svg', '*.hg',
            \ '*/tests/*',
            \ 'build',
            \ 'dist',
            \ '*sites/*/files/*',
            \ 'bin',
            \ 'node_modules',
            \ 'bower_components',
            \ 'cache',
            \ 'compiled',
            \ 'docs',
            \ 'example',
            \ 'bundle',
            \ 'vendor',
            \ '*.md',
            \ '*-lock.json',
            \ '*.lock',
            \ '*bundle*.js',
            \ '*build*.js',
            \ '.*rc*',
            \ '*.json',
            \ '*.min.*',
            \ '*.map',
            \ '*.bak',
            \ '*.zip',
            \ '*.pyc',
            \ '*.class',
            \ '*.sln',
            \ '*.Master',
            \ '*.csproj',
            \ '*.tmp',
            \ '*.csproj.user',
            \ '*.cache',
            \ '*.pdb',
            \ 'tags*',
            \ 'cscope.*',
            \ '*.css',
            \ '*.less',
            \ '*.scss',
            \ '*.exe', '*.dll',
            \ '*.mp3', '*.ogg', '*.flac',
            \ '*.swp', '*.swo',
            \ '*.bmp', '*.gif', '*.ico', '*.jpg', '*.png',
            \ '*.rar', '*.zip', '*.tar', '*.tar.gz', '*.tar.xz', '*.tar.bz2',
            \ '*.pdf', '*.doc', '*.docx', '*.ppt', '*.pptx',
            \ ]

" Standard editor space settings
set tabstop=4
set softtabstop=4
set shiftwidth=2
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
            \ setlocal autoindent    |
            \ setlocal fileformat=unix
let g:python_highlight_all = 1

" Vue and JS settings
au BufNewFile,BufRead *.vue,*js
            \ setlocal tabstop=2     |
            \ setlocal softtabstop=2 |
            \ setlocal shiftwidth=2  |
            \ setlocal autoindent    |
            \ setlocal fileformat=unix

"" Enable syntax highlighting for JSDocs
let g:javascript_plugin_jsdoc = 1

"" Highlighting sometimes randomly stops in vue files
autocmd FileType vue syntax sync fromstart
let g:vue_pre_processors = []


" Rainbow CSV
let g:rbql_backend_language = 'js'

" PHP settings
let g:php_cs_fixer_config_file = '/home/max/.local/share/.php_cs'
augroup FormatPHPOnSave
  autocmd!
  autocmd BufWritePost *.php silent! call PhpCsFixerFixFile()
augroup END
command! ComposerDumpAutoload !composer dump-autoload

" Markdown Settings
au BufNewFile,BufRead *.md
            \ setlocal wrap linebreak nolist

" JSONC syntax highlighting for comments
autocmd FileType json syntax match Comment +\/\/.\+$+

" Vim Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline_powerline_fonts = 1
let g:airline_theme= 'catppuccin'
set statusline+=%{gutentags#statusline()}

" Theming
syntax on
colorscheme catppuccin-mocha
" Code syntax highlighting in markdown docs
let g:markdown_fenced_languages = ['html', 'vue', 'javascript', 'typescript']

" Enable transparent backgrounds
hi Normal guibg=None ctermbg=None
hi NonText guibg=None ctermbg=None

let g:tmuxline_powerline_separators = 1
let g:tmuxline_preset = {
    \ 'a': '#S',
      \ 'win': '#I #W',
      \ 'cwin': '#I #W'
  \}

" C/C++ compiler Mappings
map <F4> :w<CR>:!gcc % -o %<<CR>
map <F5> :w<CR>:!g++ % -o %<<CR>
map <F6> :!./%<<CR>

" Limelight Config
let g:limelight_conceal_ctermfg = 'gray'

"Goyo Config
let g:goyo_width = 120
" Ensure :q to quit even when Goyo is active
function! s:goyo_enter()
    let &showbreak = ''
    execute 'set nocursorline'
    execute 'set ft=markdown'
    let b:quitting = 0
    let b:quitting_bang = 0
    autocmd QuitPre <buffer> let b:quitting = 1
    cabbrev <buffer> q! let b:quitting_bang = 1 <bar> q!
endfunction

function! s:goyo_leave()
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
