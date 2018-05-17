set nocompatible
filetype off                  " required for Vundle
:set suffixesadd+=.js
nnoremap <leader><space> :noh<return>
nnoremap <leader><leader> :b#<CR>
nnoremap <leader>s :source ~/.vimrc<CR>
nnoremap <leader>g :e ~/.vimrc<CR>
nnoremap <leader>q :xall<CR>
nnoremap <right> <C-w>10>
nnoremap <left> <C-w>10<
nnoremap <up> :resize -5<Cr>
nnoremap <down> :resize +5<Cr>
nnoremap <leader>1 :bp<Cr>
nnoremap <leader>2 :bp<Cr>
nnoremap <leader>a :NERDTreeToggle<Cr>
nnoremap <leader>f :NERDTreeFind<Cr>
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'
nnoremap <leader>] :cn<cr>
nnoremap <leader>[ :cp<cr>

nnoremap <leader>c :CoqToCursor<Cr>
inoremap <leader>c <Esc>:CoqToCursor<Cr>


set diffopt+=vertical

command! NS !find . -name ".*swp" -delete

if has('nvim')
    :set inccommand=nosplit
endif

set hidden

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'tomasiser/vim-code-dark'
Plugin 'vim-scripts/vim-auto-save'

" pre-req for coquille
Plugin 'let-def/vimbufsync'
Plugin 'the-lambda-church/coquille'


Plugin 'tomlion/vim-solidity'

Plugin 'mbbill/undotree'
Plugin 'gcmt/taboo.vim'
Plugin 'Raimondi/delimitMate'
Plugin 'maxbrunsfeld/vim-yankstack'
Plugin 'mileszs/ack.vim'

Plugin 'pangloss/vim-javascript'
Plugin 'othree/jspc.vim'
Plugin 'arithran/vim-delete-hidden-buffers'
Plugin 'plasticboy/vim-markdown'
let g:vim_markdown_folding_disabled = 1
if v:version > 704
    Plugin 'Valloric/YouCompleteMe'
endif
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-rsi'
Plugin 'tpope/vim-commentary'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'leafgarland/typescript-vim'
Plugin 'dkprice/vim-easygrep'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-dispatch'
Plugin 'scrooloose/nerdtree'
Plugin 'a.vim'
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'
" use nearest .git
let g:ctrlp_working_path_mode = 'r'
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_switch_buffer = 'Et'
" let g:ctrlp_cmd = 'CtrlPBuffer'
nnoremap <C-p>  :CtrlPBuffer<cr>
nnoremap <C-S-P>  :CtrlP<cr>
nnoremap <leader>t  :CtrlPMRUFiles<cr>


call vundle#end()

filetype plugin indent on
let g:ack_default_options = " --smart-case"

colo codedark
:inoremap jk <Esc>

set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

" set nu
set ignorecase
set smartcase
set incsearch
set hlsearch
hi Search cterm=NONE ctermfg=gray ctermbg=blue
set ic

syntax on

noremap <F3> :MinimapToggle<return>

set title
set wildignore+=node_modules/**

set shell=bash\ --login

" WHY DOESN'T THIS WORK UNTIL I SOURCE A SECOND TIME???!!?!
nnoremap Y y$

