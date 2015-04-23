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

The Repl has a Context which is a set of commands to run before executing
anything. You can add lines and visual selections to it by pressing Control-C.
The Context can be used to move to a specific folder or export required
settings. You can clear the Context at any time using the _:ClearContext_
command.

This only affects the current buffer at the time you ran _:Repl_.
