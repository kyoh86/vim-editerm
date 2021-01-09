" editerm.vim -
" Maintainer:	kyoh86
" License:		MIT License(http://www.opensource.org/licenses/MIT)

scriptversion 3

if exists('g:autoloaded_editerm')
  finish
endif
let g:autoloaded_editerm = 1

let s:save_cpo = &cpo
set cpo&vim

let s:remotes={}

function! editerm#kill_remote(bang)
  let l:bufnr = bufnr('%')
  call editerm#release_remote(l:bufnr, '1')
  execute(l:bufnr .. get(g:, 'editerm_killer', 'bwipeout') .. a:bang)
endfunction

function! editerm#leave_remote()
  call editerm#release_remote(expand('<abuf>')+0, '0')
endfunction

function! editerm#release_remote(bufnum, ret)
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

function! editerm#open(command, lockfile, filename, options)
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

  execute(l:command .. ' ' .. a:options .. ' ' .. a:filename)

  if a:lockfile != ''
    let s:remotes[bufnr('%')] = a:lockfile
    setlocal bufhidden=wipe
    command -buffer -bang Cq :call editerm#kill_remote('<bang>')
    command -buffer -bang CQ :call editerm#kill_remote('<bang>')
    augroup EDITERM
      autocmd! * <buffer>
      autocmd BufUnload <buffer> :call editerm#leave_remote()
    augroup END
  endif
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
