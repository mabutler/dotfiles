" set mapleader
let mapleader = " "

" use system clipboard by default
set clipboard=unnamed

" show hidden characters
set hidden
" show line numbers
set number
" show line numbers from cursor
set relativenumber
" make search case insensitive by default
set ignorecase

" show hidden characters
set listchars=tab:>-,trail:~,extends:>,precedes:<
set list

set statusline+=%F
set laststatus=2

" code folding
set foldmethod=indent
set foldlevel=1

" allow moving cursor over line ending
set virtualedit=onemore

set timeoutlen=0

"when indenting up, jump back to current location
"https://vi.stackexchange.com/questions/12366/indent-lines-up-without-moving/
nnoremap > m'>
nnoremap < m'<
onoremap <expr> k v:operator =~ '>\\|<' ? 'k``' : 'k'

colorscheme pt_black
hi LineNr           guifg=#3D3D3D     guibg=black       gui=NONE    ctermfg=darkgray    ctermbg=NONE        cterm=NONE
set background=dark

syntax on
syntax sync minlines=30

call plug#begin()
Plug 'mattn/emmet-vim'
Plug 'KurtPreston/JavaScript-Indent' "fork of the vim-scripts; removes debug statement
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'w0rp/ale'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-commentary'
Plug 'ap/vim-css-color'
Plug 'bkad/CamelCaseMotion'
Plug 'esalter-va/vim-checklist'
Plug 'othree/html5.vim'
Plug 'pangloss/vim-javascript'
Plug 'evanleck/vim-svelte', {'branch': 'main'}
Plug 'jwalton512/vim-blade'
call plug#end()

" CamelCaseMotion
map <silent> w <Plug>CamelCaseMotion_w
map <silent> b <Plug>CamelCaseMotion_b
map <silent> e <Plug>CamelCaseMotion_e
map <silent> ge <Plug>CamelCaseMotion_ge
sunmap w
sunmap b
sunmap e
sunmap ge

" move between vim splits
noremap <silent> <c-k> <C-W>k
noremap <silent> <c-l> <C-W>l
noremap <silent> <c-h> <C-W>h
noremap <silent> <c-j> <C-W>j

" GitGutter
let g:gitgutter_sign_added = '∙'
let g:gitgutter_sign_modified = '∙'
let g:gitgutter_sign_removed = '∙'
let g:gitgutter_sign_removed_first_line = '∙'
let g:gitgutter_sign_modified_removed = '∙'

" Checklist
nnoremap <leader>cc :ChecklistToggleCheckbox<cr>
vnoremap <leader>cc :ChecklistToggleCheckbox<cr>

" move cursor to beginning of line when pressing home in insert mode
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

" use spaces instead of tabs
set tabstop=4 softtabstop=0 expandtab shiftwidth=4 smarttab
set fileformat=unix
set fileformats=unix

" move vim files under hidden folder
set backupdir=~/.vim/backup//
set directory=~/.vim/backup//
set undodir=~/.vim/undodir//
set undofile

" diff unsaved changes with what's on disk
command ShowChanges w !diff -u % - | colordiff

" make *.md open as markdown
autocmd BufNewFile,BufRead *.md set filetype=markdown
autocmd InsertEnter * colorscheme pt_black_insert
autocmd InsertLeave * colorscheme pt_black
