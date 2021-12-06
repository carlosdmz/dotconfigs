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
Plug 'ycm-core/YouCompleteMe' " YCM
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

" YCM mappings
nmap <leader><Tab> <Plug>(YCMFindSymbolInWorkspace)
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
let g:ycm_max_diagnostics_to_display = 0
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_confirm_extra_conf = 0
let g:ycm_extra_conf_globlist = ['~/open-source/*', '~/repos/*', '!~/*']
let g:ycm_semantic_triggers =  {
  \   'c': ['->', '.'],
  \   'objc': ['->', '.', 're!\[[_a-zA-Z]+\w*\s', 're!^\s*[^\W\d]\w*\s',
  \            're!\[.*\]\s'],
  \   'ocaml': ['.', '#'],
  \   'cpp,cuda,objcpp': ['->', '.', '::'],
  \   'perl': ['->'],
  \   'php': ['->', '::'],
  \   'cs,d,elixir,go,groovy,java,javascript,julia,perl6,python,scala,typescript,vb': ['.'],
  \   'ruby,rust': ['.', '::'],
  \   'lua': ['.', ':'],
  \   'erlang': [':'],
  \ }
