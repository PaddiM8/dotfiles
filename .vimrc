"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=/home/paddi/.vim/dein/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('/home/paddi/.vim/dein')
  call dein#begin('/home/paddi/.vim/dein')

  " Let dein manage dein
  " Required:
  call dein#add('/home/paddi/.vim/dein/repos/github.com/Shougo/dein.vim')
  call dein#add('morhetz/gruvbox')
  call dein#add('tpope/vim-surround')
  call dein#add('jiangmiao/auto-pairs')
  call dein#add('christoomey/vim-tmux-navigator')
  call dein#add('itchyny/lightline.vim')
  call dein#add('w0rp/ale')
  call dein#add('OmniSharp/omnisharp-vim')
  call dein#add('prabirshrestha/asyncomplete.vim')
  call dein#add('prabirshrestha/asyncomplete-ultisnips.vim')
  call dein#add('kjwon15/vim-transparent')
  call dein#add('junegunn/fzf', { 'build': './install --bin', 'merged': 0 })
  call dein#add('junegunn/fzf.vim')
  call dein#add('OrangeT/vim-csharp')
  call dein#add('rhysd/vim-clang-format')
  call dein#add('ludovicchabant/vim-gutentags')
  call dein#add('SirVer/ultisnips')
  call dein#add('honza/vim-snippets')
  call dein#add('scrooloose/nerdtree')
  call dein#add('airblade/vim-gitgutter')
  call dein#add('heavenshell/vim-jsdoc')
  call dein#add('majutsushi/tagbar')
  call dein#add('junegunn/vim-easy-align')
  call dein#add('iamcco/markdown-preview.nvim', {'on_ft': ['markdown', 'pandoc.markdown', 'rmd'], 'build': 'cd app & yarn install' })
  call dein#add('tomtom/tcomment_vim')
  call dein#add('w0rp/ale')
  call dein#add('mattn/emmet-vim')
  call dein#add('sbdchd/neoformat')
  call dein#add('brooth/far.vim')
  call dein#add('dbakker/vim-projectroot')

  " Required:
  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

"End dein Scripts-------------------------

" ------------------------ "
" === General settings === "
" ------------------------ "
set number relativenumber
colorscheme gruvbox
set tabstop=4
set shiftwidth=4
set expandtab
set nowrap
set termguicolors
set background=dark
hi Normal guibg=NONE ctermbg=NONE
set mouse=a
filetype plugin indent on
autocmd FileType cs set colorcolumn=100

" Set <Leader> to space
let mapleader=" "

" Thin cursor in insert mode
let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[4 q"
let &t_EI = "\<Esc>[2 q"

" Display extra whitespace
set list listchars=tab:»·,trail:·,nbsp:·

" Key remaps
inoremap jk <Esc>
vnoremap <Leader>jk <Esc>
nnoremap <Leader>rel :so ~/.vimrc<CR>
nnoremap <Leader>no :noh<CR>
autocmd FileType cs nnoremap =G :OmniSharpCodeFormat<CR>
autocmd FileType qf nnoremap <buffer> <CR> <CR>:cclose<CR>
"autocmd FileType cs nnoremap =G :Neoformat uncrustify<CR>

" --------------- "
" === Plugins === "
" --------------- "

" == OmniSharp == "
let g:OmniSharp_highlight_types = 2
let g:OmniSharp_server_stdio = 1
let g:OmniSharp_highlight_groups = {
\ 'csUserInterface': ['interface name'],
\ 'csUserType': ['class name', 'enum name', 'struct name']
\}
"let g:OmniSharp_server_path = '~/.omnisharp/omnisharp-roslyn/run'


augroup omnisharp_commands
    autocmd!

    " Show type information automatically when the cursor stops moving
    autocmd CursorHold *.cs call OmniSharp#TypeLookupWithoutDocumentation()

    " The following commands are contextual, based on the cursor position.
    autocmd FileType cs nnoremap <buffer> gd :OmniSharpGotoDefinition<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>di :OmniSharpFindImplementations<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>ds :OmniSharpFindSymbol<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>du :OmniSharpFindUsages<CR>

    " Finds members in the current buffer
    autocmd FileType cs nnoremap <buffer> <Leader>dm :OmniSharpFindMembers<CR>

    autocmd FileType cs nnoremap <buffer> <Leader>dx :OmniSharpFixUsings<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>dt :OmniSharpTypeLookup<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>dc :OmniSharpDocumentation<CR>
    autocmd FileType cs nnoremap <buffer> <C-\> :OmniSharpSignatureHelp<CR>
    autocmd FileType cs inoremap <buffer> <C-\> <C-o>:OmniSharpSignatureHelp<CR>

    " Navigate up and down by method/property/field
    autocmd FileType cs nnoremap <buffer> <Leader>k :OmniSharpNavigateUp<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>j :OmniSharpNavigateDown<CR>

    " Find all code errors/warnings for the current solution and populate the quickfix window
    autocmd FileType cs nnoremap <buffer> <Leader>cc :OmniSharpGlobalCodeCheck<CR>
augroup END

" Contextual code actions (uses fzf, CtrlP or unite.vim when available)
nnoremap <Leader><Space> :OmniSharpGetCodeActions<CR>
" Run code actions with text selected in visual mode to extract method
xnoremap <Leader><Space> :call OmniSharp#GetCodeActions('visual')<CR>

" Rename with dialog
nnoremap <Leader>nm :OmniSharpRename<CR>
nnoremap <F2> :OmniSharpRename<CR>
" Rename without dialog - with cursor on the symbol to rename: `:Rename newname`
command! -nargs=1 Rename :call OmniSharp#RenameTo("<args>")

nnoremap <Leader>cf :OmniSharpCodeFormat<CR>
let g:OmniSharp_want_snippet=1

" --------- "
" == ALE == "
" --------- "
let g:ale_linters = {
\ 'cs': ['OmniSharp']
\}

" ------------------ "
" == asyncomplete == "
" ------------------ "
inoremap <expr> <C-x> pumvisible() ? "\<C-n>" : "\<C-x>"
inoremap <expr> <CR>   pumvisible() ? "\<C-n>" : "\<CR>"
call asyncomplete#register_source(asyncomplete#sources#ultisnips#get_source_options({
        \ 'name': 'ultisnips',
        \ 'whitelist': ['*'],
        \ 'completor': function('asyncomplete#sources#ultisnips#completor'),
        \ }))

" --------------- "
" == UltiSnips == "
" --------------- "
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:UltiSnipsSnippetDirectories = ['~/.vim/UltiSnips', 'UltiSnips']

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" ------------- "
" == fzf.vim == "
" ------------- "
nmap <Leader>f :execute 'Files' ProjectRootGuess()<CR>
nmap <Leader>l :BLines<CR>
nmap <Leader>L :Lines<CR>
nmap <Leader>t :BTags<CR>
nmap <Leader>T :Tags<CR>

" --------------- "
" == gutentags == "
" --------------- "
set statusline+=%{gutentags#statusline()}

" -------------- "
" == NERDTree == "
" -------------- "
map <C-n> :NERDTreeToggle<CR>

" Close vim if NERDTree is only window left
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" ------------ "
" == TagBar == "
" ------------ "
nmap <C-a> :TagbarToggle<CR>

" --------------- "
" == lightline == "
" --------------- "
set laststatus=2

" ----------- "
" == jsdoc == "
" ----------- "
nmap <silent> <C-p> <Plug>(jsdoc)
let g:jsdoc_enable_es6=1
let g:jsdoc_input_description=1
let g:jsdoc_additional_descriptions=1

" Vimspector
let g:vimspector_enable_mappings = 'HUMAN'
packadd! vimspector

" easy align
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)


" ----------------- "
" == ClangFormat == "
" ----------------- "
let g:clang_format#style_options = {
            \ "AccessModifierOffset" : -4,
            \ "AllowShortIfStatementsOnASingleLine" : "true",
            \ "Standard" : "C++11",
            \ "BreakBeforeBraces" : "Stroustrup"}

hi Normal guibg=NONE ctermbg=NONE
