" Nathan Holland's .vimrc, 2015

" neobundle {{{ 
" setup {{{
if has('vim_starting')
  if &compatible
    set nocompatible
  endif

  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif
" }}}

call neobundle#begin(expand("~/.vim/bundle/"))

" plugins {{{
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'Shougo/unite.vim'
" NeoBundle 'Shougo/neocomplete.vim'
NeoBundle 'vim-scripts/AutoComplPop'
"NeoBundle 'vim-scripts/c.vim'
NeoBundle 'michalbachowski/vim-wombat256mod'
" }}}

call neobundle#end()
" }}} 

" defaults {{{
filetype on
filetype plugin on
filetype indent on

syntax on
colorscheme wombat256mod

set tabstop=2 shiftwidth=2 expandtab
set foldmethod=marker
" }}}

" user functions {{{
function! WrapSelectionWithFold()
  let l:top_selection = getpos("'<")
  let l:bottom_selection = getpos("'>")
  let l:bufnum = l:top_selection[0]
  let l:top_line = l:top_selection[1]
  let l:bottom_line = l:bottom_selection[1]

  normal 0
  call setpos('.', [l:bufnum, l:top_line - 1, 0])
  execute "put =b:comment_open"
  normal A  {{{ 
  execute "put =b:comment_close"
  normal k$J

  call setpos('.', [l:bufnum, l:bottom_line + 1, 0])
  execute "put =b:comment_open"
  normal A }}} 
  execute "put =b:comment_close"
  normal k$J

  let l:comment_open_length = strlen(b:comment_open)
  call setpos('.', [l:bufnum, l:top_line, l:comment_open_length + 2])
  return ""
endfunction
" }}}

" filetype specific {{{
" c {{{
autocmd FileType c setlocal cindent
autocmd FileType c let b:comment_open="/*"
autocmd FileType c let b:comment_close="*/"
" }}}

" vim {{{
autocmd FileType vim let b:comment_open = "\""
autocmd FileType vim let b:comment_close = ""
" }}}

" make {{{
autocmd FileType make setlocal noexpandtab tabstop=8 shiftwidth=8 softtabstop=0
" }}}
" }}}

" keybindings {{{
nnoremap <Space> za

vnoremap <Leader>c :<Backspace><Backspace><Backspace><Backspace><Backspace>call WrapSelectionWithFold()<CR>
" }}}

" plugin setup {{{ 
" neocomplete {{{ 
let g:neocomplete#enable_at_startup = 1
" }}} 
" }}} 

NeoBundleCheck
