" repl.vim - Execute text as shell commands
" Maintainer: Matthew Franglen
" Version:    0.0.2

if exists('g:loaded_repl') || &compatible
  finish
endif
let g:loaded_repl = 1

function! g:Repl()
    nnoremap <buffer> <CR> :call <SID>InvokeRepl()<CR>
    call s:HandleShellEscapes()
endfunction
command! Repl call g:Repl()

function s:InvokeRepl()
    let command = getline('.')
    call s:MoveToBottomOfFile()
    call s:ExecuteCommandAndAppendOutput(command)
    call s:AppendCommand(command)
endfunction

function s:MoveToBottomOfFile()
    normal G
endfunction

function s:ExecuteCommandAndAppendOutput(command)
    normal o
    execute ": -r ! " . a:command
    normal o
endfunction

function s:AppendCommand(command)
    put =a:command
    normal jdd
endfunction

function s:HandleShellEscapes()
    if s:AnsiEscNotAvailable()
        return
    endif

    if s:AnsiEscAlreadyApplied()
        return
    endif

    call s:ApplyAnsiEsc()
endfunction

function s:AnsiEscNotAvailable()
    return ! exists('g:loaded_AnsiEscPlugin')
endfunction

function s:AnsiEscAlreadyApplied()
    return exists('b:applied_AnsiEsc')
endfunction

function s:ApplyAnsiEsc()
    call AnsiEsc#AnsiEsc(0)
    let b:applied_AnsiEsc = 1
endfunction
