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
NeoBundle 'Shougo/neocomplete.vim'
" NeoBundle 'vim-scripts/AutoComplPop'
" NeoBundle 'vim-scripts/c.vim'
NeoBundle 'majutsushi/tagbar'
NeoBundle 'xolox/vim-misc'
" NeoBundle 'xolox/vim-easytags'
NeoBundle 'michalbachowski/vim-wombat256mod'
NeoBundle 'brandonbloom/vim-factor'
NeoBundle 'vim-airline/vim-airline'
NeoBundle 'vim-airline/vim-airline-themes'
NeoBundle 'vim-scripts/ats-lang-vim'
NeoBundle 'Prosumma/vim-rebol'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'flaflasun/vim-nightowl'
NeoBundle 'elixir-lang/vim-elixir'
NeoBundle 'andrewmacp/llvm.vim'
" }}}

call neobundle#end()
" }}} 

" options {{{
filetype on
filetype plugin on
filetype indent on

syntax on

set modeline
set laststatus=2
set tabstop=2 shiftwidth=2 expandtab
set foldmethod=marker
set wildmode=longest,list,full
set wildmenu
set mouse=a
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
  "normal k$J

  let l:comment_open_length = strlen(b:comment_open)
  call setpos('.', [l:bufnum, l:top_line, l:comment_open_length + 2])
  return ""
endfunction

function! ConcealOcamlSyntax()
  "" TODO: play with fira code

  " execute "syntax match ocamlAnonymousFunctionKeyword \"\\((\\| \\)\\zsfun\\ze\\( \\|\\n\\)\" conceal cchar=λ"
  execute "syntax match ocamlAnonTypeAKeyword \"'a\" conceal cchar=α"
  execute "syntax match ocamlAnonTypeBKeyword \"'b\" conceal cchar=β"
  execute "syntax match ocamlUnitKeyword \"()\" conceal cchar=∅"
  execute "syntax match ocamlNotKeyword \"not\" conceal cchar=¬"
  execute "syntax match ocamlAndKeyword \"\&\&\" conceal cchar=∧"
  execute "syntax match ocamlOrKeyword \"||\" conceal cchar=∨"
  execute "syntax match ocamlRightArrowKeyword \"->\" conceal cchar=→"
  execute "syntax match ocamlLeftArrowKeyword \"<-\" conceal cchar=←"
  execute "syntax match ocamlListForAllKeyword \"List.for_all\" conceal cchar=∀"
  execute "syntax match ocamlListExistsKeyword \"List.exists\" conceal cchar=∃"
  execute "syntax match ocamlListForAllKeyword \"Array.for_all\" conceal cchar=∀"
  execute "syntax match ocamlListExistsKeyword \"Array.exists\" conceal cchar=∃"
  " execute "syntax match ocamlPipelineOpKeyword \"|>\" conceal cchar=⇰"
  execute "syntax match ocamlChompOpKeyword \"@@\" conceal cchar=⇤"
  " execute "syntax match ocamlEqualsFunctionKeyword \"= function\" conceal cchar=⟼"

  " execute "hi link ocamlAnonymousFunctionKeyword ocamlAnonymousFunction"
  execute "hi link ocamlAnonTypeAKeyword ocamlAnonTypeA"
  execute "hi link ocamlAnonTypeBKeyword ocamlAnonTypeB"
  execute "hi link ocamlUnitKeyword ocamlUnit"
  execute "hi link ocamlNotKeyword ocamlNot"
  execute "hi link ocamlAndKeyword ocamlAnd"
  execute "hi link ocamlOrKeyword ocamlOr"
  execute "hi link ocamlRightArrowKeyword ocamlRightArrow"
  execute "hi link ocamlLeftArrowKeyword ocamlLeftArrow"
  execute "hi link ocamlListForAllKeyword ocamlListForAll"
  execute "hi link ocamlListExistsKeyword ocamlListExists"
  execute "hi link ocamlArrayForAllKeyword ocamlArrayForAll"
  execute "hi link ocamlArrayExistsKeyword ocamlArrayExists"
  execute "hi link ocamlPipelineOpKeyword ocamlPipelineOp"
  execute "hi link ocamlChompOpKeyword ocamlChompOp"

  " execute "hi! link Conceal ocamlAnonymousFunction"
  execute "hi! link Conceal ocamlAnonTypeA"
  execute "hi! link Conceal ocamlAnonTypeB"
  execute "hi! link Conceal ocamlUnit"
  execute "hi! link Conceal ocamlNot"
  execute "hi! link Conceal ocamlAnd"
  execute "hi! link Conceal ocamlOr"
  execute "hi! link Conceal ocamlRightArrow"
  execute "hi! link Conceal ocamlLeftArrow"
  execute "hi! link Conceal ocamlListForAll"
  execute "hi! link Conceal ocamlListExists"
  execute "hi! link Conceal ocamlArrayForAll"
  execute "hi! link Conceal ocamlArrayExists"
  execute "hi! link Conceal ocamlPipelineOp"
  execute "hi! link Conceal ocamlChompOp"

  setlocal conceallevel=1
  setlocal concealcursor=c
endfunction

function! ConcealOcamlModuleSpecificSyntax()
  execute "syntax match ocamlTypeColonKeyword \" \\zs:\\ze \" conceal cchar=⇒"
  execute "hi link ocamlTypeColonKeyword ocamlTypeColon"
  execute "hi! link Conceal ocamlTypeColon"
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

" ats {{{
autocmd BufRead,BufNewFile *.dats setf ats
autocmd BufRead,BufNewFile *.sats setf ats
autocmd BufRead,BufNewFile *.cats setf c
autocmd BufRead,BufNewFile *.hats setf c
" }}}

" red {{{
autocmd BufRead,BufNewFile *.red setf rebol
" }}}

" prolog {{{
let g:filetype_pl = "prolog"
" }}}

" spirv assembly {{{
autocmd BufRead,BufNewFile *.spirv setf spvasm
" }}}

" ocaml {{{
"autocmd BufRead,BufNewFile *.ml call ConcealOcamlSyntax()
"autocmd BufRead,BufNewFile *.mli call ConcealOcamlSyntax()
"autocmd BufRead,BufNewFile *.mli call ConcealOcamlModuleSpecificSyntax()
" }}}

" d {{{
" autocmd BufRead,BufNewFile *.d TagbarOpen
let g:syntastic_d_include_dirs = add(add(map(filter(glob('~/.dub/packages/*', 1, 1), 'isdirectory(v:val)'), 'isdirectory(v:val . "/source") ? v:val . "/source" : v:val'), './source'), '~/.dub/packages/glamour-1.0.1/glamour')
" }}}

" llvm {{{
autocmd BufRead,BufNewFile *.llvm setf llvm
" }}}
" }}}

" keybindings {{{
nnoremap <Space> za
nnoremap <Leader>t :TagbarToggle<CR>
nnoremap <Leader>x :SyntasticToggleMode<CR>
nnoremap <Leader>p :r !xclip -selection clipboard -o<CR>

vnoremap <Leader>c :<Backspace><Backspace><Backspace><Backspace><Backspace>call WrapSelectionWithFold()<CR>
vnoremap <Leader>y :w !xclip -selection clipboard -i<CR><CR>
" }}}

NeoBundleCheck

" plugin setup {{{ 
" nerdtree {{{
let NERDTreeIgnore=['_build$[[dir]]', 'deps$[[dir]]', 'vendor$[[dir]]']
" }}}

" neocomplete {{{ 
let g:acp_enableAtStartup = 0
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_auto_select = 1

if !exists('g:neocomplete#force_omni_input_patterns')
  let g:neocomplete#force_omni_input_patterns = {}
endif
" }}} 

" syntastic {{{
set statusline +=%#warningmsg#
set statusline +=%{SyntasticStatuslineFlag()}
set statusline +=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" ignore .mll and .mly to avoid merlin warnings
let g:syntastic_ignore_files = ['\m\c.ml[ly]$']

let g:syntastic_cpp_compiler_options = ' -std=c++11'
let g:syntastic_cpp_include_dirs = [ '/home/nathan/libsrc/VulkanSDK/1.0.21.1/x86_64/include' ]
let g:syntastic_cpp_config_file = '.syntastic-config'
" }}} 

" merlin {{{
let g:opamshare = substitute(system('opam config var share'), '\n$', '', '''')
execute "set rtp+=" . g:opamshare . "/merlin/vim"

let g:neocomplete#force_omni_input_patterns.ocaml = '[^. *\t]\.\w*\|\h\w*|#'
let g:syntastic_ocaml_checkers = ['merlin']
" }}}

" airline {{{
let g:airline_theme="kolor"
" }}} 
" }}} 

" tagbar {{{
let g:tagbar_type_d = {
  \ 'ctagstype' : 'd',
  \ 'kinds'     : [
    \ 'M:module',
    \ 'X:mixins',
    \ 'T:templates:1',
    \ 't:typedefs',
    \ 'g:enums',
    \ 'e:enumerators',
    \ 'c:classes',
    \ 'v:interfaces',
    \ 's:structs',
    \ 'u:unions',
    \ 'm:members',
    \ 'f:functions'
  \ ],
  \ 'sro' : '::',
  \ 'kind2scope' : {
    \ 'g' : 'enum',
    \ 'T' : 'template',
    \ 'c' : 'class',
    \ 'v' : 'interface',
    \ 's' : 'struct',
    \ 'u' : 'union'
  \ },
  \ 'scope2kind' : {
    \ 'enum' : 'g',
    \ 'template' : 'T',
    \ 'class' : 'c',
    \ 'interface' : 'v',
    \ 'struct' : 's',
    \ 'union' : 'u'
  \ }
 \ }
" }}}

" etc... {{{
" make certain terminals work under colors {{{
set t_Co=256
colorscheme nightowl
" }}}

" opam {{{
" ## added by OPAM user-setup for vim / base ## 93ee63e278bdfc07d1139a748ed3fff2 ## you can edit, but keep this line
let s:opam_share_dir = system("opam config var share")
let s:opam_share_dir = substitute(s:opam_share_dir, '[\r\n]*$', '', '')

let s:opam_configuration = {}

function! OpamConfOcpIndent()
  execute "set rtp^=" . s:opam_share_dir . "/ocp-indent/vim"
endfunction
let s:opam_configuration['ocp-indent'] = function('OpamConfOcpIndent')

function! OpamConfOcpIndex()
  execute "set rtp+=" . s:opam_share_dir . "/ocp-index/vim"
endfunction
let s:opam_configuration['ocp-index'] = function('OpamConfOcpIndex')

function! OpamConfMerlin()
  let l:dir = s:opam_share_dir . "/merlin/vim"
  execute "set rtp+=" . l:dir
endfunction
let s:opam_configuration['merlin'] = function('OpamConfMerlin')

let s:opam_packages = ["ocp-indent", "ocp-index", "merlin"]
let s:opam_check_cmdline = ["opam list --installed --short --safe --color=never"] + s:opam_packages
let s:opam_available_tools = split(system(join(s:opam_check_cmdline)))
for tool in s:opam_packages
  " Respect package order (merlin should be after ocp-index)
  if count(s:opam_available_tools, tool) > 0
    call s:opam_configuration[tool]()
  endif
endfor
" ## end of OPAM user-setup addition for vim / base ## keep this line
" }}}
" }}}
