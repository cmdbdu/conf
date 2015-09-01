set nu
set autoindent
syntax on
set ruler
set showcmd
set ignorecase
set ai
set si
set expandtab
set smarttab
set shiftwidth=4
set tabstop=4
set history=400
set autoread
set laststatus=2
set cc=80
set enc=utf-8
set fencs=utf-8,ucs-bom,shift-jis,gb18030,gbk,gb2312,cp936
set autoindent
set showmatch 
set cursorline
set nobackup
set noswapfile
filetype on
filetype plugin on 
nmap <C-g><C-f> :call GotoFirstEffectiveLine()<cr>
map <C-F3> \be  


" PYTHON 相关的设置
"设置= + - * 前后自动空格
"设置,后面自动添加空格
au FileType python inoremap <buffer>= =<space>
au FileType python inoremap <buffer>+ +<space>
au FileType python inoremap <buffer>- -<space>
au FileType python inoremap <buffer>* *<space> 
au FileType python inoremap <buffer>, ,<space>

" 括号自动补全
func! AutoClose()
    :inoremap ( ()<ESC>i
    :inoremap " ""<ESC>i
    :inoremap ' ''<ESC>i
    :inoremap { {}<ESC>i
    :inoremap [ []<ESC>i
    :inoremap ) <c-r>=ClosePair(')')<CR>
    :inoremap } <c-r>=ClosePair('}')<CR>
    :inoremap ] <c-r>=ClosePair(']')<CR>
endf

au BufNewFile  *.{py,sh}  execute ":call SetTitle()"
au BufNewFile * normal G

fun! SetTitle()
    if &filetype == 'sh'
        call setline(1,"#!/bin/bash")
    elseif &filetype == 'python'
        call setline(1,"#coding:utf8")
        "call setline(2,"#By:dub")
    endif
endfun

fun! GotoFirstEffectiveLine()
"" 据说是跳过注释,到代码首行行首
    let l:c = 0
    while l:c<line("$") && (
                \ getline(l:c) =~ "^\s*$"
                \ || synIDattr(synID(l:c, 1, 0), "name") =~ ".*Comment.*"
                \ || synIDattr(synID(l:c, 1, 0), "name") =~ ".*PreProc$"
                \ )
        let l:c = l:c+1
    endwhile
    exe "normal ".l:c."Gz\<CR>"
endfun
