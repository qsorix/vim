python3 << EOF
import vim

def _goto_window_for_buffer(b):
    w = int(vim.eval('bufwinnr(%d)' % int(b)))
    vim.command('%dwincmd w' % w)

def _goto_window_for_buffer_name(bn):
    b = vim.eval('bufnr("%s")' % bn)
    return _goto_window_for_buffer(b)

def openFileInExistingBuffer(filename):
    for w in vim.windows:
        if w.buffer.name == filename:
            _goto_window_for_buffer_name(filename)
            return
    print("not opened yet")
EOF
