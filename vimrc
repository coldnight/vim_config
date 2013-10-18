set nocompatible
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim
"source $VIMRUNTIME/mswin.vim   " 启动Ctrl-v/c 复制粘贴
behave mswin

"""""""""""""""""""""""""""""""""""""""""""""""
" => Vim插件管理
"""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible
filetype off
set rtp+=~/.vim/bundle/vundle
call vundle#rc()
Bundle 'gmarik/vundle'
"Bundle "MarcWeber/vim-addon-mw-utils"
"Bundle "tomtom/tlib_vim"
"Bundle "honza/snipmate-snippets"
"Bundle "garbas/vim-snipmate"
"Bundle "Shougo/neocomplcache"
Bundle "Lokaltog/vim-powerline"
Bundle "drakeguan/vim-vcscommand"
Bundle "scrooloose/nerdtree"
Bundle "pix/vim-taglist"
Bundle "nathanaelkane/vim-indent-guides"
Bundle "clones/vim-cecutil"
Bundle "tpope/vim-fugitive"
"Bundle "c9s/bufexplorer"
Bundle "jnwhiteh/vim-golang"
Bundle "kevinw/pyflakes-vim"
Bundle "mbriggs/mark.vim"
"Bundle "vim-scripts/TabBar"
Bundle "vim-scripts/DrawIt"
Bundle "vim-scripts/calendar.vim--Matsumoto"
Bundle "vim-scripts/Python-mode-klen"
"Bundle "vim-scripts/pydoc.vim"
Bundle "vim-scripts/VOoM"
Bundle "vim-scripts/qiushibaike"
Bundle "vim-scripts/AuthorInfo"
Bundle "vim-scripts/javacomplete"
Bundle "vim-scripts/javaDoc.vim"
Bundle "drmingdrmer/xptemplate.git"
Bundle "vim-scripts/Java-Syntax-and-Folding"
Bundle "plasticboy/vim-markdown"
Bundle "majutsushi/tagbar"
Bundle "kakkyz81/evervim"
Bundle "Valloric/YouCompleteMe"
Bundle "davidhalter/jedi"
Bundle "davidhalter/jedi-vim"
Bundle "scrooloose/syntastic"
"Bundle "vim-scripts/Conque-Shell"
Bundle "peterhoeg/vim-qml"
Bundle "https://github.com/tpope/vim-fugitive.git"
Bundle "gregsexton/gitv"
Bundle "Yggdroot/indentLine"
Bundle "airblade/vim-gitgutter"
Bundle "jmcantrell/vim-virtualenv"
"Bundle "bling/vim-airline"
Bundle "terryma/vim-multiple-cursors"
Bundle "sophacles/vim-bundle-mako"
Bundle "tpope/vim-commentary"

filetype indent plugin on

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
syntax on                      " 设置语法高亮
set magic                      " 设置自动转意类似python的r''功能
set nu                         " 显示行号
set ai                         " 设置自动缩进
set ruler                      " 打开状态栏标尺
set nobackup                   " 覆盖文件时不备份
set history=1000               " 设置命令历史
set autoread                   " 当文件被改动时自动加载
autocmd! bufwritepost vimrc source ~/.vimrc  " 当vimrc改动时，自动加载
set imcmdline                  " 解决右键菜单乱码
"set diffexpr=MyDiff()
set backspace=indent,eol,start " 更改退格键动作(indent=缩进,eol=endofline, start=行开始)
set listchars=tab:>-,trail:-,extends:#,nbsp:- " 显示空白和制表符
set selection=inclusive        " 将光标所在位置也作为被选择范围
set wildmenu                   " 在终端下使用一个漂亮的菜单显示补全
set wildmode=list:longest,full " 设置普全菜单模式
set whichwrap=b,s,h,l,<,>,[,]  " 遇到这些指令到行尾折行继续
set scrolljump=5               " 光标距离顶/底部多少行时滚动
set scrolloff=3                " 设置光标具上/下多少行是屏幕滚动
set gdefault                   " 改变s命令状态,设置为全部替换
set list
set ignorecase                 " 搜索时呼略大小写
set hlsearch                   " 高亮搜索项
set incsearch                  " 当输入时就搜索
set showmatch                  " show matching brackets/parenthesis
set foldenable
set autoindent                 " 设置自动缩进
set smarttab                   " 设置灵巧的tab,tab被替换成空格时,删除将删除整个被替换成tab的空格
set smartindent                " 设置灵巧的缩进
set tags=~/.tags/tags          " 设置ctags目录
set cmdheight=2                " 设置命令行的高度
set hid                        " 改变缓冲区（不保存）
set noerrorbells               " 不显示错误声音
set novisualbell               " 设置没有可视铃声
set t_vb=                      " 禁用可视铃声
set fileencoding=utf8          " 使用utf8打开文件
set encoding=utf8              " 设置显示编码
language messages zh_CN.utf-8  " 设置console信息编码
set tm=500
set expandtab                  " 使用spcae代替tab
set tabstop=4                  " tab宽度
set shiftwidth=4               " tab自动缩进宽度
set cursorline                 " 设置高亮当前行
set nocp                       " 不设置 'compatible'
set guifont=Monaco\ 10         " 设置gui英文字体
set guifontwide=WenQuanYi\ Zen\ Hei\ 10 " 设置gui等宽字体
let mapleader=','              " 设置主键为,
let g:ctags_statusline=1
"set guifont=Bitstream_Vera_Sans_Mono:h10:cANSI
"set co=130                    " 通过设置列行数来控制窗口的大小
"set lines=100
"set fdm=indent                " 设置代码折叠
"set fdc=4                     " 设置代码折叠宽度为4个字符
set wrap                       " 设置自动折行
"colorscheme distinguished      " 设置配色方案
colorscheme jellybeans


if has('cmdline_info')
    set ruler                  " show the ruler
    set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " a ruler on steroids
    set showcmd                " show partial commands in status line and
                               " selected characters/lines in visual mode
endif



""""""""""""""""""""""""""""""""""""""""""""""""
" => key map
""""""""""""""""""""""""""""""""""""""""""""""""
" 定义命令别名
cmap W w
cmap w' w
cmap WQ wq
cmap wq1 wq!
cmap qa1 qa!
cmap q1 q!
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR> " C-\ - Open the definition in a new tab
nmap <Leader>cs :nohl <CR>      " 清除高亮
nmap <Leader>b \<C-B>

"""""""""""""""""""""""""""""""""""""""""""""""
" => VCS key map
"""""""""""""""""""""""""""""""""""""""""""""""
nmap <leader>vs :VCSStatus<CR>
nmap <leader>vc :VCSCommit<CR>
nmap <leader>vb :VCSBlame<CR>
nmap <leader>va :VCSAdd<CR>
nmap <leader>vd :VCSVimDiff<CR>
nmap <leader>vl :VCSLog<CR>
nmap <leader>vu :VCSUpdate<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""
" => 配色方案
"""""""""""""""""""""""""""""""""""""""""""""""""
if (has("gui_running"))
    "图形界面下的设置
    "set guioptions+=b
    set background=dark
    colorscheme solarized
    "设置初始宽度
    set columns=95 lines=40
else
    "字符界面的下跌设置
    set t_Co=256
endif

"""""""""""""""""""""""""""""""
" => Pytho mode
"""""""""""""""""""""""""""""""
let g:pymode_lint_write = 0
let g:pymode_doc = 1
autocmd FileType python let g:pymode_doc_key = 'K'
autocmd FileType python let g:pymode_run = 1
let g:pymode_folding = 0
let g:pymode_lint = 1
let g:pymode_lint_checker="pyflakes,pep8,mccabe"
let g:pymode_lint_onfly=0
let g:pymode_lint_config=$HOME."/.pylintrc"
let g:pymode_lint_message=1
let g:pymode_lint_jump = 0
let g:pymode_lint_hold = 0
let g:pymode_lint_signs = 1
let g:pymode_lint_mccabe_complexity = 8
let g:pymode_lint_minheight = 3
let g:pymode_lint_maxheight = 1
let g:pymode_rope = 1
let g:pymode_rope_enable_autoimport = 1
let g:pymode_rope_autoimport_generate = 1
let g:pymode_rope_autoimport_underlineds = 0
let g:pymode_rope_codeassist_maxfixes = 10
let g:pymode_rope_sorted_completions = 1
let g:pymode_rope_extended_complete = 1
let g:pymode_rope_autoimport_modules = ["os","shutil","datetime"]
let g:pymode_rope_confirm_saving = 1
let g:pymode_rope_global_prefix = "<C-x>p"
let g:pymode_rope_local_prefix = "<C-c>r"
let g:pymode_rope_vim_completion = 1
let g:pymode_rope_guess_project = 1
let g:pymode_rope_goto_def_newwin = ""
let g:pymode_rope_always_show_complete_menu = 0
let g:pymode_motion = 1
let g:pymode_syntax = 1
let g:pymode_syntax_all = 1
let g:pymode_rope_vim_completion = 1



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" =>Python
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let python_highlight_all = 1
au FileType python syn keyword pythonDecorator True None False self

au BufNewFile,BufRead *.jinja set syntax=jinja
au BufNewFile,BufRead *.jinja set ft=jinja
au BufNewFile,BufRead *.mako set ft=mako
au BufNewFile,BufRead *.wsgi set ft=python

au FileType python inoremap <buffer> $r return
au FileType python inoremap <buffer> $i import
au FileType python inoremap <buffer> $p import pdb;pdb.set_trace()
au FileType python inoremap <buffer> $f #--- PH ----------------------------------------------<esc>FP2xi
au FileType python map <buffer> <leader>1 /class
au FileType python map <buffer> <leader>2 /def
au FileType python map <buffer> <leader>C ?class
au FileType python map <buffer> <leader>D ?def
au FileType python set cuc                        " 显示纵向对齐线
au FileType python set cc=78                      " 在78列显示对齐线
au FileType python hi ColorColumn ctermbg=darkgray
au FileType python set tw=78 " python文件文本最长宽度为78

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

let currPath = strpart(expand("%:p"), 0, 18)
if currPath == "/data/home/wh/jobs"
    let g:python_author = 'wh'
else
    let g:python_author = 'cold'
endif

let g:python_email  = 'wh_linux@126.com'

"Python 注释
function InsertPythonComment()
    exe 'normal'.1.'G'
    let line = getline('.')
    if line =~ '^#!.*$' || line =~ '^#.*coding:.*$'
        return
    endif
    normal O
    call setline('.', '#!/usr/bin/env python')
    normal o
    call setline('.', '# -*- coding:utf-8 -*-')
    normal o
    call setline('.', '#')
    normal o
    call setline('.', '#   Author  :   '.g:python_author)
    normal o
    call setline('.', '#   E-mail  :   '.g:python_email)
    normal o
    call setline('.', '#   Date    :   '.strftime("%y/%m/%d %H:%M:%S"))
    normal o
    call setline('.', '#   Desc    :   ')
    normal o
    call setline('.', '#')
    call cursor(7, 17)
endfunction
" F4 添加Python注释
au FileType python map <F4> :call InsertPythonComment()<cr>

function InsertCommentWhenOpen()
    if line('$') == 1 && getline(1) == ''
        call InsertPythonComment()
    end
endfunc
" 打开Python文件自动添加注释
au FileType python :call InsertCommentWhenOpen()
" Python自动跳到下/上一个函数/类
au FileType python map <C-j> :call search('^\s*def\ ', "w")<cr>
au FileType python map <C-k> :call search('^\s*def\ ', 'wb')<cr>
au FileType python map <Leader>j :call search('^\s*class\ ', "w")<cr>
au FileType python map <Leader>k :call search('^\s*class\ ', "wb")<cr>


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

"au BufRead,BufNewFile *.js set syntax=jquery
au FileType javascript set ft=jquery
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
" HTML
""""""""""""""""""""""""""""""
au FileType xhtml set tw=0
au FileType html set tw=0
au FileType jinja set tw=0
au FileType xml set tw=0


""""""""""""""""""""""""""""""
" => Calendar
"""""""""""""""""""""""""""""""
let g:calendar_diary=$HOME.'/.Diary'
map <c-d> :Calendar<cr>
map <F8> :Voom<cr>

"""""""""""""""""""""""
"Author
"""""""""""""""""""""""
let g:vimrc_author='wh'
let g:vimrc_email='wh_linux@126.com'
let g:vimrc_homepage='http://www.linuxzen.com/'
nmap <F4> :AuthorInfoDetect<cr>


"设置对齐线的宽度, <Leader> ig启动
let g:indent_guides_guide_size=1

""""""""""""""""""""""""""""""""""""""""
" => 目录树
""""""""""""""""""""""""""""""""""""""""
map <C-e> :NERDTreeToggle<CR>:NERDTreeMirror<CR>
map <silent> <F12> :NERDTreeToggle <CR>
let NERDTreeIgnore=['\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr']
let g:NERDTree_title="Tree"
" 当只声nerdtree一个窗口时关闭vim
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

""""""""""""""""""""""""""""""""""""""""
" => TagList
""""""""""""""""""""""""""""""""""""""""
map <F3> :silent! Tlist<CR>
let Tlist_Ctags_Cmd='ctags'
let Tlist_Auto_Update=1
let Tlist_Use_Right_Window=1
let Tlist_Show_One_file=0
let Tlist_Exit_OnlyWindow=1
let Tlist_Process_File_Always=1
let Tlist_Inc_Winwidth=0
let Tlist_Exit_OnlyWindow=1
autocmd FileType c,cpp,java,php,js,python,twig,xml,yml autocmd BufWritePre <buffer> :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))

"""""""""""""""""""""""""""""""""""""""""
" => TagBar
"""""""""""""""""""""""""""""""""""""""""
map <silent> <F3> :TagbarToggle<CR>
let g:tagbar_ctags_bin = 'ctags'


"""""""""""""""""""""""""""""""""""""""""
" complete
"""""""""""""""""""""""""""""""""""""""""
"let g:neocomplcache_enable_at_startup=0  " 自动加载neocomplcache
"let g:neocomplcache_enable_samrt_case=1  " 启动灵巧补全
"let g:neocomplcache_enable_cmel_case_completion=1
"let g:neocomplcache_enable_underbar_completion=1
"let g:neocomplcache_min_syntax_length=3  " 3个字符开始补全
"let g:neocomplacche_lock_buffer_name_pattern='\*ku\*'
"let g:neocomplcache_enable_auto_select=1
"let g:neocomplcache_enable_quick_match=1
"let g:neocomplcache_dictionary_filetype_lists={
"    \ 'default':'',
"    \ 'vimshell':$HOME.'/.vimshell_hist',
"    \ 'scheme':$HOME.'/.gosh_completions',
"    \ 'css': $HOME.'/.vim/dict/css.dic',
"    \ 'php': $HOME.'/.vim/dict/php.dic',
"    \ 'javascript':$HOME.'/.vim/dict/js.dic'
"    \ }
"
"let g:neocomplcache_snippets_dir=$HOME.'.vim/snippets'
"inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<TAB>"
"inoremap <expr><C-TAB> pumvisible() ? "\<C-p>" : "\<TAB>"
"
"if !exists('g:neocomplcache_keywrod_patterns')
"    let g:neocomplcache_keyword_patterns = {}
"endif
"let g:neocomplcache_keyword_patterns['default']='\h\w*'
"imap <C-k>     <Plug>(neocomplcache_snippets_expand)
"smap <C-k>     <Plug>(neocomplcache_snippets_expand)
"inoremap <expr><C-g>     neocomplcache#undo_completion()
"inoremap <expr><C-z>     neocomplcache#undo_completion()
"inoremap <expr><C-l>     neocomplcache#complete_common_string()
"inoremap <expr><CR> pumvisible() ? neocomplcache#close_popup() : "\<CR>"
"inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
""inoremap <expr><space>  pumvisible() ? neocomplcache#close_popup() . "\<SPACE>" : "\<SPACE>"
"inoremap <expr><C-h> neocomplcache#close_popup()."\<C-h>"
""inoremap <expr><BS> neocomplcache#close_popup()."\<C-h>"
"inoremap <expr><C-y>  neocomplcache#close_popup()
"inoremap <expr><C-e>  neocomplcache#cancel_popup()
"inoremap <expr><Enter> pumvisible() ? "\<C-Y>" : "\<Enter>"
"autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
"autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
"autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
"autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
"autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
"autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
""autocmd FileType java setlocal omnifunc=javacomplete#Complete
"if !exists('g:neocomplcache_omni_patterns')
"  let g:neocomplcache_omni_patterns = {}
"endif
"let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
"let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplcache_omni_patterns.c = '\%(\.\|->\)\h\w*'
"let g:neocomplcache_omni_patterns.cpp = '\h\w*\%(\.\|->\)\h\w*\|\h\w*::'
"function EnableOrDisableNeoCompleCache()
"    if neocomplcache#is_enabled()
"        execute 'NeoComplCacheDisable'
"    else
"        execute 'NeoComplCacheEnable'
"    endif
"endfunc
"
"map <Leader>neo :call EnableOrDisableNeoCompleCache()<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""
" => statusline
"""""""""""""""""""""""""""""""""""""""""""""""""
set laststatus=2
let g:Powerline_symbols='unicode'
set wrap                       " 设置自动折行


let g:evervim_devtoken = "S=s5:U=38ab24:E=147aa795492:C=14052c82893:P=1cd:A=en-devtoken:V=2:H=7999d235c25ed10478d475732793d315"

"""""""""""""""""""""""""""""""""""""""""""""""""
" => YouComplete
"""""""""""""""""""""""""""""""""""""""""""""""""
let g:ycm_confirm_extra_conf = 0  " 不提示确认加载 .ycm_extra_conf.py
nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""
" => syntastic
"""""""""""""""""""""""""""""""""""""""""""""""""
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'
let g:syntastic_ignore_files=[".*\.py$"]



"""""""""""""""""""""""""""""""""""""""""""""""""
" => jedi
"""""""""""""""""""""""""""""""""""""""""""""""""
let g:jedi#auto_vim_configuration = 0
let g:jedi#popup_select_first = 0


""" IndentLine
let g:indentLine_enabled = 1
map <leader>il :IndentLinesToggle<CR>


""" GitGutter
map <leader>gg :GitGutterToggle<CR>

""" 设置各个文件注释字符
autocmd FileType python,shell set commentstring=#\ %s                 " 设置Python注释字符
autocmd FileType mako set cms=##\ %s
