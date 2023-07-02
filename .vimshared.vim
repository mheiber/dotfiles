set clipboard=unnamed

nnoremap <space>w :w<enter>

set path+=** "recursive

nnoremap <D-[> gT
nnoremap <D-]> gt
nnoremap <D-t> :tabnew
nnoremap <D-w> :tabclose

" splits
nnoremap <S-y> "*y
vnoremap <S-y> "*y
nnoremap <S-y>y "*yy
vnoremap <S-y>y "*yy
nnoremap <right> <C-w>10>
nnoremap <left> <C-w>10<
nnoremap <up> :resize -5<Cr>
nnoremap <down> :resize +5<Cr>
" nnoremap <leader>] :cn<cr>
" nnoremap <leader>[ :cp<cr>
noremap <leader>q <Esc>:CoqToLine<Cr>
noremap <M-j> <Esc>:CoqNext<Cr>
noremap <M-k> <Esc>:CoqUndo<Cr>
nnoremap <leader>nn :e ~/dropbox/notes/_next.md<enter>
nnoremap <leader>ee :w<enter>:!erlfmt --write %<enter>

set nocompatible
set suffixesadd+=.js
set mouse=a
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

set nu
set ignorecase
set smartcase
set incsearch
set hlsearch
hi Search cterm=NONE ctermfg=gray ctermbg=blue
set ic

syntax on

set title
set wildignore+=node_modules/**,*/_build/*,*.class,targets/**
set shell=zsh
:inoremap jk <Esc>
"":inoremap fd <Esc>

" newline for braces. see also delimitMate plugin referenced in ~/.vimrc
:inoremap fk {<Enter>}<Esc>O

if has('diffopt')
    set diffopt+=vertical
end

set hidden


" convenience
nnoremap <leader><space> :noh<return>
nnoremap <leader><leader> :b#<CR>
nnoremap <space> :
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

nnoremap Y y$
