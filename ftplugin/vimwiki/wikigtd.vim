"=============================================================================
"  Author:          dantezhu - http://www.vimer.cn
"  Email:           zny2008@gmail.com
"  FileName:        wikigtd.vim
"  Description:     搭配vimwiki制作自己的gtd管理
"  Version:         1.2
"  LastChange:      2011-01-04 11:44:22
"  History:         backup目录的问题解决
"                   默认不使用index.wiki，而是用 task/task，并且可以配置
"=============================================================================
if exists('g:loaded_wikigtd')
    finish
endif
let g:loaded_wikigtd = 1
"可以自定义的首页地址
let g:wikigtd_index = 'TODO'

"定义好的变量名字
let s:STARTNAME = 'START'
let s:EXPIRENAME = 'EXPIRE'
let s:STOPNAME = 'STOP'
let s:LEVELNAME = 'LEVEL'

"匹配日期的正则
let s:reDate = '\d\{4}-\d\{1,2}-\d\{1,2}'

"所有,已完成,未完成的正则
let s:reDoAll = '[*#-] \[[ .oOX]\]'
let s:reDone = '[*#-] \[[X]\]'
let s:reDoing = '[*#-] \[[ .oO]\]'

highlight GroupToDo1 ctermbg=Cyan     ctermfg=Black  guibg=#8CCBEA    guifg=Black
highlight GroupToDo2 ctermbg=Yellow   ctermfg=Black  guibg=tan          guifg=Black
highlight GroupToDo3 ctermbg=Red      ctermfg=Black  guibg=#FF7272    guifg=Black

function! s:TaskSynMapInit()
    au BufEnter <buffer> call s:SynTaskAllDate()
    au InsertLeave <buffer> call s:SynTaskAllDate()
    au InsertEnter <buffer> call s:SynTaskAllDate()
    au BufWritePost <buffer> call s:SynTaskAllDate()
    au CursorHold <buffer> call s:SynTaskAllDate()
    au CursorHoldI <buffer> call s:SynTaskAllDate()

    nnoremap <buffer><silent> dd dd:TaskSyn<cr>
    nnoremap <buffer><silent> u u:TaskSyn<cr>
    nnoremap <buffer><silent> p p:TaskSyn<cr>
    nnoremap <buffer><silent> <C-R> <C-R>:TaskSyn<cr>
endfunction

function! s:TaskIndex()
    cclose
    exec ":setf vimwiki"
    exec ":VimwikiGoto " . g:wikigtd_index
endfunction

"在切换状态的同时，自动把一些字段换掉
function! s:ToggleWikiStat()
    exec ":VimwikiToggleListItem"

    let reStop = '\s*'.s:STOPNAME.'\s*=\s*'.s:reDate.'\s*'
    let stopDate = ' '.s:STOPNAME.'=' . strftime('%Y-%m-%d')
    for n in range(1,line('$'))
        let bDirty = 0
        let line = getline(n)
        if line =~ '^\s*'.s:reDoing.'.*'
            if match(line,reStop) >= 0
                let line = substitute(line,reStop,'','g')
                let bDirty = 1
            endif
        elseif line =~ '^\s*'.s:reDone.'.*'
            if match(line,reStop) < 0
                let line = substitute(line,'\s*$',stopDate,'g')
                let bDirty = 1
            endif
        endif
        if bDirty == 1
            call setline(n,line)
        endif
    endfor
    call s:SynTaskAllDate()
endfunction

"比较两个时间格式
function! s:CmpDate(firstDate,secondDate)
    let firstList = split(a:firstDate,'-')
    let secondList = split(a:secondDate,'-')

    if len(firstList) != len(secondList)
        return -1
    endif

    for index in range(0,len(firstList)-1)
        let res = str2nr(firstList[index]) - str2nr(secondList[index])
        if res > 0
            return 2
        elseif res < 0
            return 0
        endif
    endfor
    return 1
endfunction

"列出今天的任务
function s:SortByLevel(i1,i2)
    let v1 = a:i2["nr"] - a:i1["nr"]
    if v1 > 0
        return 1
    elseif v1 < 0
        return -1
    else
        return a:i1["lnum"] - a:i2["lnum"]
    endif
endfunction
function s:ListNeedDo(mtype)
    call s:TaskIndex()

    let todayDate = strftime("%Y-%m-%d")
    let normalList = []
    let warnList = []
    let errorList = []
    for n in range(1,line('$'))
        let line = getline(n)
        if line !~ '^\s*'.s:reDoing.'.*'
            continue
        endif

        let startDate = 0
        let expireDate = 0

        let mthStr = matchstr(line,s:STARTNAME.'\s*=\s*'.s:reDate)
        let startDate = matchstr(mthStr,s:reDate)

        let mthStr = matchstr(line,s:EXPIRENAME.'\s*=\s*'.s:reDate)
        let expireDate = matchstr(mthStr,s:reDate)


        let mthLevelStr = matchstr(line,s:LEVELNAME.'\s*=\s*\d*')
        let levelNum = str2nr(matchstr(mthLevelStr,'\d\+'))
        let tmpdict = {"bufnr": bufnr('%'),"lnum": n,"text": substitute(line,'^\s*'.s:reDoing.'\s*','','g'),"nr": levelNum}
        if s:CmpDate(todayDate,expireDate) == 0 && s:CmpDate(todayDate,startDate) >= 1 
            let tmpdict["type"] = "i"
            call add(normalList,tmpdict)
        elseif s:CmpDate(todayDate,expireDate) == 1
            let tmpdict["type"] = "w"
            call add(warnList,tmpdict)
        elseif s:CmpDate(todayDate,expireDate) == 2
            let tmpdict["type"] = "e"
            call add(errorList,tmpdict)
        else
            if a:mtype == 1
                let tmpdict["type"] = "i"
                call add(normalList,tmpdict)
            endif
        endif
    endfor
    let todayList = []
    let normalList = sort(normalList,"s:SortByLevel")
    let warnList = sort(warnList,"s:SortByLevel")
    let errorList = sort(errorList,"s:SortByLevel")

    call extend(todayList,errorList)
    call extend(todayList,warnList)
    call extend(todayList,normalList)
    call setqflist(todayList)
    copen
endfunction
function s:ListDoneOrDoingByDate(...)
    let pdate = (a:0 ? a:1 : strftime("%Y-%m-%d"))
    call s:TaskIndex()

    let doneList = []
    let doingList = []
    for n in range(1,line('$'))
        let line = getline(n)
        if line !~ '^\s*'.s:reDoAll.'.*'
            continue
        endif

        let startDate = 0
        let expireDate = 0

        let mthStr = matchstr(line,s:STARTNAME.'\s*=\s*'.s:reDate)
        let startDate = matchstr(mthStr,s:reDate)

        let mthStr = matchstr(line,s:EXPIRENAME.'\s*=\s*'.s:reDate)
        let expireDate = matchstr(mthStr,s:reDate)

        let mthStr = matchstr(line,s:STOPNAME.'\s*=\s*'.s:reDate)
        let stopDate = matchstr(mthStr,s:reDate)


        let mthLevelStr = matchstr(line,s:LEVELNAME.'\s*=\s*\d*')
        let levelNum = str2nr(matchstr(mthLevelStr,'\d\+'))
        let tmpdict = {"bufnr": bufnr('%'),"lnum": n,"text": substitute(line,'^\s*'.s:reDoAll.'\s*','','g'),"nr": levelNum}
        
        "未完成
        if line =~ '^\s*'.s:reDoing.'.*'
            if s:CmpDate(pdate,startDate) >= 1
                let tmpdict["type"] = "w"
                call add(doingList,tmpdict)
            endif
        "已完成
        elseif line =~ '^\s*'.s:reDone.'.*'
            if s:CmpDate(pdate,startDate) >= 1 && s:CmpDate(pdate,stopDate) <= 1
                let tmpdict["type"] = "e"
                call add(doneList,tmpdict)
            endif
        endif
    endfor
    let showList = []

    call extend(showList,doneList)
    call extend(showList,doingList)
    call setqflist(showList)
    copen
endfunction

"把主文件备份到 g:vimwiki_list[0]['path']
function s:TaskBackup()
    let prefix_name = matchstr(g:wikigtd_index, '.*/')
    let basePath = g:vimwiki_list[0]['path'] . prefix_name
    let backupDir = basePath . 'backup/'
    if !isdirectory(backupDir)
        call mkdir(backupDir, "p", 0700)
    endif

    let srcFilePath = g:vimwiki_list[0]['path'] . g:wikigtd_index . '.wiki'
    let destFilePath = backupDir . "backup_" .strftime("%Y%m%d_%H%M%S")

    let cmd = '!cat '.srcFilePath.' > '.destFilePath

    silent! exec cmd

    if filereadable(destFilePath)
        echohl WarningMsg | echo "backup suc![".destFilePath."]" | echohl None
    else
        echohl WarningMsg | echo "backup fail![".destFilePath."]" | echohl None
    endif
endfunction

"重新对当前任务着色
function! s:SynTaskAllDate()
    let matches = getmatches()
    for matchId in matches
        if matchId['group'] == 'GroupToDo1' || 
                    \ matchId['group'] == 'GroupToDo2' ||
                    \ matchId['group'] == 'GroupToDo3'
            call matchdelete(matchId['id'])
        endif
    endfor

    let todayDate = strftime("%Y-%m-%d")

    for n in range(1,line('$'))
        let line = getline(n)
        if line !~ '^\s*'.s:reDoing.'.*'
            continue
        endif

        let startDate = 0
        let expireDate = 0

        let mthStr = matchstr(line,s:STARTNAME.'\s*=\s*'.s:reDate)
        let startDate = matchstr(mthStr,s:reDate)

        let mthStr = matchstr(line,s:EXPIRENAME.'\s*=\s*'.s:reDate)
        let expireDate = matchstr(mthStr,s:reDate)


        if s:CmpDate(todayDate,expireDate) == 1
            "黄色
            let mID = matchadd('GroupToDo2','\%'.n.'l'.s:reDoing)
        elseif s:CmpDate(todayDate,expireDate) == 2
            "红色
            let mID = matchadd('GroupToDo3','\%'.n.'l'.s:reDoing)
        else
            if s:CmpDate(todayDate,startDate) >= 1
                "绿色
                let mID = matchadd('GroupToDo1','\%'.n.'l'.s:reDoing)
            endif
        endif
    endfor
endfunction

"列出TaskDoneOrDoingByDate的参数列表
function! CompleteDateList(ArgLead, CmdLine, CursorPos)
    return [strftime("%Y-%m-%d")]
endfunction

au FileType vimwiki call s:TaskSynMapInit()

command! -nargs=0 TaskToday :call s:ListNeedDo(0)
command! -nargs=0 TaskAll :call s:ListNeedDo(1)
command! -nargs=0 TaskToggle :call s:ToggleWikiStat()
command! -nargs=0 TaskSyn :call s:SynTaskAllDate()
command! -complete=customlist,CompleteDateList -nargs=? TaskDoneOrDoingByDate call s:ListDoneOrDoingByDate(<f-args>)
command! -nargs=0 TaskBackup :call s:TaskBackup()
