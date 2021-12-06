" Install plugins with Plug
call plug#begin()
Plug 'tpope/vim-sensible' " sets some normal standards
Plug 'sheerun/vim-polyglot' " language packs
Plug 'vim-syntastic/syntastic' " syntax checkings
Plug 'ctrlpvim/ctrlp.vim' " file finder
Plug 'raimondi/delimitmate' " auto closing brackets/quotes/...
Plug 'vimjas/vim-python-pep8-indent' " python indentation
Plug 'vim-airline/vim-airline' " status bar
Plug 'vim-airline/vim-airline-themes' "status bar theme
Plug 'preservim/nerdtree' " Nerdtree
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } " Fuzzyfinder
Plug 'junegunn/fzf.vim', { 'do': { -> fzf#install() } } " Fuzzyfinder for vim
Plug 'ayu-theme/ayu-vim' " Ayu theme
Plug 'prabirshrestha/vim-lsp' " LSP server
Plug 'mattn/vim-lsp-settings' " Automagically configure LSP server
Plug 'prabirshrestha/asyncomplete.vim' " agnostic auto completer
Plug 'keremc/asyncomplete-clang.vim' " Clang completer
Plug 'prabirshrestha/asyncomplete-gocode.vim' " Go completer
Plug 'keremc/asyncomplete-racer.vim' " Rust completer
Plug 'davidhalter/jedi-vim' " JEDI Python completer
call plug#end()


" Basic VIM configuration
syntax      on
filetype    plugin indent on
set guicursor=
set nu rnu
set nohlsearch
set hidden
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set nowrap
set noswapfile
set nobackup
set scrolloff=8

set colorcolumn=80
highlight ColorColumn ctermbg=0 guibg=lightgrey

set termguicolors
set background=dark
let ayucolor="dark"
colorscheme ayu
inoremap    jk <ESC>
let g:mapleader = "\<Space>"


" Nerdtree settings
map <C-e> :NERDTreeToggle<CR>

" Airline settings
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme='tomorrow'

" FZF mappings
let g:fzf_nvim_statusline = 0 " disable statusline overwriting

nnoremap <silent> <leader><space> :Files<CR>
nnoremap <silent> <leader>a :Buffers<CR>
nnoremap <silent> <leader>A :Windows<CR>
nnoremap <silent> <leader>; :BLines<CR>
nnoremap <silent> <leader>o :BTags<CR>
nnoremap <silent> <leader>O :Tags<CR>
nnoremap <silent> <leader>? :History<CR>
nnoremap <silent> <leader>/ :execute 'Ag ' . input('Ag/')<CR>
nnoremap <silent> <leader>. :AgIn 

nnoremap <silent> K :call SearchWordWithAg()<CR>
vnoremap <silent> K :call SearchVisualSelectionWithAg()<CR>
nnoremap <silent> <leader>gl :Commits<CR>
nnoremap <silent> <leader>ga :BCommits<CR>
nnoremap <silent> <leader>ft :Filetypes<CR>

imap <C-x><C-f> <plug>(fzf-complete-file-ag)
imap <C-x><C-l> <plug>(fzf-complete-line)

function! SearchWordWithAg()
execute 'Ag' expand('<cword>')
endfunction

function! SearchVisualSelectionWithAg() range
	let old_reg = getreg('"')
	let old_regtype = getregtype('"')
	let old_clipboard = &clipboard
	set clipboard&
	normal! ""gvy
	let selection = getreg('"')
	call setreg('"', old_reg, old_regtype)
	let &clipboard = old_clipboard
	execute 'Ag' selection
endfunction

function! SearchWithAgInDirectory(...)
	call fzf#vim#ag(join(a:000[1:], ' '), extend({'dir': a:1}, g:fzf#vim#default_layout))
endfunction
command! -nargs=+ -complete=dir AgIn call SearchWithAgInDirectory(<f-args>)

" asyncompleter.vim mappings
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"

let g:asyncomplete_auto_popup = 0

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <TAB>
  \ pumvisible() ? "\<C-n>" :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ asyncomplete#force_refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

let g:asyncomplete_auto_completeopt = 0
set completeopt=menuone,noinsert,noselect,preview
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

" Auto completers
autocmd User asyncomplete_setup call asyncomplete#register_source(
    \ asyncomplete#sources#clang#get_source_options())

autocmd User asyncomplete_setup call asyncomplete#register_source(
    \ asyncomplete#sources#racer#get_source_options())

call asyncomplete#register_source(asyncomplete#sources#gocode#get_source_options({
    \ 'name': 'gocode',
    \ 'allowlist': ['go'],
    \ 'completor': function('asyncomplete#sources#gocode#completor'),
    \ 'config': {
    \    'gocode_path': expand('~/go/bin/gocode')
    \  },
    \ }))
