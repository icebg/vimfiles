vim9script
if exists('g:loaded_MyPlugin') || !has('win32') || !has('gui_running') || v:version < 900
    finish
endif
g:loaded_MyPlugin = 1
g:my_utils_user_input_str = ''
g:myUtilsFilename = expand('<sfile>:p')


# 创建@Lsp菜单栏{{{
noremenu @Lsp.一键规范格式<tab>(:LspDocumentFormat)      :LspDocumentFormat<CR>
noremenu @Lsp.修复建议<tab>(:LspCodeAction)              :LspCodeAction<CR>
noremenu @Lsp.语义级重命名<tab>(:LspRename)              :LspRename<CR>

noremenu @Lsp.文件级查找<tab>(:LspDocumentSymbolSearch)  :LspDocumentSymbolSearch<CR>
noremenu @Lsp.工作区查找<tab>(:LspWorkspaceSymbol)       :LspWorkspaceSymbol<CR>

noremenu @Lsp.转到声明<tab>(:LspDeclaration)             :LspDeclaration<CR>
noremenu @Lsp.转到定义<tab>(:LspDefinition)              :LspDefinition<CR>
noremenu @Lsp.所有引用处<tab>(:LspReferences)            :LspReferences<CR>

noremenu @Lsp.前后跳转.下一处问题<tab>(:LspNextDiagnostic)      :LspNextDiagnostic<CR>
noremenu @Lsp.前后跳转.下一个引用处<tab>(:LspNextReference)     :LspNextReference<CR>
noremenu @Lsp.前后跳转.上一处问题<tab>(:LspPreviousDiagnostic)  :LspPreviousDiagnostic<CR>
noremenu @Lsp.前后跳转.上一处引用<tab>(:LspPreviousReference)   :LspPreviousReference<CR>

noremenu @Lsp.显示详情K\ <tab>(:LspHover)              :LspHover<CR>
noremenu @Lsp.各LSP运行状态<tab>(:LspStatus)           :LspStatus<CR>
# }}}

# 创建@Vimwiki菜单栏 {{{
# set runtimepath+=%userprofile%/vimfiles/plugged/vimwiki
noremenu @Vimwiki.进入默认wiki索引文件<tab>(:VimwikiIndex)              :VimwikiIndex<CR>
noremenu @Vimwiki.重命名当前wiki<tab>(:VimwikiRenameFile)               :VimwikiRenameFile<CR>
noremenu @Vimwiki.删除当前wiki<tab>(:VimwikiDeleteFile)                 :VimwikiDeleteFile<CR>
noremenu @Vimwiki.选择并打开wiki<tab>(:VimwikiUISelect)                 :VimwikiUISelect<CR>
noremenu @Vimwiki.创建一个表格(2行5列)<tab>(;cb)                        :VimwikiTable<CR>
noremenu @Vimwiki.为本页创建目录(于页首)<tab>(:VimwikiTOC)              :VimwikiTOC<CR>

noremenu @Vimwiki.wiki导出为HTML<tab>(:Vimwiki2HTML)                    :Vimwiki2HTML<CR>
noremenu @Vimwiki.wiki导出为HTML并浏览器打开<tab>(:Vimwiki2HTMLBrowse)  :Vimwiki2HTMLBrowse<CR>
noremenu @Vimwiki.wiki全部导出为HTML<tab>(:VimwikiAll2HTML)             :VimwikiAll2HTML<CR>

noremenu @Vimwiki.切换checkbox状态<tab>(;cb)                            :VimwikiToggleListItem<CR>

# vimwiki网页一键渲染代码块monokai(借助highlight.js) 
noremenu @Vimwiki.一键渲染html(加js脚本)                                :source expand("index").".vim"<CR>
# }}}

# 显示菜单栏
set guioptions+=m

# 转到编辑myUtils插件
noremenu @MyCmdSnippetsUI.转到编辑Utils插件                          :execute("tabnew " .. g:myUtilsFilename)<CR>

# UI选择idx，执行终端命令{{{
command! MyCommandUiSelect call MyCommandUiSelect()
noremenu @MyCmdSnippetsUI.选一个idx以执行某命令                      :MyCommandUiSelect<CR>

var cmdstrs = [
            \ 'git status',
            \ 'git reflog',
            \ 'git add . && git commit -m "..." && git push',
            \ 'git add .',
            \ 'git push',
            \ ]
# 被MyCommandUiSelect调用
def PrintMyCmdList()
    var max_len = 0
    if &filetype != 'css'
        cmdstrs = [
                    \ 'git status',
                    \ 'git reflog',
                    \ 'git add . && git commit -m "..." ',
                    \ 'git add .',
                    \ 'powershell',
                    \ ]
    endif
    var cmdstr: string
    for idx in range(len(cmdstrs))
        cmdstr = cmdstrs[idx]
        if len(cmdstr) > max_len
            max_len = len(cmdstr)
        endif
    endfor
    for idx in range(len(cmdstrs))
        cmdstr = cmdstrs[idx]
        echo printf('%2d %-*s', idx + 1, max_len + 2, cmdstr)
    endfor
enddef
# 被MyCommandUiSelect调用
# 输入idx执行,异步执行第idx条指令,且右边开一个终端
def MyAsyncRun(idx: number)
    var async_run_prefix = ":AsyncRun -mode=term -pos=right -col=50 "
    execute async_run_prefix .. cmdstrs[idx]
enddef

#菜单栏UI的主要函数(全局)
def g:MyCommandUiSelect()
    call PrintMyCmdList()
    var idx: number = 0
    var input_str = input('选择命令对应number 且 按<Enter>键 (空输入则啥也不做): ')
    if input_str ==# ''
        return
    elseif idx > 9 
        echo "\n"
        echom '无效选择.'
        return
    else
        idx = input_str->str2nr()
        MyAsyncRun(idx - 1)
    endif
enddef
# }}}

# 输入一个图片链接包装为vimwiki链接 {{{
command! MyInsertVimwikiImgLink call MyInsertVimwikiImgLink()
noremenu @MyCmdSnippetsUI.输入图片链接包装vimwiki链接(to剪贴板)              :MyInsertVimwikiImgLink<CR>

def MyInsertVimwikiImgLink()
    g:my_utils_user_input_str = input('请输入图片链接 且 按<Enter>键 (空输入则啥也不做): ')
    if g:my_utils_user_input_str ==# ''
        return
    else
        @+ = '{{' 
        .. g:my_utils_user_input_str 
        .. '|imageName|' 
        .. 'style="width:12em;height:12em;display: block; margin: 0 auto;"' 
        .. '}}' 
        echo "\n"
        echo "结果已返回到系统剪贴板."
    endif
enddef
# }}}


# }}}

# 打开最近文件
noremenu 文件(F).@打开最近文件<tab>(:browse\ oldfiles)              :browse oldfiles<CR>
