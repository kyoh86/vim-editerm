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
  if !has_key(s:remotes, a:bufnum)
    return
  endif

  " lockfile for the buffer
  let l:locker = s:remotes[a:bufnum]
  if l:locker != ''
    " update lockfile
    call writefile([a:ret], l:locker)
  endif
  unlet s:remotes[a:bufnum]
endfunction

function! editerm#open(command, lockfile, filename)
  let l:command = get({
    \ 'n': 'new',
    \ 'e': 'edit',
    \ 'v': 'vnew',
    \ 't': 'tabnew'
    \ }, a:command, '')
  if l:command == ''
    echoerr 'invalid command: ' .. a:command
    return
  endif

  execute(l:command .. ' ' .. a:filename)

  if a:lockfile != ''
    let s:remotes[bufnr('%')] = a:lockfile
    setlocal bufhidden=wipe
    command -buffer -bang Cq :call <SID>kill_remote('<bang>')
    command -buffer -bang CQ :call <SID>kill_remote('<bang>')
    augroup EDITERM
      autocmd! * <buffer>
      autocmd BufUnload <buffer> :call <SID>leave_remote()
    augroup END
  endif
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
