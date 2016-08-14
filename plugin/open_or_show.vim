function! OpenOrShow(file_line)
python3 << EOF
import vim

def _goto_window_for_buffer(b):
    w = int(vim.eval('bufwinnr(%d)' % int(b)))
    vim.command('%dwincmd w' % w)

def _goto_window_for_bufer_name(bn):
    b = vim.eval('bufnr("%s")' % bn)
    return _goto_window_for_buffer(b)

def _goto_line(nr):
    vim.command('normal %dgg' % nr)

def _open_new_window(filename):
    vim.command('new %s' % filename)

def openFileInExistingBuffer(file_line):
    parts = file_line.split(':')
    filename = parts[0]
    if len(parts) > 1:
        linenr = int(parts[1])
    else:
        linenr = 1
    print("looking for", file_line)
    for w in vim.windows:
        if w.buffer.name == filename:
            _goto_window_for_bufer_name(filename)
            _goto_line(linenr)
            return
    _open_new_window(filename)
    _goto_line(linenr)

openFileInExistingBuffer(vim.eval("a:file_line"))
EOF

endfunction

command! -complete=file -nargs=1 OpenOrShow call OpenOrShow(<f-args>)
