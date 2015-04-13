# Vim :Repl

This allows text to be executed as shell commands and any output written to the
vim buffer.

You enable this with:

    :Repl

Once you have done that pressing Enter on any line in the current buffer will
execute that line in the shell. The output will be pasted at the bottom of the
buffer, followed by the original command that was executed. This allows you to
easily edit and re-run the command.

If you make a visual selection then pressing enter will execute all selected
lines.

This only affects the current buffer at the time you ran _:Repl_.
