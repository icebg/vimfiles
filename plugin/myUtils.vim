vim9script
if exists('g:loaded_MyPlugin') || !has('win32') || !has('gui_running') || v:version < 900
    finish
endif
g:loaded_MyPlugin = 1

# 创建@Lsp菜单栏
menu @Lsp.一键规范格式<tab>(:LspDocumentFormat)      :LspDocumentFormat<CR>
menu @Lsp.修复建议<tab>(:LspCodeAction)              :LspCodeAction<CR>
menu @Lsp.语义级重命名<tab>(:LspRename)              :LspRename<CR>

menu @Lsp.文件级查找<tab>(:LspDocumentSymbolSearch)  :LspDocumentSymbolSearch<CR>
menu @Lsp.工作区查找<tab>(:LspWorkspaceSymbol)       :LspWorkspaceSymbol<CR>

menu @Lsp.转到声明<tab>(:LspDeclaration)             :LspDeclaration<CR>
menu @Lsp.转到定义<tab>(:LspDefinition)              :LspDefinition<CR>
menu @Lsp.所有引用处<tab>(:LspReferences)            :LspReferences<CR>

menu @Lsp.前后跳转.下一处问题<tab>(:LspNextDiagnostic)      :LspNextDiagnostic<CR>
menu @Lsp.前后跳转.下一个引用处<tab>(:LspNextReference)     :LspNextReference<CR>
menu @Lsp.前后跳转.上一处问题<tab>(:LspPreviousDiagnostic)  :LspPreviousDiagnostic<CR>
menu @Lsp.前后跳转.上一处引用<tab>(:LspPreviousReference)   :LspPreviousReference<CR>

menu @Lsp.显示详情K\ <tab>(:LspHover)              :LspHover<CR>
menu @Lsp.各LSP运行状态<tab>(:LspStatus)           :LspStatus<CR>

# 创建@Vimwiki菜单栏
# set runtimepath+=%userprofile%/vimfiles/plugged/vimwiki
menu @Vimwiki.进入默认wiki索引文件<tab>(:VimwikiIndex)              :VimwikiIndex<CR>
menu @Vimwiki.重命名当前wiki<tab>(:VimwikiRenameFile)               :VimwikiRenameFile<CR>
menu @Vimwiki.删除当前wiki<tab>(:VimwikiDeleteFile)              :VimwikiDeleteFile<CR>
menu @Vimwiki.选择并打开wiki<tab>(:VimwikiUISelect)              :VimwikiUISelect<CR>

menu @Vimwiki.wiki导出为HTML<tab>(:Vimwiki2HTML)                 :Vimwiki2HTML<CR>
menu @Vimwiki.wiki全部导出为HTML<tab>(:VimwikiAll2HTML)          :VimwikiAll2HTML<CR>

menu @Vimwiki.切换checkbox状态<tab>(;cb)                         :VimwikiToggleListItem<CR>

# 显示菜单栏
set guioptions+=m

command! MyCommandUISelect call My_command_ui_select()
menu @MyCmdSnippetsUI.选一个idx以执行某命令                     :MyCommandUISelect<CR>
menu @MyCmdSnippetsUI.转到编辑Utils插件                     :execute('tabnew '..expand('%:p'))<CR>
# menu @MyCmdSnippetsUI.输入一个msg以执行commit                 :CommitUI<CR>

#我的UI函数
var cmdstrs = [
            \ 'git status',
            \ 'git reflog',
            \ 'git add . && git commit -m "..."',
            \ 'git add .',
            \ 'git push',
            \ ]
# 被My_command_ui_select调用
def Print_mycmd_list()
    var max_len = 0
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
# 被My_command_ui_select调用
# 输入idx执行,异步执行第idx条指令,且右边开一个终端
def My_async_run(idx: number)
    var async_run_prefix = ":AsyncRun -mode=term -pos=right -col=50 "
    execute async_run_prefix .. cmdstrs[idx]
enddef

def g:My_command_ui_select()
    call Print_mycmd_list()
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
        My_async_run(idx - 1)
    endif
enddef

