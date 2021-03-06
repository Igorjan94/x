"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
filetype plugin indent on

set nocompatible
filetype off 
Bundle         'Igorjan94/codeforces.vim'
Bundle     'terryma/vim-multiple-cursors'
"Bundle            'vim-scripts/dbext.vim'
Bundle                   'kien/ctrlp.vim'
Bundle               'Shougo/vimproc.vim'
Bundle                'majutsushi/tagbar'
Bundle           'Valloric/YouCompleteMe'
Bundle             'scrooloose/syntastic'
"Bundle                 'travitch/hasksyn'
"Bundle               'tpope/vim-surround'
Bundle                    'gmarik/vundle'
"Bundle                'vim-scripts/a.vim'
Bundle         'scrooloose/nerdcommenter'
Bundle              'scrooloose/nerdtree'
"Bundle                'eagletmt/neco-ghc'
"Bundle              'eagletmt/ghcmod-vim'
Bundle                  'mbbill/undotree'
Bundle                'bling/vim-airline'
"Bundle               'tpope/vim-fugitive'
Bundle          'Lokaltog/vim-easymotion'
Bundle 'altercation/vim-colors-solarized'
Bundle       'dhruvasagar/vim-table-mode'
"Bundle      'Twinside/vim-haskellConceal'
"Bundle              'Twinside/vim-hoogle'
"Bundle                   'mattn/gist-vim'
"Bundle                 'mattn/webapi-vim'
"Bundle                    'bitc/lushtags'
Bundle             'itchyny/calendar.vim'
"Bundle            'itchyny/thumbnail.vim'
"Bundle    'xuhdev/vim-latex-live-preview'
"Bundle         'LaTeX-Box-Team/LaTeX-Box'
Bundle          'junegunn/vim-easy-align'
Bundle           'airblade/vim-gitgutter'
"Bundle               'takac/vim-hardtime'
"Bundle             'vim-scripts/Tabmerge'
Bundle       'powerman/vim-plugin-ruscmd'
Bundle     'kien/rainbow_parentheses.vim'
"Bundle                   'wting/rust.vim'
Bundle          'idris-hackers/idris-vim'
Bundle            'crusoexia/vim-monokai'
Bundle          'pangloss/vim-javascript'
Bundle     'crusoexia/vim-javascript-lib'
Bundle                   'matze/vim-move'

set nocp
filetype plugin on


set history=700
set confirm
set cindent

"TODO disable in vimrc

" Enable filetype plugins
filetype plugin on
filetype indent on
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

command! WQ wq
command! Wq wq
command! W w
command! Q q

autocmd vimenter * cd %:p:h

set nocompatible
set hidden
filetype indent plugin on | syn on

" Start interactive EasyAlign in visual mode
vmap <Enter> <Plug>(EasyAlign)
nmap s <Plug>(easymotion-s2)
map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)
map  n <Plug>(easymotion-next)
map  N <Plug>(easymotion-prev)

let g:calendar_google_calendar = 1
let g:calendar_google_task = 1

let NERDTreeShowHidden=1
let NERDTreeQuitOnOpen=1

au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

let g:airline#extensions#syntastic#enabled = 1
let g:airline_theme='dark'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '◀'
let g:airline_detect_modified=1
let g:airline_detect_paste=1

" How many lines should be searched for context
let g:hasksyn_indent_search_backward = 100

" Should we try to de-indent after a return
let g:hasksyn_dedent_after_return = 1

" Should we try to de-indent after a catchall case in a case .. of
let g:hasksyn_dedent_after_catchall_case = 1

let tagbar_autofocus=1
let tagbar_autoclose=1

let g:EclimCompletionMethod = 'omnifunc'

let g:ycm_server_keep_logfiles = 1
let g:ycm_server_log_level = 'debug'
let g:ycm_path_to_python_interpreter = '/usr/bin/python2'
let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
let g:ycm_semantic_triggers =  {
  \   'c' : ['->', '.'],
  \   'cpp' : ['->', '.', '::'],
  \   'objc' : ['->', '.'],
  \   'ocaml' : ['.', '#'],
  \   'cpp,objcpp' : ['->', '.', '::'],
  \   'perl' : ['->'],
  \   'php' : ['->', '::'],
  \   'cs,java,javascript,d,vim,python,perl6,scala,vb,elixir,go' : ['.'],
  \   'ruby' : ['.', '::'],
  \   'lua' : ['.', ':'],
  \   'erlang' : [':'],
  \ }


set fencs=utf-8,cp1251,koi8-r,ucs-2,cp866
au FileType qf call AdjustWindowHeight(3, 10)
function! AdjustWindowHeight(minheight, maxheight)
  exe max([min([line("$")+1, a:maxheight]), a:minheight]) . "wincmd _"
endfunction

" Set Russian key to understand
"set keymap=russian-cukenwin
set iminsert=0
set imsearch=0
imap <F10> <Esc>:TagbarToggle<CR>
nmap <F10> <Esc>:TagbarToggle<CR>
imap <F11> <Esc>:NERDTreeToggle<CR>
nmap <F11> <Esc>:NERDTreeToggle<CR>
" Num strings
set nu!
set ai!
set cin!
"imap <C-S-v> <S-Insert>
" Set to auto read when a file is changed from the outside
set autoread

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","
set viminfo='10,\"100,:20,%,n~/.viminfo
    au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm
$"|endif|endif

map <leader>Q :let @+ = system("pastebinit " . " -f " . &filetype . " " . expand("%"))<CR>

" Fast saving
"map <C-E> <Esc>:tabedit %<.h<CR>
vnoremap p "_dP
nnoremap <C-u> :UndotreeToggle<CR>
imap <F5> <Esc> :tabprev<CR><leader>cd
map <F5> :tabprev<CR><leader>cd
nmap <leader>w :w!<cr>
nmap <F2> <Esc>:w<CR>
map <F2> <Esc>:w<CR>
imap <F2> <Esc>:w<CR>
imap <F6> <Esc> :tabnext<CR><leader>cd
map <F6> :tabnext <CR><leader>cd
function! GAC()
    call inputsave()
    let commit = input('Commit message: ')
    call inputrestore()
    let aaa = system("git add " . expand("%") . " && git commit -m \"" . commit . "\"")
    echom aaa
endfunction
let Tlist_Exit_OnlyWindow = 1
" put from clipboard
nmap <leader>p "+p
nmap <leader>P "+P
map cn <ESC>:cn<CR>
map cb <ESC>:cp<CR>
" yank to clipboard 
map <leader>y "+y
map <C-A> ggvG$"+y''
set wildmenu
set wcm=<Tab>
menu Exit.quit     :quit<CR>
menu Exit.quit!    :quit!<CR>
menu Exit.save     :exit<CR>
map <F3> :emenu Exit.<Tab>
 function! InsertTabWrapper(direction)
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    elseif "backward" == a:direction
        return "\<c-p>"
    else
        return "\<c-n>"
    endif
 endfunction
 inoremap <tab> <c-r>=InsertTabWrapper ("forward")<cr>
 inoremap <s-tab> <c-r>=InsertTabWrapper ("backward")<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" Turn on the WiLd menu
set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc

"Always show current position
set ruler

" Height of the command bar
set cmdheight=1

" A buffer becomes hidden when it is abandoned
set hid

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases 
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" Don't redraw while executing macros (good performance config)
set lazyredraw

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch
" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax enable

let g:solarized_termcolors=256
colorscheme solarized "desert
"colorscheme torte
set background=dark

" Set extra options when running in GUI mode
if exists('$WINDOWID')
    set t_Co=256
endif

if has("gui_running")
    set guioptions-=T
    set guioptions+=e
    set guitablabel=%M\ %t
endif

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8
" Use Unix as the standard file type
set ffs=unix,dos,mac


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4
set shiftround                  "Round spaces to nearest shiftwidth multiple
set nojoinspaces                "Don't convert spaces to tabs

" Linebreak on 500 characters
set lbr
set tw=500

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines


""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""
" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Treat long lines as break lines (useful when moving around in them)
map j gj
map k gk

" Map <Space> to / (search) and Ctrl-<Space> to ? (backwards search)
map <space> /
map <leader><space> <ESC>:%s/

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Close the current buffer
map <leader>bd :Bclose<cr>

" Close all the buffers
map <leader>ba :1,1000 bd!<cr>

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Specify the behavior when switching between buffers 
try
  set switchbuf=useopen,usetab,newtab
  set stal=2
catch
endtry

" Return to last edit position when opening files (You want this!)


""""""""""""""""""""""""""""""
" => Status line
""""""""""""""""""""""""""""""
" Always show the status line
set laststatus=2

" Format the status line
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remap VIM 0 to first non-blank character
map 0 ^

" Delete trailing white space on save, useful for Python and CoffeeScript ;)
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()
autocmd BufWrite *.coffee :call DeleteTrailingWS()


" Toggle paste mode on and off
map <leader>v :setlocal paste!<cr>



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction


" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    en
    return ''
endfunction
set langmap=ёйцукенгшщзхъфывапролджэячсмитьбюЁЙЦУКЕHГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ;`qwertyuiop[]asdfghjkl\\;'zxcvbnm\\,.~QWERTYUIOP{}ASDFGHJKL:\\"ZXCVBNM<>

set relativenumber
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>
"set list
"set listchars=tab:▸\ ,eol:¬
" set cursorline
set undofile
" Combining marks
"imap <leader>over`  ̀
"imap <leader>over'  ́
"imap <leader>over^  ̂
"imap <leader>overv  ̌
"imap <leader>over~  ̃
"imap <leader>over-  ̄
"imap <leader>over_  ̅
"imap <leader>over–  ̅
"imap <leader>over—  ̅
"imap <leader>overcup  ̆
"imap <leader>overcap  ̑
"imap <leader>over.  ̇
"imap <leader>over..  ̈
"imap <leader>over"  ̈
"imap <leader>over...  ⃛
"imap <leader>overright.  ͘
"imap <leader>overo  ̊
"imap <leader>over``  ̏
"imap <leader>over''  ̋
"imap <leader>overvec  ⃑
"imap <leader>vec  ⃑
"imap <leader>overlvec  ⃐
"imap <leader>lvec  ⃐
"imap <leader>overarc  ⃕
"imap <leader>overlarc  ⃔
"imap <leader>overto  ⃗
"imap <leader>overfrom  ⃖
"imap <leader>overfromto  ⃡
"imap <leader>over*  ⃰
"imap <leader>under`  ̖
"imap <leader>under'  ̗
"imap <leader>under,  ̗
"imap <leader>under.  ̣
"imap <leader>under..  ̤
"imap <leader>under"  ̤
"imap <leader>undero  ̥
"imap <leader>under-  ̱
"imap <leader>under_  ̲
"imap <leader>under–  ̲
"imap <leader>under—  ̲
"imap <leader>through~  ̴
"imap <leader>through-  ̵
"imap <leader>through_  ̶
"imap <leader>through–  ̶
"imap <leader>through—  ̶
"imap <leader>through/  ̷
"imap <leader>not  ̷
"imap <leader>through?  ̸
"imap <leader>Not  ̸
"imap <leader>through\|  ⃒
"imap <leader>throughshortmid  ⃓
"imap <leader>througho  ⃘

"" Math
"imap <leader>: ∶
"imap <leader>:: ∷
"imap <leader>;  ﹔
"imap <leader>.. ‥
"imap <leader>=? ≟
"imap <leader>all ∀
"imap <leader>always □
"imap <leader>approx ≈
"imap <leader>bot ⊥
"imap <leader>box □
"imap <leader>boxdot ⊡
"imap <leader>box. ⊡
"imap <leader>boxminus ⊟
"imap <leader>box- ⊟
"imap <leader>boxplus ⊞
"imap <leader>box+ ⊞
"imap <leader>boxtimes ⊠
"imap <leader>box* ⊠
"imap <leader>bul •
"imap <leader>C ℂ
"imap <leader>cdot ∙
"imap <leader>. ∙
"imap <leader>cdots ⋯
"imap <leader>check ✓
"imap <leader>yes ✓
"imap <leader>Check ✔
"imap <leader>Yes ✔
"imap <leader>circ ∘
"imap <leader>clock ↻
"imap <leader>cclock ↺
"imap <leader>comp ∘
"imap <leader>contra ↯
"imap <leader>deg °
"imap <leader>den ⟦⟧<left>
"imap <leader>diamond ◇
"imap <leader>dots …
"imap <leader>down ↓
"imap <leader>downtri ▼
"imap <leader>Down ⇓
"imap <leader>dunion ⨃
"imap <leader>du ⨃
"imap <leader>ell ℓ
"imap <C-l> ℓ
"imap <leader>empty ∅
"imap <leader>equiv ≡
"imap <leader>eq ≡
"imap <leader>eventually ◇
"imap <leader>exists ∃
"imap <leader>flat ♭
"imap <leader>fold ⦇⦈<left>
"imap <leader>(\| ⦇
"imap <leader>\|) ⦈
"imap <leader>forall ∀
"imap <leader>from ←
"imap <leader><- ←
"imap <leader>From ⇐
"imap <leader>fromto ↔
"imap <leader>Fromto ⇔
"imap <leader>ge ≥
"imap <leader>glub ⊓
"imap <leader>iff ⇔
"imap <leader>implies ⇒
"imap <leader>impliedby ⇐
"imap <leader>in ∈
"imap <leader>infty ∞
"imap <leader>inf ∞
"imap <leader>int ∫
"imap <leader>intersect ∩
"imap <leader>iso ≅
"imap <leader>join ⋈
"imap <leader>land ∧
"imap <leader>langle ⟨
"imap <leader>lbrac ⟦
"imap <leader>[[ ⟦
"imap <leader>ldots …
"imap <leader>ldown ⇃
"imap <leader>leadsto ⇝
"imap <leader>~> ⇝
"imap <leader>le ≤
"imap <leader>lift ⌊⌋<left>
"imap <leader>floor ⌊⌋<left>
"imap <leader>llangle ⟪
"imap <leader>longto ⟶ 
"imap <leader>-- ⟶ 
"imap <leader>– ⟶ 
"imap <leader>lor ∨
"imap <leader>lower ⌈⌉<left>
"imap <leader>ceil ⌈⌉<left>
"imap <leader>lub ⊔
"imap <leader>lup ↿
"imap <leader>mapsto ↦
"imap <leader>map ↦
"imap <leader>mid ∣
"imap <leader>models ⊨
"imap <leader>\|= ⊨
"imap <leader>N ℕ
"imap <leader>ne ≠
"imap <leader>nearrow ↗
"imap <leader>Nearrow ⇗
"imap <leader>neg ¬
"imap <leader>/= ≠
"imap <leader>nequiv ≢
"imap <leader>neq ≢
"imap <leader>nexist ∄
"imap <leader>none ∄
"imap <leader>ni ∋
"imap <leader>ni ∋
"imap <leader>nin ∉
"imap <leader>niso ≇
"imap <leader>notin ∉
"imap <leader>nwarrow ↖
"imap <leader>Nwarrow ⇖
"imap <leader>oast ⊛
"imap <leader>odot ⊙
"imap <leader>o. ⊙
"imap <leader>of ∘
"imap <leader>o ∘
"imap <leader>ominus ⊖
"imap <leader>o- ⊖
"imap <leader>oplus ⊕
"imap <leader>o+ ⊕
"imap <leader>oslash ⊘
"imap <leader>o/ ⊘
"imap <leader>otimes ⊗
"imap <leader>o* ⊗
"imap <leader>par ∂
"imap <leader>pge ≽
"imap <leader>pgt ≻
"imap <leader>ple ≼
"imap <leader>plt ≺
"imap <leader>p≥ ≽
"imap <leader>p> ≻
"imap <leader>p≤ ≼
"imap <leader>p< ≺
"imap <leader>pm ±
"imap <leader>prec ≼
"imap <leader>prod ∏
"imap <leader>proves ⊢
"imap <leader>\|- ⊢
"imap <leader>provedby ⊣
"imap <leader>Q ℚ
"imap <leader>qed ∎
"imap <leader>R ℝ
"imap <leader>rangle ⟩
"imap <leader>rbrac ⟧
"imap <leader>]] ⟧
"imap <leader>rdown ⇂
"imap <leader>righttri ▸
"imap <leader>rrangle ⟫
"imap <leader>rup ↾
"imap <leader>searrow ↘
"imap <leader>Searrow ⇘
"imap <leader>setminus ∖
"imap <leader>sharp ♯
"imap <leader># ♯
"imap <leader>sim ∼
"imap <leader>simeq ≃
"imap <leader>some ∃
"imap <C-e> ∃
"imap <leader>sqge ⊒
"imap <leader>sqgt ⊐
"imap <leader>sqle ⊑
"imap <leader>sqlt ⊏
"imap <leader>s≥ ⊒
"imap <leader>s> ⊐
"imap <leader>s≤ ⊑
"imap <leader>s< ⊏
"imap <leader>sqr ²
"imap <leader>sqrt √
"imap <leader>star ✭
"imap <leader>subset ⊂
"imap <leader>sub ⊂
"imap <leader>subseteq ⊆
"imap <leader>subeq ⊆
"imap <leader>subsetneq ⊊
"imap <leader>subneq ⊊
"imap <leader>sum ∑
"imap <leader>supset ⊃
"imap <leader>sup ⊃
"imap <leader>supseteq ⊇
"imap <leader>supeq ⊇
"imap <leader>supsetneq ⊋
"imap <leader>supneq ⊋
"imap <leader>swarrow ↙
"imap <leader>Swarrow ⇙
"imap <leader>thus ∴
"imap <leader>times ×
"imap <leader>* ×
"imap <leader>to →
"imap <leader>- →
"imap <C-_> →
"imap <leader>To ⇒
"imap <leader>= ⇒
"imap <leader>top ⊤
"imap <leader>tuple ⟨⟩<left>
"imap <leader>up ↑
"imap <leader>updown ↕
"imap <leader>ud ↕
"imap <leader>unfold ⦉⦊<left>
"imap <leader><\| ⦉
"imap <leader>\|> ⦊
"imap <leader>up;down ⇅
"imap <leader>u;d ⇅
"imap <leader>uptri ▲
"imap <leader>Up ⇑
"imap <leader>union ∪
"imap <leader>vdots ⋮
"imap <leader>voltage ⚡
"imap <leader>xmark ✗
"imap <leader>no ✗
"imap <leader>Xmark ✘
"imap <leader>No ✘
"imap <leader>Z ℤ

"" Not math
"imap <leader>sec §

"" Superscripts
"imap <leader>⁰ ⁰
"imap <leader>¹ ¹
"imap <leader>² ²
"imap <leader>³ ³
"imap <leader>⁴ ⁴
"imap <leader>⁵ ⁵
"imap <leader>⁶ ⁶
"imap <leader>⁷ ⁷
"imap <leader>⁸ ⁸
"imap <leader>⁹ ⁹
"imap <leader>ⁿ ⁿ
"imap <leader>^i ⁱ
"imap <leader>⁺ ⁺
"imap <leader>⁻ ⁻
"imap <leader>' ′
"imap <leader>'' ″
"imap <leader>''' ‴
"imap <leader>'''' ⁗
"imap <leader>" ″
"imap <leader>"" ⁗
"imap <leader>` ‵
"imap <leader>`` ‶
"imap <leader>``` ‷

"" Subscripts
"imap <leader>0 ₀
"imap <leader>1 ₁
"imap <leader>2 ₂
"imap <leader>3 ₃
"imap <leader>4 ₄
"imap <leader>5 ₅
"imap <leader>6 ₆
"imap <leader>7 ₇
"imap <leader>8 ₈
"imap <leader>9 ₉
"imap <leader>_i ᵢ
"imap <leader>_j ⱼ
"imap <leader>_+ ₊
"imap <leader>_- ₋
"imap <leader>p0 π₀
"imap <leader>p1 π₁
"imap <leader>p2 π₂
"imap <leader>p3 π₃
"imap <leader>p4 π₄
"imap <leader>p5 π₅
"imap <leader>p6 π₆
"imap <leader>p7 π₇
"imap <leader>p8 π₈
"imap <leader>p9 π₉
"imap <leader>i0 ι₀
"imap <leader>i1 ι₁
"imap <leader>i2 ι₂
"imap <leader>i3 ι₃
"imap <leader>i4 ι₄
"imap <leader>i5 ι₅
"imap <leader>i6 ι₆
"imap <leader>i7 ι₇
"imap <leader>i8 ι₈
"imap <leader>i9 ι₉

"" Greek (lower)
"imap <leader>alpha α
"imap <leader>a α
"imap <leader>beta β
"imap <leader>b β
"imap <leader>gamma γ
"imap <leader>g γ
"imap <leader>delta δ
"imap <leader>d δ
"imap <leader>epsilon ε
"imap <leader>e ε
"imap <leader>zeta ζ
"imap <leader>z ζ
"imap <leader>eta η
"imap <leader>h η
"imap <leader>theta θ
"imap <leader>iota ι
"imap <leader>i ι
"imap <leader>kappa κ
"imap <leader>k κ
"imap <leader>lambda λ
"imap <leader>l λ
"imap <C-\> λ
"imap <leader>mu μ
"imap <leader>m μ
"imap <leader>nu ν
"imap <leader>n ν
"imap <leader>xi ξ
"imap <leader>omicron ο
""imap <leader>o ο " Shadows ∘
"imap <leader>pi π
"imap <leader>p π
"imap <leader>rho ρ
"imap <leader>r ρ
"imap <leader>sigma σ
"imap <leader>s σ
"imap <leader>varsigma ς
"imap <leader>vars ς
"imap <leader>tau τ
"imap <leader>t τ
""imap <leader>upsilon υ " Delays <leader>up
"imap <leader>u υ
"imap <leader>phi φ
"imap <leader>f φ
"imap <leader>chi χ
"imap <leader>x χ
"imap <leader>psi ψ
"imap <leader>c ψ
"imap <leader>omega ω
"imap <leader>v ω

"" Greek (upper)
"imap <leader>Alpha Α
"imap <leader>Beta Β
"imap <leader>Gamma Γ
"imap <leader>G Γ
"imap <leader>Delta Δ
"imap <leader>D Δ
"imap <leader>Epsilon Ε
"imap <leader>Zeta Ζ
"imap <leader>Eta Η
"imap <leader>Theta Θ
"imap <leader>Iota Ι
"imap <leader>Kappa Κ
"imap <leader>Lambda Λ
"imap <leader>L Λ
"imap <leader>Mu Μ
"imap <leader>Nu Ν
"imap <leader>Xi Ξ
"imap <leader>Omicron Ο
"imap <leader>Pi Π
"imap <leader>P Π
"imap <leader>Rho Ρ
"imap <leader>Sigma Σ
"imap <leader>S Σ
"imap <leader>Tau Τ
"imap <leader>Upsilon Υ
"imap <leader>Phi Φ
"imap <leader>F Φ
"imap <leader>Chi Χ
"imap <leader>Psi Ψ
""imap <leader>C Ψ " Shadows ℂ
"imap <leader>Omega Ω
"imap <leader>V Ω
"augroup vimrc
  "au BufReadPre * setlocal foldmethod=indent
  "au BufWinEnter * if &fdm == 'indent' | setlocal foldmethod=manual | endif
"augroup END

function! SearchForTODO()
    let current_ft = "*" . expand ("%:e")
    "echom current_ft
    execute "silent grep \"TODO\" " . l:current_ft
    execute "redraw! "
    cw
    call feedkeys("\<C-W>L")
    call feedkeys("20\<C-W><")
endfunction

command! -nargs=0 TODOS call SearchForTODO()

"MYYYYYYYYYY=======================================================================================================
if filereadable("Makefile")
    set makeprg=make\ -s
else
    autocmd FileType java       set makeprg=javac\ %
    autocmd FileType haskell    set makeprg=ghc\ -o\ %<\ -O2\ %
    autocmd FileType python     set makeprg=echo\ Нажмите\ ENTER\ или\ введите\ команду\ для\ продолжения
    autocmd FileType c          set makeprg=clang\ -o\ %<\ %
    autocmd FileType cpp        set makeprg=clang++\ -O2\ -std=c++11\ -I/home/igorjan/206round/staff\ -lpthread\ -o\ %<\ %
endif

                            nmap <F8> <ESC>:w<CR><ESC>:!./%<CR>
                            imap <F8> <ESC>:w<CR><ESC>:!./%<CR>
autocmd FileType c          nmap <F8> <ESC>:w<CR><ESC>:!./%<<CR>
autocmd FileType c          imap <F8> <ESC>:w<CR><ESC>:!./%<<CR>
autocmd FileType cpp        nmap <F8> <ESC>:w<CR><ESC>:!./%<<CR>
autocmd FileType cpp        imap <F8> <ESC>:w<CR><ESC>:!./%<<CR>
autocmd FileType java       nmap <F8> <ESC>:w<CR><ESC>:!java %<<CR>
autocmd FileType java       imap <F8> <ESC>:w<CR><ESC>:!java %<<CR>
autocmd FileType haskell    nmap <F8> <ESC>:w<CR><ESC>:!./%<<CR>
autocmd FileType haskell    imap <F8> <ESC>:w<CR><ESC>:!./%<<CR>
autocmd FileType python     nmap <F8> <ESC>:w<CR><ESC>:!python3 %<CR>
autocmd FileType python     imap <F8> <ESC>:w<CR><ESC>:!python3 %<CR>

autocmd FileType cpp        imap <S-F8> <ESC>:w<CR><ESC>:!importer.py % /home/igorjan/206round/staff/library.h<CR>:e<CR>
autocmd FileType cpp        nmap <S-F8> <ESC>:w<CR><ESC>:!importer.py % /home/igorjan/206round/staff/library.h<CR>:e<CR>

imap <C-F9> <ESC>:w<CR><ESC>:make<CR>
nmap <C-F9> <ESC>:w<CR><ESC>:make<CR>

imap <F9> <ESC>:w<CR><ESC>:silent make<CR>:call feedkeys("\<F8>")<CR>
nmap <F9> <ESC>:w<CR><ESC>:silent make<CR>:call feedkeys("\<F8>")<CR>

"nmap <F7> <ESC>:w<CR><ESC>:!/usr/local/pgsql/bin/psql -U igorjan -d ctd -a -f %<CR>
"imap <F7> <ESC>:w<CR><ESC>:!/usr/local/pgsql/bin/psql -U igorjan -d ctd -a -f %<CR>
"autocmd FileType cpp        imap <F7> <ESC>:w<CR>:!clang++ -std=c++11 -E %<CR>
"autocmd FileType cpp        nmap <F7> <ESC>:w<CR>:!clang++ -std=c++11 -E %<CR>
nmap <F7> <ESC>:w<CR><ESC>:!./compile-g++11.sh<CR>
imap <F7> <ESC>:w<CR><ESC>:!./compile-g++11.sh<CR>

autocmd FileType cpp    imap <C-f> <Esc>:w<CR><Esc>:%!astyle --mode=c --style=allman --indent=spaces=4 --indent-namespaces --align-pointer=middle --align-reference=type --suffix=none<CR><CR>
autocmd FileType java   imap <C-f> <Esc>:w<CR><Esc>:%!astyle --mode=c --style=allman --indent=spaces=4 --indent-namespaces --align-pointer=middle --align-reference=type --suffix=none<CR><CR>

autocmd FileType c      nmap <C-f> <Esc>:w<CR><Esc>:%!astyle --mode=c --style=allman --indent=spaces=4 --indent-namespaces --align-pointer=middle --align-reference=type --suffix=none<CR><CR>
autocmd FileType cpp    nmap <C-f> <Esc>:w<CR><Esc>:%!astyle --mode=c --style=allman --indent=spaces=4 --indent-namespaces --align-pointer=middle --align-reference=type --suffix=none<CR><CR>
autocmd FileType java   nmap <C-f> <Esc>:w<CR><Esc>:%!astyle --mode=c --style=allman --indent=spaces=4 --indent-namespaces --align-pointer=middle --align-reference=type --suffix=none<CR><CR>

" Ctrl-Space for completions. Heck Yeah!¬
inoremap <expr> <C-Space> pumvisible() \|\| &omnifunc == '' ?
          \ "\<lt>C-n>" :
          \ "\<lt>C-x>\<lt>C-o><c-r>=pumvisible() ?" .
          \ "\"\\<lt>c-n>\\<lt>c-p>\\<lt>c-n>\" :" .
          \ "\" \\<lt>bs>\\<lt>C-n>\"\<CR>"
imap <C-@> <C-Space>

let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_complete_in_comments = 1
let g:ycm_goto_buffer_command = 'new-tab'

let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

let g:EclimJavaSearchSingleResult = 'tabnew'

let g:undotree_SetFocusWhenToggle = 1

let g:CodeForcesXUser = '642717cac5d479d313a7754312431fae3b9b30924d9e5d5db91f52b19ff886ecf8f2564a558a2fa9'
let g:CodeForcesToken = '666836e8b6934e8032e283c7099490dc'
let g:CodeForcesJSessionId = 'D0CF9D84992E9BAF33F93FD354A592F4-n1'
let g:CodeForcesUserAgent = 'Mozilla/5.0 (X11; Linux x86_64; rv:37.0) Gecko/20100101 Firefox/37.0'
let g:CodeForces39ce7 = 'CFtAi3yO'
let g:CodeForcesUsername = 'Igorjan94'
let g:CodeForcesCount = 42
let g:CodeForcesContestId = 635
let g:CodeForcesShowUnofficial = '1'
let g:CodeForcesCommandLoadTask = 'vsplit'
let g:CodeForcesContestFormat = '/index'
let g:CodeForcesOutput = 'output'
let g:CodeForcesInput = 'input'
let g:CodeForcesTemplate = '/home/igorjan/206round/main.cpp'

noremap <leader>vv <ESC>:CodeForces
noremap <C-B>   <ESC>:w<CR><ESC>:CodeForcesUserSubmissions<CR>
noremap <C-S-B> <ESC>:w<CR><ESC>:CodeForcesSubmit<CR>

autocmd FileType c    nnoremap <C-E> <ESC>:YcmCompleter GoToDefinitionElseDeclaration<CR>
autocmd FileType cpp  nnoremap <C-E> <ESC>:YcmCompleter GoToDefinitionElseDeclaration<CR>
autocmd FileType java nnoremap <C-E> <ESC>:JavaSearch<CR>

set timeoutlen=2000

imap <leader>re readln();<ESC>hi
imap <leader>wr writeln();<ESC>hi
imap <leader>S System.out.println();<ESC>hi
imap <leader>esc <ESC>
imap <leader>str struct<CR>{<CR><TAB><CR>};<ESC>k$i
imap <leader>v vector<
imap <leader>wh whole(
imap <leader>el elohw(
imap <leader>mne min_element(
imap <leader>mxe max_element(
imap <leader>b begin(), 
imap <leader>en end(), 
imap <leader>so sort(whole(
imap <leader>we writeln_range(

map <C-C><C-C><C-C> <ESC>:r /home/igorjan/206round/main.cpp<CR>

set foldenable
set foldmethod=marker

map <leader>cfo <ESC>:call CodeForces#CodeForcesOpenContest()<CR>

map <leader>sz 25<C-W>>

set matchpairs+=<:>

map <C-Right> w
map <C-Left> b

imap  <ESC>,cii
vmap  ,ci
nmap  ,ci

setlocal spell spelllang=en,ru

let g:move_key_modifier = 'C'
map <A-down> <C-j>
map <A-up> <C-k>

function! Magic(problem, need)
python << EOF
import vim
import re
def getCode(problem, need):
    statement = re.sub(r'\".*?\"', '', re.sub(r'\'.*?\'', '', ''.join(open(problem + '.problem', 'r').readlines()).split('Входные данные', 1)[1].split('Выходные данные')[0]))
    if need != 'LOL':
        tempvariables = re.findall(r'([a-zA-Z][a-zA-Z]*(_[0-9]+)?)', statement)
        variables = []
        for (x, y) in tempvariables:
            variables.append(x)
    else:
        variables = re.findall(r'[a-zA-Z]+', statement)
    vars = []
    for v in variables:
        if v != 'i' and v != 'j':
            vars.append(v)

    restrictions = re.findall(r'(\d+\s*[≤<≥>]\s*[^0-9]{1,10}\s+[≤<≥>]\s+\w+(\^\d+)?)', statement)
    l = len(variables)
    for i in range(len(restrictions)):
        restrictions[i] = (restrictions[i][0], int('0' + restrictions[i][1][1:]))

    def getPrevIndex(variable):
        for j in range(l):
            if vars[j] == variable:
                if j > 0:
                    return j - 1
        return -1

    def getDeclaration(variable):
        j = getPrevIndex(variable)
        mx = 0
        for s in restrictions:
            if s[0].find(variable) != -1:
                mx = max(mx, s[1])
        curr = 'int' if mx <= 9 else 'll'
        add = ''

        if len(re.findall(r'вещественных чисел ' + variable, statement)) or len(re.findall(r'вещественное число ' + variable, statement)):
            curr = 'double'

        if len(re.findall(r'строка? ' + variable, statement)):
            curr = 'string'
        for i in range(l):
            if variables[i] == variable:
                if i + 1 < l and variables[i + 1] == 'i' and len(re.findall(variable + '_i', statement)):
                    curr = 'vector<' + curr + '>'
                    if i + 2 < l and variables[i + 2] == 'j' and len(re.findall(variable + '_i, j', statement)):
                        if j >= 1:
                            add = '(' + vars[j - 1] + ', ' + curr + '(' + vars[j] + '))'
                        curr = 'vector<' + curr + '>'
                    else:
                        if j != -1:
                            add = '(' + vars[j] + ')'
                    break
                if i + 1 < l and variables[i + 1] == 'j' and len(re.findall(variable + '_j', statement)):
                    curr = 'vector<' + curr + '>'
                    if j != -1:
                        add = '(' + vars[j] + ')'
                    break
        return curr + ' ' + variable + add

    code = ''
    used = set()
    ints = []

    for i in range(l):
        v = variables[i]
        if v == 'i' or v == 'j' or v == 'ASCII' or v in used:
            continue
        used.add(v)
        type = getDeclaration(v)
        if type[:3] == 'int':
            ints.append(v)
        else:
            if len(ints) > 0:
                code += '\tints(' + ', '.join(ints) + ');\n'
                ints = []
            code += '\t' + type + ';\n'
            code += '\treadln(' + v + ');\n'
    if len(ints) > 0:
        code += '\tints(' + ', '.join(ints) + ');\n'
    return code.replace('_', '')

(row, col) = vim.current.window.cursor
code = getCode(vim.eval('a:problem'), vim.eval('a:need')).split('\n')
vim.current.buffer[:] = vim.current.buffer[:row] + code + vim.current.buffer[row:]
vim.command(str(row + len(code)))
EOF
endfunction

command! -nargs=+ LOL     call Magic(<f-args>)
map <S-F7> :call Magic(expand('%<'), 'LOL')<CR>
