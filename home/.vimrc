" ###########################################################################
" ### LOAD PLUGINS
" ###########################################################################
execute pathogen#infect()
runtime macros/matchit.vim

" ###########################################################################
" ### SET OPTIONS
" ###########################################################################
set autoindent
set backspace=indent,eol,start
set backupcopy=auto
set colorcolumn=80
set completeopt=menuone,preview
set diffopt=filler,vertical
set expandtab
set fileformat=unix
set grepprg=grep\ -sIRin\ --exclude-dir=.git\ --exclude-dir=.tox
set history=15
set hlsearch
set ignorecase
set listchars+=precedes:<,extends:>
set modeline
"set mouse=a
set nowrap
set ruler
set scrolloff=5
set shiftround
set shiftwidth=4
set showcmd
set showmatch
set showmode
set sidescroll=10
set sidescrolloff=20
set smartcase
set smarttab
set softtabstop=4
set tabstop=8
" (wait half-second for mappings and tenth-second for keycodes)
set timeout timeoutlen=500 ttimeoutlen=100
set ttyfast
"set textwidth=0
if has("persistent_undo")
    set undodir=~/.vim/.undo
    set undofile
endif
set updatetime=1000
set visualbell
set wildmenu
set wildmode=list,list:full  " automatically complete first item and show list
set writebackup

" Things to remember when we exit
"""""""""""""""""""""""""""""""""
" '100        marks will be remembered for up to 100 previously edited files
" :500        up to 500 lines of command-line history will be remembered
" %           saves and restores buffer list
" h           disable 'hlsearch' highlighting when starting
" f1          store global marks (A-Z and 0-9)
" n           name used for the viminfo file (must be the last option)
set viminfo='100,:500,%,h,f1,n~/.viminfo

" UTF-8
"""""""
if has("multi_byte")
  set encoding=utf-8
  setglobal fileencoding=utf-8
  "setglobal bomb
  set fileencodings=ucs-bom,utf-8,latin1
endif

"set guioptions-=m
"set guioptions-=M
"set guioptions-=T
"set guioptions-=a
"set guioptions+=c
"set guifont=vt100:h10


" ###########################################################################
" ### FILETYPES
" ###########################################################################

filetype plugin indent on

" Override whatever 'fo' string filetype plugins set
" (see https://groups.google.com/forum/#!topic/vim_dev/EKDS1PP4rPo)
autocmd FileType * setlocal formatoptions+=qroj

let maplocalleader = ","


" ###########################################################################
" ### SYNTAX HIGHLIGHTING
" ###########################################################################

syntax on

"hi Comment      term=none       ctermfg=cyan       cterm=bold
"hi Constant     term=underline  ctermfg=magenta    cterm=none
"hi Identifier   term=underline  ctermfg=green      cterm=none
"hi Statement    term=bold       ctermfg=yellow     cterm=bold
"hi PreProc      term=underline  ctermfg=red   cterm=bold
"hi Type         term=underline  ctermfg=yellow     cterm=bold
"hi Special      term=bold       ctermfg=red        cterm=bold
"hi Nontext      term=bold       ctermfg=blue       cterm=bold
hi Normal       ctermfg=darkgreen
"hi Search       term=underline cterm=underline ctermfg=magenta ctermbg=none

"color ir_black
"color vividchalk
"color jellybeans
"color inkpot
"color delek

color molokai
"color murphy

" Custom highlights
"""""""""""""""""""
hi Normal       ctermbg=235
hi Visual       term=reverse ctermbg=4
hi Search       cterm=underline,bold ctermfg=yellow ctermbg=magenta
hi WarningMsg   ctermfg=yellow ctermbg=red
hi ColorColumn  ctermbg=blue ctermfg=yellow

" Vimdiff mode
""""""""""""""
"if &diff
    "colorscheme <some_scheme> works here
    highlight DiffAdd term=reverse cterm=bold ctermbg=green ctermfg=black
    highlight DiffChange term=reverse cterm=none ctermbg=cyan ctermfg=black
    highlight DiffText term=reverse cterm=none ctermbg=blue ctermfg=white
    highlight DiffDelete term=reverse cterm=none ctermbg=black ctermfg=red
"endif

"color desert

" ###########################################################################
" ### CUSTOMIZE THINGS!
" ###########################################################################

" Restore cursor position when opening file
"""""""""""""""""""""""""""""""""""""""""""
function! ResCur()
  if line("'\"") <= line("$")
    normal! g`"
    return 1
  endif
endfunction

augroup resCur
  autocmd!
  autocmd BufWinEnter * call ResCur()
augroup END

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Fix internal keycodes when running under TERM=screen in tmux
" (sequences wildcarded to make modifiers work as well (<S-F1>, <C-F1>, etc))
"
"       Run `set -g xterm-keys on' in tmux to make this work.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if &term =~ '^screen' && exists('$TMUX')
    execute "set <xUp>=\e[1;*A"
    execute "set <xDown>=\e[1;*B"
    execute "set <xRight>=\e[1;*C"
    execute "set <xLeft>=\e[1;*D"
    execute "set <xHome>=\e[1;*H"
    execute "set <xEnd>=\e[1;*F"
    execute "set <Insert>=\e[2;*~"
    execute "set <Delete>=\e[3;*~"
    execute "set <PageUp>=\e[5;*~"
    execute "set <PageDown>=\e[6;*~"
    execute "set <xF1>=\e[1;*P"
    execute "set <xF2>=\e[1;*Q"
    execute "set <xF3>=\e[1;*R"
    execute "set <xF4>=\e[1;*S"
    execute "set <F5>=\e[15;*~"
    execute "set <F6>=\e[17;*~"
    execute "set <F7>=\e[18;*~"
    execute "set <F8>=\e[19;*~"
    execute "set <F9>=\e[20;*~"
    execute "set <F10>=\e[21;*~"
    execute "set <F11>=\e[23;*~"
    execute "set <F12>=\e[24;*~"
endif

" Emacs-style keybindings (for Insert and Command-line modes)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
noremap! <C-a>      <Home>
" C-e is useful to cancel completion PUM--don't break it.
noremap! <expr> <C-e> pumvisible() ? "\<C-e>" : "<End>"
noremap! <C-b>      <Left>
noremap! <C-f>      <Right>
noremap! <C-u>      <C-e><C-u>
noremap! <C-d>      <Del>
"can't do these on command-line; Insert only (sends Escape):
inoremap <C-k>      <ESC>lC
inoremap <C-t>      <ESC>xhpa
"timeoutlen and ttimeoutlen don't seem to do what i want;
"don't allow these in Insert mode:
cnoremap <ESC>b     <S-Left>
cnoremap <ESC>f     <S-Right>
"don't let these screw up the command-line if pressed on accident:
cmap     <ESC>d     <Nop>
cmap     <C-k>      <Nop>

" Search and replace
""""""""""""""""""""
nnoremap <LocalLeader>ra :%s/<C-r><C-w>//gc<Left><Left><Left>

" Netrw browser
"""""""""""""""
"(like vim-vinegar)
nnoremap - :silent edit <C-R>=empty(expand('%')) ? '.' : expand('%:p:h')<CR><CR>
" don't return to netrw with ^6, go to the file i was editing previously!
let g:netrw_altfile = 1

" QuickFix window
"""""""""""""""""
"force the qf window to a dynamic height
"au WinEnter * call ResizeQuickfixWindow(3, 10)
function! ResizeQuickfixWindow(minheight, maxheight)
    set lazyredraw      " redraw after executing the function.
    set ei=WinEnter     " ignore WinEnter events for now.
    let jumpPrev = 0    " whether we need to jump back to a previous window

    " if current window is NOT quickfix window
    if (getbufvar(winbufnr(winnr()), "&buftype") != "quickfix")
        " iterate ALL windows to find quickfix window (if it exists)
        let jumpPrev = 1  " make sure we jump back to our non-QF window
        let i = 1
        while (winbufnr(i) != -1)
            if (getbufvar(winbufnr(i), "&buftype") == "quickfix")
                " jump to the QF window
                exe i . "wincmd w"
                break
            endif
            let i += 1
        endwhile
    endif

    " set the damn height.
    exe max([min([line("$"), a:maxheight]), a:minheight]) . "wincmd _"

    " return to our previous window (if we came from one)
    if jumpPrev
        wincmd p
    endif

    unlet jumpPrev
    set ei-=WinEnter
    set nolazyredraw
endfunction

au FileType qf call AdjustWindowHeight(3, 10)
function! AdjustWindowHeight(minheight, maxheight)
    exe max([min([line("$"), a:maxheight]), a:minheight]) . "wincmd _"
endfunction
"force the quickfix window to the BOTTOM
"(to fix things when tagbar is active)
"autocmd FileType qf botright cwindow
autocmd FileType qf wincmd J
"automatically show global/local quickfix windows
autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow
"focus (very bottom)
nnoremap <LocalLeader>gf <C-w>b

" Window management
"""""""""""""""""""
nnoremap <LocalLeader>w <c-w>
nnoremap <LocalLeader>we <c-w>=
nnoremap <LocalLeader>ww <c-w>p

" Yank
""""""
nnoremap Y y$

" Put
"""""
"toggle
" nnoremap <F1> :set paste<CR>
" nnoremap <S-F1> :set nopaste<CR>
"one-time paste for insert-mode
"inoremap <F1> <C-o>:call Setup_paste()<CR>

" Writing/quiting files
"""""""""""""""""""""""
noremap <F4> :w<CR>
inoremap <F4> <ESC>:w<CR>
noremap  <F7> :wq<CR>
inoremap <F7> <ESC>:wq<CR>
noremap <F5> :q<CR>
noremap <S-F5> :qa<CR>
noremap <F8> :q!
noremap <S-F8> :qa!

" Search highlighting
"""""""""""""""""""""
map <F9> :nohl<CR>
imap <F9> <C-o>:nohl<CR>
map <S-F9> :set hls<CR>
imap <S-F9> <C-o>:set hls<CR>

" Pan left/right
""""""""""""""""
noremap <ESC>l z10l
noremap <ESC>h z10h

" Toggle folds
""""""""""""""
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
noremap <LocalLeader>z zi

" Refresh diff highlighting
"""""""""""""""""""""""""""
noremap <LocalLeader>du :diffupdate<CR>

" Prevent window death
""""""""""""""""""""""
nnoremap <C-w>o :echoerr "Go fuck yourself :-)"<CR>
nnoremap <C-w><C-o> :echoerr "Go fuck yourself :-)"<CR>

" List buffers
""""""""""""""
nnoremap <LocalLeader>b :ls<CR>
if !empty(glob("~/.vim/bundle/fzf.vim"))  " (not loaded yet)
    nnoremap <LocalLeader>b :Buffers<CR>
endif


" ###########################################################################
" ###########################################################################
" #########  PLUGIN CONFIGURATION  ##########################################
" ###########################################################################
" ###########################################################################
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Ack (ack.vim)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" create key mapping and use 'ag' if possible
if executable('ag')
    let g:ackprg = 'ag --vimgrep'
    nnoremap gr :Ack!<Space>
else
    nnoremap gr :vimgrep //j **<Left><Left><Left><Left><Left>
endif

" change default bindings to something not awful
let g:ack_mappings = {
    \ "t": "<C-w>gF",
    \ "T": "<C-w>gFgT",
    \ "go": "<CR>",
    \ "gO": "<CR><C-w>p",
    \ "gh": "<C-w><CR>",
    \ "gH": "<C-w><CR><C-w>b",
    \ "gv": "<C-w>k:vnew<CR><C-w>b<CR>",
    \ "gV": "<C-w><CR><C-W>H<C-W>b<C-W>J" }

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Easy Align (vim-easy-align)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
vnoremap <Enter> <Plug>(EasyAlign)

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Fugitive (vim-fugitive)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if !empty(glob("~/.vim/bundle/vim-fugitive"))
    set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P
    let g:fugitive_github_domains = ['github.com', 'github.evilcorp.com']
endif

nnoremap <LocalLeader>gg :Gstatus<CR>
nnoremap <LocalLeader>gl :Glog --<CR>
nnoremap <LocalLeader>gL :Glog -- %<CR>
nnoremap <LocalLeader>gS :Glog -S
nnoremap <LocalLeader>gr :Ggrep<SPACE>
nnoremap <LocalLeader>gb :Gblame<CR>
nnoremap <LocalLeader>gB :Gbrowse!<CR>
nnoremap <LocalLeader>ge :Gedit<CR>
nnoremap <LocalLeader>gw :Gwrite<CR>
nnoremap <LocalLeader>gR :Gread<CR>
nnoremap <LocalLeader>gd :Gdiff<CR>
nnoremap <LocalLeader>gc :Gcommit<CR>
nnoremap <LocalLeader>gppo :Gpush origin HEAD<CR>
nnoremap <LocalLeader>gppf :Gpush origin HEAD --force<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Gist (gist-vim)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"let g:gist_post_private = 1
let g:gist_show_privates = 1
"let g:gist_open_browser_after_post = 1
"let g:gist_api_url = 'https://github.evilcorp.com/api/v3'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" NERDTree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" don't use unicode arrow glyphs
"let NERDTreeDirArrows = 0

let NERDTreeHijackNetrw = 1
let NERDTreeShowBookmarks = 1
let NERDTreeShowHidden = 1
let NERDTreeMinimalUI = 1

" swap highlighting of directories and symlinks
hi link NERDTreeDir Macro
hi link NERDTreeLink Directory

" highlight current line in NERDTree
autocmd FileType nerdtree :setl cursorline

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Tagbar
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" focus tagbar when opening it
let g:tagbar_autofocus = 1
" don't use unicode arrow glyphs
let g:tagbar_iconchars = ['+', '-'] 

" toggle/focus (far right)
nnoremap <LocalLeader>tt :TagbarToggle<CR>
nnoremap <LocalLeader>gt 99<C-w>l

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" UltiSnips
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" trigger
let g:UltiSnipsExpandTrigger="<Tab>"
let g:UltiSnipsJumpForwardTrigger="<Tab>"
let g:UltiSnipsJumpBackwardTrigger="<S-Tab>"

" this lets :UltiSnipsEdit split your window
let g:UltiSnipsEditSplit="vertical"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Unimpaired (vim-unimpaired)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" make :cnext and :cprevious easier on my keymap
noremap ]j :cnext<CR>
noremap ]k :cprevious<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" YouCompleteMe
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" don't use <tab> to cycle thru PUM, use ^n and ^p as we're used to doing.
" this also solves problems with using UltiSnips simultaneously, which uses
" <tab> as its default trigger.
let g:ycm_key_list_select_completion=['<C-n>']
let g:ycm_key_list_previous_completion=['<C-p>']

" read tags file
let g:ycm_collect_identifiers_from_tags_files = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" IndentGuides
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <LocalLeader>ig <Plug>IndentGuidesToggle

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Airline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:airline_powerline_fonts = 1  "sudo pacaur -S powerline-fonts ttf-devicons

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" FZF completion
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" File search
noremap <LocalLeader>v :Files<SPACE>

" Mapping selecting mappings
nmap <LocalLeader><TAB> <Plug>(fzf-maps-n)
xmap <LocalLeader><TAB> <Plug>(fzf-maps-x)
omap <LocalLeader><TAB> <Plug>(fzf-maps-o)

" Customize fzf colors to match current color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }
