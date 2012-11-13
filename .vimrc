set nocompatible
source $VIMRUNTIME/vimrc_example.vim
"source $VIMRUNTIME/mswin.vim
behave mswin

set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction






"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" =>常规
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 设置语法高亮
syntax on
" 
set magic
" 显示行号
set nu
" 设置自动缩进
set ai
" 打开状态栏标尺
set ruler
" 覆盖文件时不备份
set nobackup
" 设置命令历史
set history=1000
" 当文件被改动时自动加载
set autoread
" 当vimrc改动时，自动加载
autocmd! bufwritepost vimrc source $VIM\_vimrc
" 允许使用插件
filetype plugin on
filetype indent on


" 去掉错误提示音
set noeb

" 使用utf8打开文件
set fileencoding=utf8

" 设置显示编码
set encoding=utf8

" 设置console信息编码
language messages zh_CN.utf-8

"解决右键菜单乱码
set imcmdline
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" =>快捷键设置
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"映射Crtl+e新建标签
map <c-e> :tabnew <cr>
" 映射Crtl+n切换到写一个标签
map <c-n> :tabnext<cr> 
 

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" =>用户接口
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 设置光标具上/下多少行是屏幕滚动
set so=2
set wildmenu "开启WiLd菜单
set cmdheight=2 "设置命令行的高度
set hid "改变缓冲区（不保存）
" 不显示错误声音
set noerrorbells
set novisualbell
set t_vb=
set tm=500
" 搜索时高亮显示被找到的文本
set hlsearch
"使用spcae代替tab
set expandtab
" tab宽度
set tabstop=4
" tab自动缩进宽度
set shiftwidth=4
" 设置代码折叠
"set fdm=indent
" 设置代码折叠宽度为4个字符
"set fdc=4

" 不设置 'compatible'
set nocp
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" =>颜色和字体
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 设置编码
set fenc=utf-8
" 设置英文字体
set guifont=Monaco\ 10

" 设置等宽字体
set guifontwide=WenQuanYi\ Zen\ Hei\ 10
"set guifont=Bitstream_Vera_Sans_Mono:h10:cANSI
" 设置配色方案
"colorscheme navajo 
"colorscheme darkblue
" 通过设置列行数来控制窗口的大小
"set co=130
"set lines=100
" 设置折行
if (has("gui_running"))
	"图形界面下的设置
	set wrap
	"set guioptions+=b
	set background=dark
    colorscheme solarized
    "设置初始宽度
    set columns=95 lines=40
else
	"字符界面的下跌设置
	set wrap
	set t_Co=256
	colorschem darkburn
endif
set cursorline

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" =>Python
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let python_highlight_all = 1
au FileType python syn keyword pythonDecorator True None False self

au BufNewFile,BufRead *.jinja set syntax=htmljinja
au BufNewFile,BufRead *.mako set ft=mako

au FileType python inoremap <buffer> $r return
au FileType python inoremap <buffer> $i import
au FileType python inoremap <buffer> $p print
au FileType python inoremap <buffer> $f #--- PH ----------------------------------------------<esc>FP2xi
au FileType python map <buffer> <leader>1 /class
au FileType python map <buffer> <leader>2 /def
au FileType python map <buffer> <leader>C ?class
au FileType python map <buffer> <leader>D ?def
"Python 一键执行
function CheckPythonSyntax()
    let mp = &makeprg
    let ef = &errorformat
    let exeFile = expand("%:t")
    setlocal makeprg=python\ -u
    set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m
    silent make %
    copen
    let &makeprg     = mp
    let &errorformat = ef
endfunction

map <F5> :w<cr>
map <F5> :call CheckPythonSyntax()<cr>


""""""""""""""""""""""""""""""
" => JavaScript section
"""""""""""""""""""""""""""""""
au FileType javascript call JavaScriptFold()
au FileType javascript setl fen
au FileType javascript setl nocindent

au FileType javascript imap <c-t> AJS.log();<esc>hi
au FileType javascript imap <c-a> alert();<esc>hi

au FileType javascript inoremap <buffer> $r return
au FileType javascript inoremap <buffer> $f //--- PH ----------------------------------------------<esc>FP2xi

au BufRead,BufNewFile *.js set syntax=jquery
let g:SimpleJsIndenter_BriefMode=1

function! JavaScriptFold()
    setl foldlevelstart=1
    syn region foldBraces start=/{/ end=/}/ transparent fold keepend extend

    function! FoldText()
    return substitute(getline(v:foldstart), '{.*', '{...}', '')
    endfunction
    setl foldtext=FoldText()
endfunction

"Toggle Menu and Toolbar
set guioptions-=m
set guioptions-=T
map <silent> <F2> :if &guioptions =~# 'T' <Bar>
        \set guioptions-=T <Bar>
        \set guioptions-=m <bar>
    \else <Bar>
        \set guioptions+=T <Bar>
        \set guioptions+=m <Bar>
    \endif<CR>

""""""""""""""""""""""""""""""
" => Calendar
"""""""""""""""""""""""""""""""
"let g:calendar_diary='E:\Diary'
"map <c-d> :Calendar<cr>

"map <F11> :Voom<cr>

""""""""""""""""""""""""""""""
" => 自定义
"""""""""""""""""""""""""""""""
"au BufNewFile,BufRead *.nt set filetype=nt

"""""""""""""""""""""""
"Author
"""""""""""""""""""""""
let g:vimrc_author='wh'
let g:vimrc_email='wh_linux@126.com'
let g:vimrc_homepage='http://www.linuxzen.com/'
nmap <F4> :AuthorInfoDetect<cr>


"设置对齐线的宽度
let g:indent_guides_guide_size=1

map <C-e> :NERDTreeToggle<CR>:NERDTreeMirror<CR>
let NERDTreeIgnore=['\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr']
map <F3> :silent! Tlist<CR>
let Tlist_Ctags_Cmd='ctags'
let Tlist_Use_Right_Window=1
let Tlist_Show_One_file=0
let Tlist_Exit_OnlyWindow=1
let Tlist_Process_File_Always=0
let Tlist_Inc_Winwidth=0
let Tlist_Exit_OnlyWindow=1
map <silent> <F12> :NERDTreeToggle <CR>

if has('statusline')
    set laststatus=2
    set statusline=%<%f
    set statusline+=%w%h%m%r
    set statusline+=%{fugitive#statusline()} "Git
    "set statusline+=\ [%{getcwd()}]          " current dir
    set statusline+=\ [%{&ff}/%Y]            " filetype
    set statusline+=\ [A=\%03.3b/H=\%02.2B] " ASCII / Hexadecimal value of char
    set statusline+=%=%-14.(%l,%c%V%)\ %p%%\ %L  " Right aligned file nav info
endif

set listchars=tab:>-,trail:-,extends:#,nbsp:-

set backspace=indent,eol,start
set wildmenu
set wildmode=list:longest,full
set whichwrap=b,s,h,l,<,>,[,]
set scrolljump=5
set scrolloff=3
set gdefault
set list
set ignorecase                  " case insensitive search
set hlsearch                    " highlight search terms
set incsearch                   " find as you type search
set showmatch                   " show matching brackets/parenthesis
set foldenable
set autoindent                  " indent at the same level of the previous line
autocmd FileType c,cpp,java,php,js,python,twig,xml,yml autocmd BufWritePre <buffer> :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))

set tags=~/.tags/tags

set nocompatible
filetype off
set rtp+=~/.vim/bundle/vundle
call vundle#rc()
Bundle 'gmarik/vundle'
Bundle "MarcWeber/vim-addon-mw-utils"
Bundle "tomtom/tlib_vim"
Bundle "honza/snipmate-snippets"
Bundle "garbas/vim-snipmate"
filetype indent plugin on
let g:snippets_dir='~/.vim/snippets'
