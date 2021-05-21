" init Pathogen
call pathogen#infect()


" General VIM definitions
syntax   on
filetype plugin indent on

colorscheme azure

set      termguicolors
set      nowrap                    
set      autoindent                
set      shiftwidth=4              
set      expandtab                 
set      tabstop=4                 
set      softtabstop=4             
set      nojoinspaces              
set      splitright                
set      splitbelow                
set      pastetoggle=<F12>         
set      colorcolumn=80            
set      tabpagemax=15             
set      showmode                  
set      backspace=indent,eol,start
set      linespace=0               
set      nu                        
set      showmatch                 
set      incsearch                 
set      hlsearch                  
set      winminheight=0            
set      ignorecase                
set      smartcase                 
set      wildmenu                  
set      wildmode=list:longest,full
set      whichwrap=b,s,h,l,<,>,[,] 
set      scrolljump=5              
set      scrolloff=3               


highlight clear SignColumn
highlight clear LineNr    


" NERDTree settings
map <C-e> :NERDTreeToggle<CR>


" YouCompleteMe settings
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_key_list_select_completion = ['<TAB>']
let g:ycm_key_list_previous_completion = ['<S-TAB>']
let g:ycm_goto_buffer_command = 'horizontal-split'
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
\ 'elm' : ['.'],
\ }


" Ultisnips settings
let g:UltiSnipsExpandTrigger = "<C-o>"
let g:UltiSnipsJumpForwardTrigger = "<C-b>"
let g:UltiSnipsJumpBackwardTrigger = "<C-z>"

