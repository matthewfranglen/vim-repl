" repl.vim - Execute text as shell commands
" Maintainer: Matthew Franglen
" Version:    0.0.1

if exists('g:loaded_repl') || &compatible
  finish
endif
let g:loaded_repl = 1

function! g:Repl()
    nnoremap <buffer> <CR> 0y$Go<ESC>: -r ! <C-R>"<CR>o<CR><C-R>"<ESC>
endfunction
