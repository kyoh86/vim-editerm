" editerm.vim -
" Maintainer:	kyoh86
" License:		MIT License(http://www.opensource.org/licenses/MIT)

if exists('g:loaded_editerm')
  finish
endif
let g:loaded_editerm = 1

let s:save_cpo = &cpo
set cpo&vim

scriptversion 3

" Function: Tapi_EditermEditFile
" Description: It should be called from :terminal with three parameters
" [(n|e|v|t), (lock file), (editing file)] as $EDITOR.
function! Tapi_EditermEditFile(bufnum, arglist)
  if len(a:arglist) == 4
    call editerm#open(a:arglist[0], a:arglist[1], a:arglist[2], a:arglist[3])
  endif
endfunction

let s:dir = expand('<sfile>:p:h')
let $EDITOR = s:dir .. '/tvim'
let $VIM_EDITERM_SETUP = s:dir .. '/setup.sh'
let $VIM_EDITERM_DROP = s:dir .. '/tdrop'

let $VIM_EDITERM_OPENER = get(g:, 'editerm_opener', 'n')
let $VIM_EDITERM_DEFDROP = get(g:, 'editerm_defdrop', '1')
let $VIM_EDITERM_DEFDROP_PREFIX = get(g:, 'editerm_defdrop_prefix', ':')

let &cpo = s:save_cpo
unlet s:save_cpo
