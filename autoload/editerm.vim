" editerm.vim - 
" Maintainer:   kyoh86

scriptversion 3

if exists('g:autoloaded_editerm')
  finish
endif
let g:autoloaded_editerm = 1

let s:save_cpo = &cpo
set cpo&vim

let s:remotes={}

function! s:kill_remote(bang)
  let l:bufnr = bufnr('%')
  call s:release_remote(l:bufnr, '1')
  execute(l:bufnr .. 'bwipeout' .. a:bang)
endfunction

function! s:leave_remote()
  call s:release_remote(expand('<abuf>')+0, '0')
endfunction

function! s:release_remote(bufnum, ret)
  " lockfile for the buffer
  let l:locker = get(s:remotes, a:bufnum, '')

  if l:locker != ''
    " delete lockfile
    call writefile([a:ret], l:locker)

    unlet s:remotes[a:bufnum]
  endif
endfunction

function! editerm#open(lockfile, filename)
  execute('new ' .. a:filename)
  let s:remotes[bufnr('%')] = a:lockfile
  setlocal bufhidden=wipe
  command -buffer -bang Cq :call <SID>kill_remote('<bang>')
  command -buffer -bang CQ :call <SID>kill_remote('<bang>')
  augroup EDITERM
    autocmd! * <buffer>
    autocmd BufUnload <buffer> :call <SID>leave_remote()
  augroup END
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
