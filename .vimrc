set clipboard=unnamed
set hidden
set number
set relativenumber
set ignorecase

set listchars=tab:>-,trail:~,extends:>,precedes:<
set list

set clipboard=unnamed

set statusline+=%F
set laststatus=2

set foldmethod=indent
set foldlevel=1

"when indenting up, jump back to current location
"https://vi.stackexchange.com/questions/12366/indent-lines-up-without-moving/
nnoremap > m'>
nnoremap < m'<
onoremap <expr> k v:operator =~ '>\\|<' ? 'k``' : 'k'

colorscheme pt_black
hi LineNr           guifg=#3D3D3D     guibg=black       gui=NONE    ctermfg=darkgray    ctermbg=NONE        cterm=NONE
set background=dark

syntax on

call plug#begin()
Plug 'mattn/emmet-vim'
Plug 'jelera/vim-javascript-syntax'
"Plug 'vim-scripts/JavaScript-Indent'
Plug 'KurtPreston/JavaScript-Indent' "fork of the vim-scripts; removes debug statement
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'posva/vim-vue'
Plug 'w0rp/ale'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-commentary'
Plug 'ap/vim-css-color'
Plug 'bkad/CamelCaseMotion'
Plug 'shawncplus/phpcomplete.vim'
call plug#end()

map <silent> w <Plug>CamelCaseMotion_w
map <silent> b <Plug>CamelCaseMotion_b
map <silent> e <Plug>CamelCaseMotion_e
map <silent> ge <Plug>CamelCaseMotion_ge
sunmap w
sunmap b
sunmap e
sunmap ge

let g:gitgutter_sign_added = '∙'
let g:gitgutter_sign_modified = '∙'
let g:gitgutter_sign_removed = '∙'
let g:gitgutter_sign_removed_first_line = '∙'
let g:gitgutter_sign_modified_removed = '∙'

imap <Home> <Esc>^i

let g:used_javascript_libs = 'vue'

let g:user_emmet_settings = {
\   'php': {
\       'extends':'html',
\       'filters':''
\   },
\   'xml':{
\       'extends':'html'
\   }
\}

set tabstop=4 softtabstop=0 expandtab shiftwidth=4 smarttab
set fileformat=unix
set fileformats=unix

set backupdir=~/.vim/backup//
set directory=~/.vim/backup//
set undodir=~/.vim/undodir//
set undofile

command ShowChanges w !diff -u % - | colordiff
