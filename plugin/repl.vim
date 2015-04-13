" repl.vim - Execute text as shell commands
" Maintainer: Matthew Franglen
" Version:    0.0.4

if exists('g:loaded_repl') || &compatible
  finish
endif
let g:loaded_repl = 1

function! g:Repl()
    command! -buffer -range Invoke call s:InvokeWithRange(<line1>, <line2>)
    nnoremap <buffer> <CR> :Invoke<CR>
    vnoremap <buffer> <CR> :'<,'>Invoke<CR>
    call s:HandleShellEscapes()
endfunction
command! Repl call g:Repl()

function s:InvokeWithRange(start, end)
    call s:InvokeRepl(getline(a:start, a:end))
endfunction

function s:InvokeRepl(commandList)
    let command = join(a:commandList, " ")
    call s:MoveToBottomOfFile()
    call s:ExecuteCommandAndAppendOutput(command)
    call s:AppendCommand(a:commandList)
endfunction

function s:MoveToBottomOfFile()
    normal G
endfunction

function s:ExecuteCommandAndAppendOutput(command)
    echo "Executing " . a:command
    silent! normal o
    silent! execute ": -r ! " . a:command
    silent! normal o
endfunction

function s:AppendCommand(commandList)
    for line in a:commandList
        put =line
    endfor
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
