" repl.vim - Execute text as shell commands
" Maintainer: Matthew Franglen
" Version:    0.0.6

if exists('g:loaded_repl') || &compatible
  finish
endif
let g:loaded_repl = 1

function! g:Repl()
    let b:repl_context = ''

    command! -buffer -range Invoke call s:InvokeWithRange(<line1>, <line2>)
    nnoremap <buffer> <CR> :Invoke<CR>
    vnoremap <buffer> <CR> :'<,'>Invoke<CR>

    command! -buffer -range Context call s:ContextWithRange(<line1>, <line2>)
    nnoremap <buffer> <C-C> :Context<CR>
    vnoremap <buffer> <C-C> :'<,'>Context<CR>

    command! -buffer ClearContext call s:ClearContext()

    call s:HandleShellEscapes()
endfunction
command! Repl call g:Repl()

function s:InvokeWithRange(start, end)
    call s:InvokeRepl(getline(a:start, a:end))
endfunction

function s:InvokeRepl(commandList)
    let command = join(a:commandList, ' ')
    call s:MoveToBottomOfFile()
    call s:ExecuteCommandAndAppendOutput(b:repl_context, command)
    call s:AppendCommand(a:commandList)
endfunction

function s:ContextWithRange(start, end)
    call s:ContextRepl(getline(a:start, a:end))
endfunction

function s:ContextRepl(commandList)
    let b:repl_context = b:repl_context . ' ; ' . join(a:commandList, ' ')
    echo 'Context is now {' . b:repl_context . '}'
endfunction

function s:ClearContext()
    let b:repl_context = ''
    echo 'Context is now {' . b:repl_context . '}'
endfunction

function s:MoveToBottomOfFile()
    normal G
endfunction

function s:ExecuteCommandAndAppendOutput(context, command)
    echo 'Executing {' . a:command . '} with context {' . a:context . '}'
    silent! normal o
    silent! execute ': -r ! ' . a:context . ' ; ' . a:command
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
