" Configuration file for vim
set modelines=0		" CVE-2007-2438

" Normally we use vim-extensions. If you want true vi-compatibility
" remove change the following statements
set nocompatible	" Use Vim defaults instead of 100% vi compatibility
set backspace=2		" more powerful backspacing

" Don't write backup file if vim is being called by "crontab -e"
au BufWrite /private/tmp/crontab.* set nowritebackup nobackup
" Don't write backup file if vim is being called by "chpass"
au BufWrite /private/etc/pw.* set nowritebackup nobackup

" tab and indent
set expandtab
"set tabstop=4
set softtabstop=4
set autoindent
set smartindent
set shiftwidth=4

" appearence
set cursorline
syntax on
set number
set ruler
hi Comment ctermfg=blue

" other settings
set spell

" disable conceal
let g:tex_conceal=''

" setting of dein.vim
if &compatible
 set nocompatible
endif
" Add the dein installation directory into runtimepath
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.config/nvim')
 call dein#begin('~/.config/nvim/dein')

 " about toml file
 let g:dein_dir = expand('~/.config/nvim/dein')
 let s:toml = g:dein_dir . '/dein.toml'
 let s:lazy_toml = g:dein_dir . '/dein_lazy.toml'

 " plod toml file
 call dein#load_toml(s:toml, {'lazy': 0})
 call dein#load_toml(s:lazy_toml, {'lazy': 1})

 " 自分のプラグイン

 if !has('nvim')
   call dein#add('roxma/nvim-yarp')
   call dein#add('roxma/vim-hug-neovim-rpc')
 endif

 call dein#end()
 call dein#save_state()
endif

"もし未インストールがあればインストール
if dein#check_install()
  call dein#install()
endif

filetype plugin indent on
syntax enable
set background=dark

" カラースキームの設定
colorscheme iceberg
set t_Co=256

" インデントラインの設定
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_exclude_filetypes = ['help', 'nerdtree']
let g:indent_guides_guide_size = 1
let g:indent_guides_start_level = 2
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd ctermbg=darkgray
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=darkgray

"quickrun
let g:quickrun_config = {}
let g:quickrun_config['tex'] = {
\   'command' : 'latexmk',
\   'outputter' : 'error',
\   'outputter/error/error' : 'quickfix',
\   'cmdopt': '-pdfdvi',
\   'exec': ['%c %o %s'],
\ }

" vimtex
let g:vimtex_compiler_latexmk = {
\ 'background': 1,
\ 'build_dir': '',
\ 'continuous': 1,
\ 'options': [
\    '-pdfdvi',
\    '-verbose',
\    '-file-line-error',
\    '-synctex=1',
\    '-interaction=nonstopmode',
\],
\}

" vimtexの設定
let g:vimtex_view_general_viewer
      \ = '/Applications/Skim.app/Contents/SharedSupport/displayline'
let g:vimtex_view_general_options = '-r @line @pdf @tex'

" pythonパスの設定
let g:python_host_prog = expand('~/nvim-python2/bin/python2')
let g:python3_host_prog = expand('~/nvim-python3/bin/python3')

" pythonシンタックスの設定
let g:python_highlight_all = 1

" vim-gitgutter についての設定
" " 目印行を常に表示する
if exists('&signcolumn')  " Vim 7.4.2201
  set signcolumn=yes
else
  let g:gitgutter_sign_column_always = 1
endif

" ===== vim-lsp =====
let g:lsp_diagnostics_enabled = 1  " 文法チェックを有効化
let g:lsp_diagnostics_echo_cursor = 1  " エラーメッセージをステータスボックスに表示
let g:lsp_diagnostics_highlights_enabled = 0  " エラー箇所のハイライト表示
let g:lsp_diagnostics_virtual_text_enabled = 0  " エラー箇所横のメッセージ表示
" pycodestyleではなくflake8を用いる
let g:lsp_settings = {
\   'pyls-all': {
\     'workspace_config': {
\       'pyls': {
\         'configurationSources': ['flake8'],
\       }
\     }
\   }
\}
nnoremap <buffer> gd :<C-u>LspDefinition<CR>  " 定義を確認
nnoremap <buffer> gr :<C-u>LspReferences<CR>  " 参照を確認
nnoremap <buffer> gf :<C-u>LspDocumentFormat<CR>  " ドキュメントをフォーマット

" setting of open-browser.vim
let g:previm_open_cmd = 'open -a Google\ Chrome'
