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
Bundle "scrooloose/nerdtree"
Bundle "pix/vim-taglist"
Bundle "nathanaelkane/vim-indent-guides"
Bundle "clones/vim-cecutil"
Bundle "fatih/vim-go"
" Bundle "nvie/vim-flake8"
" Bundle "kevinw/pyflakes-vim"
Bundle "mbriggs/mark.vim"
Bundle "vim-scripts/DrawIt"
Bundle "vim-scripts/calendar.vim--Matsumoto"
Bundle "klen/python-mode"
Bundle "vim-scripts/VOoM"
Bundle "CodeFalling/fcitx-vim-osx"
" Bundle "plasticboy/vim-markdown"
Bundle "majutsushi/tagbar"
Bundle "Valloric/YouCompleteMe"
" Bundle "scrooloose/syntastic"
Bundle "peterhoeg/vim-qml"
Bundle "tpope/vim-fugitive.git"
Bundle "Yggdroot/indentLine"
Bundle "airblade/vim-gitgutter"
Bundle "jmcantrell/vim-virtualenv"
Bundle "bling/vim-airline"
Bundle "terryma/vim-multiple-cursors"
Bundle "sophacles/vim-bundle-mako"
Bundle "tpope/vim-commentary"
Bundle "tpope/vim-surround"
Bundle "Raimondi/delimitMate"
Bundle "groenewege/vim-less"
Bundle "Shougo/vimproc.vim"
Bundle "Shougo/unite.vim"
Bundle "coldnight/vimwiki"
Bundle "mattn/webapi-vim"
Bundle "mattn/gist-vim"
Bundle "drmingdrmer/xptemplate"
Bundle "Shougo/neomru.vim"
Bundle "b4winckler/vim-objc"
Bundle "msanders/cocoa.vim"
Bundle "rust-lang/rust.vim"
Bundle 'rizzatti/dash.vim'
Bundle "jphustman/SQLUtilities"
Bundle "jphustman/Align.vim"
Bundle "coldnight/pretty_json.vim"
Bundle "kylef/apiblueprint.vim"
Bundle 'junkblocker/patchreview-vim'
Bundle 'codegram/vim-codereview'
Bundle "cespare/vim-toml"
Bundle "w0rp/ale"
Bundle "junegunn/goyo.vim"
Bundle "amix/vim-zenroom2"
Bundle "pangloss/vim-javascript"

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
set synmaxcol=250              " 搜索语法项目最大列数, 解决长行卡顿问题
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
" set ignorecase                 " 搜索时呼略大小写
set hlsearch                   " 高亮搜索项
set incsearch                  " 当输入时就搜索
set showmatch                  " show matching brackets/parenthesis
set foldenable
set autoindent                 " 设置自动缩进
set smarttab                   " 设置灵巧的tab,tab被替换成空格时,删除将删除整个被替换成tab的空格
set smartindent                " 设置灵巧的缩进
set tags=.tags                 " 设置ctags 文件
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
set noundofile                 " 不创建回退文件"
set guifont=Monaco\ YaHei\ 11         " 设置gui英文字体
set guifontwide=Monaco\ YaHei\ 11         " 设置gui英文字体
" set guifontwide=WenQuanYi\ Zen\ Hei\ 10 " 设置gui等宽字体
let mapleader=','              " 设置主键为,
let maplocalleader="<space>"
let g:ctags_statusline=1
"set guifont=Bitstream_Vera_Sans_Mono:h10:cANSI
"set co=130                    " 通过设置列行数来控制窗口的大小
"set lines=100
"set fdm=indent                " 设置代码折叠
"set fdc=4                     " 设置代码折叠宽度为4个字符
" set wrap                       " 设置自动折行
" set completeopt=longest,menu   " 不显示Preview
" colorscheme distinguished      " 设置配色方案

" colorscheme jellybeans
colorscheme valloric


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
cmap WQ wq
cmap wq1 wq!
cmap qa1 qa!
cmap q1 q!
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR> " C-\ - Open the definition in a new tab
nmap <Leader>cs :nohl <CR>      " 清除高亮
nmap <Leader>b \<C-B>
nmap <Leader>pla :PymodeLintAuto <CR>
nmap <Leader>plt :PymodeLintToggle <CR>

map <C-k> :tabnext<CR>
map <C-j> :tabprev<CR>
map <C-h> :bprev<CR>
map <C-l> :bnext<CR>
imap <C-3> <Esc>



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
    " set background=dark
    " colorscheme solarized
    "设置初始宽度
    " set columns=95 lines=40
    " 禁用左右两侧滚动条
    set guioptions-=L
    set guioptions-=r
else
    "字符界面的下跌设置
    set t_Co=256
endif

"""""""""""""""""""""""""""""""
" => Pytho mode
"""""""""""""""""""""""""""""""
let g:pymode_doc = 0
autocmd FileType python let g:pymode_doc_key = '<C-c>K'
autocmd FileType python let g:pymode_run = 1
au! FileType python setl nosmartindent
let g:pymode_folding = 0
let g:pymode_lint = 0
let g:pymode_lint_write = 0
let g:pymode_lint_checker=[]
let g:pymode_lint_on_fly=0
let g:pymode_lint_config=$HOME."/.pylintrc"
let g:pymode_lint_message=1
let g:pymode_lint_jump = 0
let g:pymode_lint_hold = 0
let g:pymode_lint_cwindow = 0
let g:pymode_lint_signs = 1
let g:pymode_lint_mccabe_complexity = 8
let g:pymode_lint_minheight = 3
let g:pymode_lint_maxheight = 1
let g:pymode_lint_ignore = "E127,W,W0401"
let g:pymode_rope = 1
let g:pymode_rope_enable_autoimport = 1
let g:pymode_rope_autoimport_generate = 1
let g:pymode_rope_autoimport_underlineds = 1
let g:pymode_rope_codeassist_maxfixes = 10
let g:pymode_rope_sorted_completions = 1
let g:pymode_rope_extended_complete = 1
let g:pymode_rope_autoimport_modules = ["os","shutil","datetime"]
let g:pymode_rope_confirm_saving = 1
let g:pymode_rope_global_prefix = "<C-x>p"
let g:pymode_rope_local_prefix = "<C-c>r"
let g:pymode_rope_vim_completion = 0
let g:pymode_rope_completion = 0
let g:pymode_rope_guess_project = 0
let g:pymode_rope_goto_def_newwin = ""
let g:pymode_rope_always_show_complete_menu = 0
let g:pymode_rope_regenerate_on_write = 0
let g:pymode_motion = 1
let g:pymode_syntax = 1
let g:pymode_syntax_all = 1
let g:pymode_syntax_print_as_function = 1
let g:pymode_breakpoint_cmd = "import pudb;pudb.set_trace()"



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
au FileType python inoremap <buffer> $p import pudb;pudb.set_trace()
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

let currPath = strpart(expand("%:p"), 0, 14)
if currPath == "/Users/wh/jobs"
    let g:python_author = 'wh'
    let g:python_import = 'from __future__ import unicode_literals, print_function, division'
else
    let g:python_author = 'cold'
    let g:python_import = 'from __future__ import print_function, division, unicode_literals'
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
    " call setline('.', '#')
    " normal o
    " call setline('.', '#   Author  :   '.g:python_author)
    " normal o
    " call setline('.', '#   E-mail  :   '.g:python_email)
    " normal o
    " call setline('.', '#   Date    :   '.strftime("%y/%m/%d %H:%M:%S"))
    " normal o
    " call setline('.', '#   Desc    :   ')
    " normal o
    call setline('.', '""" """')
    normal o
    call setline('.', g:python_import)
    call cursor(3, 4)
endfunction
" F4 添加Python注释
" au FileType python map <F4> :call InsertPythonComment()<cr>

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

" Python 文件保存时执行 Flake8 检查代码
" autocmd BufWritePost *.py call Flake8()


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
au FileType xhtml,html,jinja,xml,htmldjango,javascript,jquery set tw=0
" au FileType xhtml,html,jinja,xml,htmldjango set sw=2


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
let Tlist_Ctags_Cmd='/usr/local/bin/ctags'
let Tlist_Auto_Update=1
let Tlist_Use_Right_Window=1
let Tlist_Show_One_file=0
let Tlist_Process_File_Always=1
let Tlist_Inc_Winwidth=0
let Tlist_Exit_OnlyWindow=1
autocmd FileType c,cpp,java,php,js,python,twig,xml,yml autocmd BufWritePre <buffer> :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))

"""""""""""""""""""""""""""""""""""""""""
" => TagBar
"""""""""""""""""""""""""""""""""""""""""
map <silent> <F3> :TagbarToggle<CR>
let g:tagbar_ctags_bin = '/usr/local/bin/ctags'


"""""""""""""""""""""""""""""""""""""""""""""""""
" => statusline
"""""""""""""""""""""""""""""""""""""""""""""""""
set laststatus=2
let g:Powerline_symbols='fancy'
set nowrap                       " 设置自动折行

" let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1


"""""""""""""""""""""""""""""""""""""""""""""""""
" => YouComplete
"""""""""""""""""""""""""""""""""""""""""""""""""
let g:ycm_confirm_extra_conf = 0  " 不提示确认加载 .ycm_extra_conf.py
nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR>

let g:ycm_filetype_black_list = {
            \ 'vimwiki': 1,
            \ }

let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_key_invoke_completion = '<C-Space>'
" let g:ycm_semantic_triggers.c = ['->', '.', ' ', '(', '[', '&']
let g:EclimCompletionMethod = 'omnifunc'

let g:ycm_rust_src_path = '/Users/wh/.cargo/rustc-1.15.1-src/src'

""" IndentLine
let g:indentLine_enabled = 1
map <leader>il :IndentLinesToggle<CR>


""" GitGutter
map <leader>gg :GitGutterToggle<CR>

""" 设置各个文件注释字符
autocmd FileType python,shell set commentstring=#\ %s                 " 设置Python注释字符
autocmd FileType mako set cms=##\ %s
autocmd FileType jquery set cms=//\ %s


""" Unite
noremap <leader>f :<C-u>Unite file<CR>
noremap <leader>fs :<C-u>Unite -start-insert file<CR>
noremap <leader>fb :<C-u>Unite file buffer<CR>
noremap <leader>fbs :<C-u>Unite -start-insert file buffer<CR>
noremap <leader>fm :<C-u> Unite file_mru<CR>
noremap <leader>fms :<C-u> Unite -start-insert file_mru<CR>
nnoremap <silent> <leader>b :<C-u>Unite buffer file_mru bookmark<CR>
nnoremap <silent> <leader>bs :<C-u>Unite -start-insert buffer file_mru bookmark<CR>

let g:unite_prompt = '>>> '
let g:unite_ignore_source_files = ["*.pyc"]
let g:unite_source_history_yank_enable = 1
nnoremap <leader>y :<C-u>Unite history/yank<CR>
nnoremap <leader>ys :<C-u>Unite -start-insert history/yank<CR>

let g:unite_source_menu_menus= {"git":{
    \ 'description' : '            gestionar repositorios git
        \                            ⌘ [espacio]g',
    \}}
let g:unite_source_menu_menus.git= {"command_candidates": [
    \['▷ tig                                                        ⌘ ,gt',
        \'normal ,gt'],
    \['▷ git status       (Fugitive)                                ⌘ ,gs',
        \'Gstatus'],
    \['▷ git diff         (Fugitive)                                ⌘ ,gd',
        \'Gdiff'],
    \['▷ git commit       (Fugitive)                                ⌘ ,gc',
        \'Gcommit'],
    \['▷ git log          (Fugitive)                                ⌘ ,gl',
        \'exe "silent Glog | Unite quickfix"'],
    \['▷ git blame        (Fugitive)                                ⌘ ,gb',
        \'Gblame'],
    \['▷ git stage        (Fugitive)                                ⌘ ,gw',
        \'Gwrite'],
    \['▷ git checkout     (Fugitive)                                ⌘ ,go',
        \'Gread'],
    \['▷ git rm           (Fugitive)                                ⌘ ,gr',
        \'Gremove'],
    \['▷ git mv           (Fugitive)                                ⌘ ,gm',
        \'exe "Gmove " input("destino: ")'],
    \['▷ git push         (Fugitive, salida por buffer)             ⌘ ,gp',
        \'Git! push'],
    \['▷ git pull         (Fugitive, salida por buffer)             ⌘ ,gP',
        \'Git! pull'],
    \['▷ git prompt       (Fugitive, salida por buffer)             ⌘ ,gi',
        \'exe "Git! " input("comando git: ")'],
    \['▷ git cd           (Fugitive)',
        \'Gcd'],
    \]}
nnoremap <silent><leader>g :Unite -silent -start-insert menu:git<CR>

call unite#custom#source("file,file_rec,file_mru,file_rec/async,grep,locate", "ignore_pattern", join(["*\.pyc", "\.git"], "|"))

"" Vimwiki
let g:vimwiki_camel_case = 0
let g:vimwiki_CJK_length = 1
let g:vimwiki_valid_html_tags = 'div, span, table, td, pre, tr'
let g:vimwiki_list = [{'path': '~/vimwiki',
\    'path_html': '~/vimwiki_html',
\    'template_path': '~/vimwiki/template',
\    'template_default': "default",
\    'template_ext': '.tpl',
\    'nested_syntaxes': {'python': 'python', 'rust': 'rust',
\                        'c': 'c', 'bash': 'shell', 
\                        'shell': 'shell', 'vim': 'vim',
\                        'vimscript': 'vim'},
\    'use_pygments': 1,
\ }]


"" SQLUtilies
let g:sqlutil_wrap_long_lines = 1
let g:sqlutil_wrap_function_calls = 1
let g:sqlutil_align_keyword_right = 1
let g:sqlutil_align_first_word = 0

"" JavaScript
let g:javascript_plugin_jsdoc = 1

"" ALE
let g:ale_javascript_eslint_use_global = 1
let g:ale_python_pylint_options = "--init-hook='import sys; sys.path.append(\".\")'"
let g:ale_linters = {
            \    'python': ['flake8', 'mypy'],
            \}
