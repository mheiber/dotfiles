source ~/.vimshared.vim

source ~/.vim-co.vim

set termguicolors


" not setting to run on CursorHold 
augroup vimrc
	if !exists("autocommands_loaded")
	    let autocommands_loaded = 1
        " autocmd! FocusGained * call <SID>Colors()
        autocmd! InsertLeave * set nopaste
        autocmd! BufLeave,FocusLost * silent! update
    endif
augroup END

set autowriteall

cnoremap .+ .\{-}

" so vim-fugitive isn't super slow
" let shell='/bin/bash'
 

function! OpenURLUnderCursor()
  let s:uri = expand('<cWORD>')
  let s:uri = substitute(s:uri, '?', '\\?', '')
  let s:uri = shellescape(s:uri, 1)
  if s:uri != ''
    silent exec "!open '".s:uri."'"
    :redraw!
  endif
endfunction
nnoremap gx :call OpenURLUnderCursor()<CR>

" copy relative path to current file
function! <Sid>yf()
    :norm O
    :norm jkccjk
    read !echo %
    :norm kdddd
endfunction

" copy abs path to current file
function! <Sid>yff()
    :norm O
    :norm jkccjk
    read !echo $(pwd)/%
    :norm kdddd
endfunction


" @max

command! -nargs=0 Nu call <SID>nu()
command! -nargs=0 Yf call <SID>yf()
command! -nargs=0 Yff call <SID>yff()

command! Scratch new | setlocal nu bh=wipe nobl bt=nofile

command! -nargs=0 V call <SID>nu()

set diffopt=internal,filler,vertical

command! -nargs=0 Rmswap call <SID>rmswap()

noremap <leader>vr :VimuxRunCommand '
noremap <leader>vv :VimuxRunLastCommand<Cr>
noremap <leader>vt :VimuxRunCommand "test" <Cr>
noremap <leader>vc :VimuxRunCommand "compile" <Cr>

noremap <leader>12 call <SID>ayulight()
noremap <leader>23 :colo codedark<Cr>
noremap <leader>34 :colo base16-outrun-dark<Cr>
noremap <leader>45 call <SID>ayumirage()
noremap <leader>56 call <SID>ayudark()


command! -nargs=+ D :Dispatch! <args>
noremap <leader>. :<Up><Cr>
noremap <leader>i :silent call <SID>zen()<Cr>
noremap <leader>o :cope<Cr>

function <SID>zen()
    :nohlsearch
    :cclose
    :NERDTreeClose
    :UndotreeHide
endfunction
"
"Rust
command! -nargs=0 Cck :Dispatch! cargo check --message-format short
command! -nargs=0 Cct :Dispatch! cargo test --message-format short
command! -nargs=0 Ccb :Dispatch! cargo build
 " Zoom the runner pane (use <bind-key> z to restore runner pane)
"map <Leader>vf :call VimuxZoomRunner()<CR>

map <Leader>vq :VimuxCloseRunner<CR>

" if !exists("g:nnotes")
"     call <SID>notes()
"     let g:nnotes = 1
" endif

function <SID>rmswap()
    :!mkdir -p ~/.local/share/nvim-swap-backup
    :!mv ~/.local/share/nvim/swap/* ~/.local/share/nvim-swap-backup
endfunction

function <SID>erlMan(arg)
    execute 'Dispatch erl -man ' . a:arg . '| col -bx | nvr -'
endfunction

function <SID>nu()
    if &nu
        set signcolumn=yes
        set nonu
    else
        set nu
        set signcolumn=number
    endif
endfunction


" add to status bar. Example:
" set statusline=%{ProgRock()}%{coc#status()}%{get(b:,'coc_current_function','')}
" customization: 
function! ProgRock()
    let magic_width_number = 30
    let width = winwidth(0)
    let lcur = line('.')
    let lend = line('$')
    let full = max([width - magic_width_number, 3])
    let cur_render = float2nr((lcur / (lend + 0.0)) * full)
    let rem_render = (full - cur_render) - 1
    return '|' . RepeatStr('_', cur_render) . RepeatStr(' ', rem_render) . '|'
endfunction

function RepeatStr(str, n)
    let res = ''
    for _ in range(max([a:n, 0]))
        let res .= a:str
    endfor
    return res
endfunction

" let the_range = max([cur_render - strlen(lcur), 0])
" let out .= lcur

nnoremap <leader>ht :call Md()<cr>

let $REBAR_COLOR='none'

let t:termbufnrs = get(t:, 'termbufnrs', [])


" @max
function! Md()
    if len(t:termbufnrs)
        call Mn()
    else
        call Mm()
    endif
endfunction

function! Mm()
    let orig_win_id = win_getid()
    let tabnr = getwininfo(orig_win_id)[0]['tabnr']
    for w in getwininfo()
        if w['terminal'] && w['tabnr'] == tabnr
            let winnr = w['winid']
            call win_gotoid(winnr)
            let t:termbufnrs = add(t:termbufnrs, w['bufnr'])
            wincmd c 
        endif 
    endfor
    " noops if we have closed the original window
    call win_gotoid(orig_win_id)
    echo t:termbufnrs
endfunction

function! Mn()
    for buf in t:termbufnrs
        if bufexists(buf)
            exe 'vs'
            exe 'b' . buf
        endif
    endfor
    let t:termbufnrs = []
endfunction

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


" built-in :Man
runtime ftplugin/man.vim

call plug#begin()
Plug 'jlfwong/vim-mercenary' " :Hgannotate, Hgdiff {rev}, HGShow {rev}
                             " HGCat {rev} {path}  shows file at version
Plug 'ludovicchabant/vim-lawrencium' " more hg stuff :Hg

Plug 'sjl/vitality.vim' " makes FocusLost etc. work with tmux and iterm2
" Plug 'mg979/vim-visual-multi'
Plug 'Raimondi/delimitMate' " matching braces
Plug 'whonore/Coqtail'
Plug 'yuttie/comfortable-motion.vim' " using for C-u C-d and wheel intertial scroll
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'fannheyward/coc-rust-analyzer'
Plug 'tpope/vim-fugitive'
Plug 'will133/vim-dirdiff'
" Plug 'tpope/vim-vinegar'
" normal mode - show current file. explore - goes up
" . append cur file to cmd, ! append cur file to cmd, but start with bang
" y. yank file path, ~ home, gh toggle dotfiles
" plain netrw stuff: mb bookmark, mB delete, qb query bookmarks, gb go to bookmarks
" u/U history
" d/D create/delete directory % file, R rename

" Plug 'tpope/vim-obsession' " :Obsess <?filename> to start session, Obsess! <?filename> to stop


Plug 'vim-voom/VOoM' " :Voom outlines markdown
Plug 'APZelos/blamer.nvim' " activate with :BlamerToggle, is like git lens
" Plug 'airblade/vim-gitgutter' " stage hunk with \hs unstage \hu. ]c next change in file
" not using, instead am using quickfix-reflector for editable quickfix
" Plug 'skwp/greplace.vim' "\vv \vV \vr \vR 
Plug 'tpope/vim-abolish' " crs snake_case crc camelCase crm MixedCase
Plug 'junegunn/fzf' " :FZF and FZF!

Plug 'junegunn/fzf.vim' " Lines, BLines (lines in current buffer)
                     " Buffers, Marks, :History: :History/ Commits BCommits Helptags, FileTypes 
                     " Rr fuzzy ripgrep (edited the source  ./.vim/plugged/fzf.vim/plugin/fzf.vim to change from Rg so wouldn't be shadowed by vim-ripgrep)
                     " Maps, Help
                     "  CTRL-T (new tab) / CTRL-X (new split) / CTRL-V (vs),
                     "  Bang-versions of the commands (e.g. Ag!) will open fzf in fullscreen
Plug 'pbogut/fzf-mru.vim'
Plug 'jremmen/vim-ripgrep'
Plug 'stefandtw/quickfix-reflector.vim' " editable quickfix
Plug 'wellle/targets.vim' " more text objects: in particular 'da,' delete an argument
Plug 'jimenezrick/vimerl' " :ErlangGenServer, :ErlangSupervisor, etc. templates
Plug 'tpope/vim-eunuch' " Mv, Cp, SudoEdit, SudoWrite, Cfind etc. 


Plug 'airblade/vim-rooter/' " :Rooter finds .git or .hg, cd there
Plug 'dhruvasagar/vim-zoom' " <C-w> m
Plug 'mbbill/undotree' " :UndoTree

Plug 'arithran/vim-delete-hidden-buffers'
Plug 'tpope/vim-rsi'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-dispatch'
Plug 'scrooloose/nerdtree'
:
" watch out, neoterm maps comma, which is pure evil
" Plug 'kassio/neoterm'
Plug 'vim-erlang/erlang-motions.vim'
" ]] go to next function declaration [[ previous function declaration ]m next function clause [m previous function clause and more: ]M, [M, ][, [] go to end of next/previous clause/declaration im, am inside/around function clause. vim:
" im, am inside/around function clause
Plug 'michaeljsmith/vim-indent-object' " ii, iI, ai, aI

Plug 'maxbrunsfeld/vim-yankstack' " meta-p and meta-shift-p cycle through yanks


Plug 'machakann/vim-swap'  " g<, g>, gs
" Moving between argument boundaries with [, and ],
" Shifting arguments with <, and >, (duplicate of vim-swap)
" New text objects a, and i,
Plug 'PeterRincker/vim-argumentative' 
" Plug 'skywind3000/quickmenu.vim'
Plug 'will133/vim-dirdiff' " :DirDiff <dir1> <dir2>
Plug 'preservim/vimux' " tmux stuff :Vimux.... or leader shortcuts defined above
" same window switching in tmux and vim, also involves .tmux.conf
" <ctrl-h> => Left
" <ctrl-j> => Down
" <ctrl-k> => Up
" <ctrl-l> => Right
" <ctrl-\> => Previous split
" requires changes in .tmux.conf, too. Not using because ruins ctrl-k (delete
" to end of line)
" Plug 'christoomey/vim-tmux-navigator'

" themes
Plug 'tomasiser/vim-code-dark'
Plug 'ayu-theme/ayu-vim'
Plug 'drewtempelmeyer/palenight.vim' "dark blue and purple
Plug 'savq/melange' "colorful brown without snake green! two variants. nicer one is set background=dark
Plug 'chriskempson/base16-vim' " base16-dune is nice

call plug#end()
let g:vim_markdown_folding_disabled = 1

let g:voom_default_mode='markdown'
" fastcaj
nnoremap <leader>p :FZFMru<cr>
nnoremap <C-p> :Files!<cr>
 " like fzf Rg
nnoremap <leader>f :Rr!<Cr>
nnoremap <leader>L :Lines<Cr>
nnoremap <leader>gg :Commands<Cr>
nnoremap <leader>l :call fzf#vim#buffer_lines('', 1)<cr>
" for re-running previous terminal command
nnoremap <leader>t :w<Esc><C-w>pa<C-p><Enter><C-\><C-n><C-w><C-p>

nnoremap <silent> <C-g> :file<Bar> echon fugitive#statusline()<cr>

set clipboard=unnamedplus

" persistent undo, even if file is closed
set undofile

nnoremap <esc> :w<enter>

nnoremap <leader>vp :e ~/.vimrc<Cr>
nnoremap <leader>s :source $MYVIMRC<Cr>
"
" netrw
"
let g:netrw_altv=1
let g:netrw_preview=1

" nnoremap <leader>t  :CtrlPMRUFiles<cr>

let g:NERDTreeWinPos = "right"
let g:NERDTreeMouseMode=3
" un-comment to disable inertial scroll
let g:comfortable_motion_no_default_key_mappings = 1
"
" nnoremap <silent> <C-d> :call comfortable_motion#flick(100)<CR>
" nnoremap <silent> <C-u> :call comfortable_motion#flick(-100)<CR>

noremap <silent> <ScrollWheelDown> :call comfortable_motion#flick(40)<CR>
noremap <silent> <ScrollWheelUp>   :call comfortable_motion#flick(-40)<CR>

" nnoremap <silent> <C-d> :call comfortable_motion#flick(100)<CR>
" nnoremap <silent> <C-u> :call comfortable_motion#flick(-100)<CR>

" nnoremap <silent> <C-f> :call comfortable_motion#flick(200)<CR>
" nnoremap <silent> <C-b> :call comfortable_motion#flick(-200)<CR>


" augroup NO_CURSOR_MOVE_ON_FOCUS
"   au!
"   au FocusLost * let g:oldmouse=&mouse | set mouse=
"   au FocusGained * if exists('g:oldmouse') | let &mouse=g:oldmouse | unlet g:oldmouse | endif
" augroup END



command! NS !find . -name ".*swp" -delete

if has('nvim')
    :set inccommand=nosplit
    tnoremap jk <C-\><C-n>
    " tnoremap <Esc> <C-\><C-n>
endif

" vim-rooter options
" let g:rooter_use_lcd=0
let g:rooter_cd_cmd="lcd"
let g:rooter_silent_chdir=1
let g:rooter_manual_only = 1


" ripgrep smart case
let g:rg_command = 'rg --vimgrep -S'




let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git\|target\|\.class'
" use nearest .git
let g:ctrlp_working_path_mode = 'r'
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_switch_buffer = 'Et'
" let g:ctrlp_cmd = 'CtrlPBuffer'


filetype plugin indent on
let g:ack_default_options = " --smart-case"

" set noswapfile
" set list
" set ffs=unix

let g:syntastic_ocaml_checkers = ['merlin']





function! ToggleNERDTree()
    if !g:NERDTree.ExistsForTab() || !g:NERDTree.IsOpen()
        if <SID>WindowFileExists()
            :NERDTreeFind
        else
            let cwd = getcwd()
            execute 'NERDTree ' . cwd
        endif
    else
        :NERDTreeClose | :cclose
    endif
endfunction

function! <SID>WindowFileExists()
    let bn = getwininfo(win_getid())[0]['bufnr']
    let b = filter(getbufinfo(), 'v:val["bufnr"] == ' . bn)[0]
    return filereadable(b['name'])
endfunction

" ## added by OPAM user-setup for vim / base ## 93ee63e278bdfc07d1139a748ed3fff2 ## you can edit, but keep this line
" let s:opam_share_dir = system("opam config var share")
" let s:opam_share_dir = substitute(s:opam_share_dir, '[\r\n]*$', '', '')

" let s:opam_configuration = {}

" function! OpamConfOcpIndent()
"   execute "set rtp^=" . s:opam_share_dir . "/ocp-indent/vim"
" endfunction
" let s:opam_configuration['ocp-indent'] = function('OpamConfOcpIndent')

" function! OpamConfOcpIndex()
"   execute "set rtp+=" . s:opam_share_dir . "/ocp-index/vim"
" endfunction
" let s:opam_configuration['ocp-index'] = function('OpamConfOcpIndex')

" ## end of OPAM user-setup addition for vim / base ## keep this line


" BEGIN coc.vim stuff
let g:coc_global_extensions = ['coc-json', 'coc-rust-analyzer', 'coc-toml', 'coc-metals']
" TextEdit might fail if hidden is not set.
set hidden

"" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

"" Give more space for displaying messages.
"set cmdheight=2

"" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
"" delays and poor user experience.
set updatetime=300

"" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

"" Always show the signcolumn, otherwise it would shift the text each time
set signcolumn=number
set nu



" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif


function! Show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')


augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" more coc stuff, from 2013 readme
"
" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#confirm() :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction


"
" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()
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

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)


command! -nargs=0 CC CocAction
" Mappings using CoCList:
" Show all diagnostics.
nnoremap <silent> <leader>ca  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent> <leader>ce  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent> <leader>cc  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent> <leader>co  :<C-u>CocList outline<cr>
" Search workleader symbols.
nnoremap <silent> <leader>cs  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <leader>cj  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <leader>ck  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent> <leader>cp  :<C-u>CocListResume<CR>


nnoremap <nowait><expr> <C-f> coc#float#scroll(1)
nnoremap <nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
inoremap <nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
" set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
set statusline=%{ProgRock()}%{coc#status()}%{get(b:,'coc_current_function','')}

" END coc.vim stuff

" Remember
" leader p is fzf mru

" autosave
" inoremap jk <esc>:w<enter>
" inoremap <C-w>h <esc>:w<enter><C-w>je
" inoremap <C-w>j <esc>:w<enter><C-w>h
" inoremap <C-w>k <esc>:w<enter><C-w>i
" inoremap <C-w>l <esc>:w<enter><C-w>l

":CocInstall coc-rls " rust
":CocInstall coc-coc-metals " scala

" learning
"
" c-w r rotate left
" c-w c-r rotate right
" cw t " go to top window
" c-w x swap with right
" c-w c-x swap with right
" c-w t " go to top window
" c-w b " go to bottom window

" Yf   " custom: rel path to current file
" Yff  " custom: abs path to current file
 
" argument swap and surround
" g<, g>, gs
" move between args
" [, and ],


" Hgannotate
" \gg global commands
" \ca diagnostics
" :CC CocAction -- lightbulby things like extract function, impl trait, derive, etc.
" \cc all coc commands
" \co coc outline
" \gy coc-type-definition
" \gi coc-implementation
" \gr coc-references
" \cj \ck next/prev " don't know what
" [g coc-diagnostic-prev
" ]g coc-diagnostic-next
"
"

" medium 
" let g:ayucolor="mirage" | colo ayu
" colo palenight
" colo base16-helios " nonight
"
" brown
"set background=dark | colo melange
"
" dark
"set background=dark | colo codedark
" colo base16-tomorrow-night-eighties " light grayish almost brown background, blurple accents nonight

" very dark
" let g:ayucolor="dark" | colo ayu
"
" light
set background=light | let g:ayucolor="light" | colo ayu
" let g:ayucolor="light" | colo ayu
" colo base16-tomorrow
" colo base16-summerfruit-light
"
" weird
" colo base16-outrun-dark
" colo base16-synth-midnight-dark
" colo base16-nord "nonight
"
" ## added by OPAM user-setup for vim / ocp-indent ## 1c54bf8ecc4e942e0be824120711a8ad ## you can edit, but keep this line
" if count(s:opam_available_tools,"ocp-indent") == 0
"   source "/Users/mheiber/.opam/4.12.0/share/ocp-indent/vim/indent/ocaml.vim"
" endif
" ## end of OPAM user-setup addition for vim / ocp-indent ## keep this line
set rtp+=/Users/mheiber/.opam/default/share/merlin/vim
helptags /Users/mheiber/.opam/default/share/merlin/vim/doc


" leader t is type
" leader n/p is grow/shrink enclosing last type
" gd is go to definition
" ML and MLI
nnoremap <LocalLeader>r  <Plug>(MerlinRename)
nnoremap <LocalLeader>R  <Plug>(MerlinRenameAppend)
nnoremap <LocalLeader>mc  :MerlinConstruct<Cr>
nnoremap <LocalLeader>md  :MerlinDestruct<Cr>
nnoremap <LocalLeader>me  :MerlinErrorCheck<Cr>
nnoremap gi  :MerlinLocateIntf<Cr>
nnoremap gh  :MerlinDocument<Cr>
" these require ctrlp
" :MerlinILocate                                                *:MerlinILocate*
" MerlinOutline
nnoremap <leader>b :call ToggleNERDTree()<Cr>
