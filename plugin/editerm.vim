" editerm.vim - 
" Maintainer:   kyoh86

if exists('g:loaded_editerm')
  finish
endif
let g:loaded_editerm = 1

let s:save_cpo = &cpo
set cpo&vim

" Function: Tapi_EditermEditFile
" Description: It should be called from :terminal with two parameters
" [(lock file), (editing file)] as $EDITOR.
function! Tapi_EditermEditFile(bufnum, arglist)
  if len(a:arglist) == 2
    call editerm#open(a:arglist[0], a:arglist[1])
  endif
endfunction

let $EDITOR=expand('<sfile>:p:h') . '/tvim'

let &cpo = s:save_cpo
unlet s:save_cpo
