" Vim color file
" Dark (grey on black) color scheme based on on a popular torte config.
" Maintainer: Sergei Matusevich <motus@motus.kiev.ua>
" ICQ: 31114346 Yahoo: motus2
" http://motus.kiev.ua/motus2/Files/motus.vim
" Last Change: 3 November 2005
" Orinal torte screme maintainer: Thorsten Maerz <info@netztorte.de>
" Licence: Public Domain

" INSTALLATION: copy this file to ~/.vim/colors/ directory
" and add "colorscheme motus" to your ~/.vimrc file

set background=dark
hi clear
if exists("syntax_on")
  syntax reset
endif
"colorscheme default
let g:colors_name = "motus"

" hardcoded colors :
" GUI Comment : #80a0ff = Light blue

" GUI
highlight Normal     guifg=Grey80	guibg=Black        
	"在与语法无关的地方，是黑底、灰字
highlight Search     guifg=Grey guibg=DarkBlue         
	"搜索高亮：蓝底灰字
highlight Visual     guifg=Black guibg=DarkGrey gui=NONE
	"visual选中的内容:灰底黑字

" highlight Cursor     guifg=Black	guibg=Green	gui=bold
highlight Special    guifg=Orange
highlight Comment    guifg=#80a0ff
"statement是关键字、语句
highlight Statement  guifg=Yellow			gui=NONE
"Type类型名称为绿色
highlight Type		 guifg=Green			gui=NONE

highlight VertSplit    gui=bold guifg=Grey25    guibg=Black
highlight StatusLine   gui=bold guifg=White     guibg=Grey25
highlight StatusLineNC gui=NONE guifg=LightGrey guibg=Grey25

highlight FoldColumn	 gui=bold guifg=White guibg=Black

" Console
highlight Normal     ctermfg=LightGrey	ctermbg=Black 
highlight Search     ctermfg=Grey	ctermbg=DarkBlue	cterm=NONE
highlight Visual					cterm=reverse
" highlight Cursor     ctermfg=Black	ctermbg=Green	cterm=bold
highlight Special    ctermfg=Brown
highlight Comment    ctermfg=Blue
highlight Statement  ctermfg=Yellow			cterm=NONE
highlight Type						cterm=NONE

highlight VertSplit    ctermfg=DarkGrey   ctermbg=Black cterm=bold
highlight StatusLine   ctermfg=White  ctermbg=Grey cterm=bold
highlight StatusLineNC ctermfg=Black  ctermbg=Grey cterm=NONE

highlight FoldColumn	ctermbg=Black		ctermfg=White cterm=bold

" only for vim 5
if has("unix")
  if v:version<600
    highlight Normal  ctermfg=Grey	ctermbg=Black	cterm=NONE	guifg=Grey80      guibg=Black	gui=NONE
    highlight Search  ctermfg=Black	ctermbg=Red	cterm=bold	guifg=Black       guibg=Red	gui=bold
    highlight Visual  ctermfg=Black	ctermbg=yellow	cterm=bold	guifg=Grey25			gui=bold
    highlight Special ctermfg=LightBlue			cterm=NONE	guifg=LightBlue			gui=NONE
    highlight Comment ctermfg=Cyan			cterm=NONE	guifg=LightBlue			gui=NONE
  endif
endif

"我写的设置:以下目前都是针对GUI的
"设置 折叠的行 (橙色，显眼一点)
highlight Folded		guibg=#181b14	guifg=Orange 
"设置 行号颜色(深灰底色，浅灰前景色)
highlight LineNr		guibg=#414141	guifg=Grey
"设置 光标选中的行号颜色
highlight CursorLineNr	guibg=Black	guifg=#db0005
"设置 任何常量
highlight Constant		guibg=NONE	guifg=#ffa0a0
"设置 变量名、函数名
highlight Identifier 	guibg=NONE	guifg=#40ffff
"设置 预处理命令
highlight PreProc		guibg=NONE	guifg=#ff80ff
