" general
set modelines=0     " CVE-2007-2438
syntax on                                " 语法高亮
filetype on                              " 开启文件类型检测

set backspace=indent,eol,start           " 回退
set encoding=utf-8                       " 编码设置
set number                               " 显示行号
" set relativenumber                       " 显示相对行号
set smartindent                          " 智能缩进
set autoindent                           " 自动对齐
set autochdir                            " 自动工作目录

set smarttab
set tabstop=4                            " tab缩进
set shiftwidth=4                         " 设定自动缩进为4个字符
set expandtab                            " 用space替代tab的输入
set splitright                           " 设置左右分割窗口时，新窗口出现在右侧
set splitbelow                           " 设置水平分割窗口时，新窗口出现在底部

set nobackup                             " 不需要备份
set noswapfile                           " 禁止生成临时文件
set autoread                             " 文件自动检测外部更改

set nocompatible                         " 去除vi一致性
set ambiwidth=double                     " 解决中文标点显示的问题
set nowrap                               " 不自动折行
set mouse=a                              " 使用鼠标
set mousehide                            " 输入时隐藏光标

set sm!                                  " 高亮显示匹配括号
set hlsearch                             " 高亮查找匹配
set cursorline                           " 高亮显示当前行
set termguicolors                        " 启用终端真色（不支持的终端可以不设置）

set showmatch                            " 显示匹配
set ruler                                " 显示标尺，在右下角显示光标位置
set novisualbell                         " 不要闪烁
set showcmd                              " 显示输入的命令
set completeopt=longest,menu             " 自动补全

" 设置光标样式
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_SR = "\<Esc>]50;CursorShape=2\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

if has("autocmd")
  " 记住上次编辑
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
  " 未指定文件,显示目录
  au vimenter * if !argc()|NERDTree|endif
  " 目录是最后窗口，默认关闭
  au bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
endif

" 行移动 
nnoremap <S-DOWN> :m .+1<CR>==
nnoremap <S-UP> :m .-2<CR>==
inoremap <S-DOWN> <Esc>:m .+1<CR>==gi
inoremap <S-UP> <Esc>:m .-2<CR>==gi
vnoremap <S-DOWN> :m '>+1<CR>gv=gv
vnoremap <S-UP> :m '<-2<CR>gv=gv

" plugins
call plug#begin('~/.vim/plugged')

" 状态栏
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" 目录树
Plug 'preservim/nerdtree'
nnoremap <C-F> :NERDTreeFind<CR>
nnoremap <C-E> :NERDTreeToggle<CR>
let NERDTreeShowHidden=1
let NERDTreeIgnore=['\.git$', '\.DS_Store$', 'build', 'vendor']

" 模糊搜索
Plug 'yggdroot/leaderf'
let g:Lf_ShortcutF = '<C-P>'

" 自动生成tags
Plug 'ludovicchabant/vim-gutentags'
set tags=tags
let g:gutentags_project_root = ['.root', '.svn', '.git']
let g:gutentags_ctags_tagfile = '.tags'
let s:vim_tags = expand('~/.cache/tags')
let g:gutentags_cache_dir = s:vim_tags
if !isdirectory(s:vim_tags)
   silent! call mkdir(s:vim_tags, 'p')
endif
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+pxI']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']
let g:gutentags_ctags_exclude = ['\.git', 'vendor', 'build', '*.json']

call plug#end()
