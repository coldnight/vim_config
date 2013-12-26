"=============================================================================
"  Author:          dantezhu - http://www.vimer.cn
"  Email:           zny2008@gmail.com
"  FileName:        vimwiki.vim
"  Description:     将任务按照时间标识出来
"  Version:         1.0
"  LastChange:      2010-11-11 20:39:29
"  History:         
"=============================================================================
syn     match       DETAIL          "DETAIL"
syn     match       START           "START"
syn     match       EXPIRE          "EXPIRE"
syn     match       STOP            "STOP"
syn     match       LEVEL           "LEVEL"
syn     match       ADDON           "ADDON"

hi      link        DETAIL          Statement
hi      link        START           Statement
hi      link        STOP            Statement
hi      link        EXPIRE          Statement
hi      link        LEVEL           Statement
hi      link        ADDON           Statement

hi VimwikiHeader1 guifg=#d75f5f             ctermfg=167
hi VimwikiHeader2 guifg=#d7afd7             ctermfg=182
hi VimwikiHeader3 guifg=#d7d787             ctermfg=186
hi VimwikiHeader4 guifg=#97afff             ctermfg=111
hi VimwikiHeader5 guifg=#74c8c8             ctermfg=116
hi VimwikiHeader6 guifg=#7f9f7f             ctermfg=108
hi VimwikiHeader7 guifg=#7f9f7f             ctermfg=108
