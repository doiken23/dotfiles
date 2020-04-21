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
colorscheme challenger_deep
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
let g:python_host_prog = '/usr/bin/python3'
let g:python3_host_prog = '/usr/local/bin/python3'

" pythonシンタックスの設定
let g:python_highlight_all = 1

" ale tool についての設定
let g:ale_linters = {
\   'python': ['flake8'],
\}
let g:ale_fixers = {
    \ 'python': ['autopep8', 'isort'],
    \ }
" autopep8の設定
let g:ale_python_autopep8_options = '--aggressive --max-line-length=120'
" flake8の設定
let g:ale_python_flake8_options = '--max-line-length=120'

" vim-gitgutter についての設定
" " 目印行を常に表示する
if exists('&signcolumn')  " Vim 7.4.2201
  set signcolumn=yes
else
  let g:gitgutter_sign_column_always = 1
endif

" https://kashewnuts.github.io/2019/01/28/move_from_jedivim_to_vimlsp.html
" 言語用Serverの設定
augroup MyLsp
  autocmd!
  " pip install python-language-server
  if executable('pyls')
    " Python用の設定を記載
    " workspace_configで以下の設定を記載
    " - pycodestyleの設定はALEと重複するので無効にする
    " - jediの定義ジャンプで一部無効になっている設定を有効化
    autocmd User lsp_setup call lsp#register_server({
        \ 'name': 'pyls',
        \ 'cmd': { server_info -> ['pyls'] },
        \ 'whitelist': ['python'],
        \ 'workspace_config': {'pyls': {'plugins': {
        \   'pycodestyle': {'enabled': v:false},
        \   'jedi_definition': {'follow_imports': v:true, 'follow_builtin_imports': v:true},}}}
        \})
    autocmd FileType python call s:configure_lsp()
  endif
augroup END
" 言語ごとにServerが実行されたらする設定を関数化
function! s:configure_lsp() abort
  setlocal omnifunc=lsp#complete   " オムニ補完を有効化
  " LSP用にマッピング
  nnoremap <buffer> <C-]> :<C-u>LspDefinition<CR>
  nnoremap <buffer> gd :<C-u>LspDefinition<CR>
  nnoremap <buffer> gD :<C-u>LspReferences<CR>
  nnoremap <buffer> gs :<C-u>LspDocumentSymbol<CR>
  nnoremap <buffer> gS :<C-u>LspWorkspaceSymbol<CR>
  nnoremap <buffer> gQ :<C-u>LspDocumentFormat<CR>
  vnoremap <buffer> gQ :LspDocumentRangeFormat<CR>
  nnoremap <buffer> K :<C-u>LspHover<CR>
  nnoremap <buffer> <F1> :<C-u>LspImplementation<CR>
  nnoremap <buffer> <F2> :<C-u>LspRename<CR>
endfunction
let g:lsp_diagnostics_enabled = 0  " 警告やエラーの表示はALEに任せるのでOFFにする

" setting of open-browser.vim
let g:previm_open_cmd = 'open -a Google\ Chrome'
