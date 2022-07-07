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
Plug 'neoclide/coc.nvim', {'branch': 'release'} " Coc
Plug 'sainnhe/gruvbox-material' " Gruvbox material
Plug 'altercation/vim-colors-solarized' " Solarized
Plug 'vim-scripts/termpot'
call plug#end()

" Basic VIM configuration
syntax      on
filetype    plugin indent on
set guicursor=
set nu rnu
set nohlsearch
set hidden

set smarttab
set tabstop=4
set shiftwidth=4
set smartindent

set nowrap
set noswapfile
set nobackup
set scrolloff=8
set omnifunc=syntaxcomplete#Complete
set completeopt+=preview
set colorcolumn=81

let &t_8f = "<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "<Esc>[48;2;%lu;%lu;%lum"
set t_Co=256
set background=dark
colorscheme termpot

highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

" Some useful remapping
nnoremap <C-c> :bp\|bd #<CR>
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

