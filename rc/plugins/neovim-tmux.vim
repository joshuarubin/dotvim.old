" emulate tmux in neovim
if exists("$TMUX") || !has("nvim")
  finish
endif

let s:terminal_quit='<c-\><c-n>'
let s:tmux_prefix='<c-a>'

function! s:tmux_bind_key(k, v, modes) abort
  for m in a:modes
    if m == 't'
      let cmd = s:terminal_quit.a:v
    elseif m == 'i'
      let cmd = '<ESC>'.a:v
    else
      let cmd = a:v
    endif
    exec m.'noremap <silent> '.s:tmux_prefix.a:k.' '.cmd
    exec m.'noremap <silent> '.s:tmux_prefix.'<c-'.a:k.'> '.cmd
  endfor
endfunction

" <c-a>c opens a new buffer
call s:tmux_bind_key('c', ':enew<cr>', ['n', 'v', 'i', 't'])

" <c-a>c opens a new horizontal split
call s:tmux_bind_key('s', ':split<cr>', ['n', 'v', 'i', 't'])

" <c-a>v opens a new vertical split
call s:tmux_bind_key('v', ':vsplit<cr>', ['n', 'v', 'i', 't'])

" <c-a>t opens a terminal in the currentbuffer
call s:tmux_bind_key('t', ':enew\|call termopen(&shell." -l")\|startinsert<cr>', ['n', 'v', 'i'])

" <c-a>a switches to the previous buffer
call s:tmux_bind_key('a', '<c-^>', ['n', 'v', 'i', 't'])

" vertically split current buffer
call s:tmux_bind_key('%', ':vspl<cr>', ['n', 'v', 'i', 't'])

" close the current window
call s:tmux_bind_key('&', '<c-w>c', ['n', 'v', 'i', 't'])

" horizontally split current buffer
call s:tmux_bind_key('"', ':spl<cr>', ['n', 'v', 'i', 't'])

" <c-a>w list open buffers
call s:tmux_bind_key('w', ':buffers<cr>', ['n', 'v', 'i', 't'])

" <c-a>o cycle through open windows
call s:tmux_bind_key('o', '<c-w>w', ['n', 'v', 'i', 't'])

" <c-a>N (where N is number key) switch to buffer N
for i in [1, 2, 3, 4, 5, 6, 7, 8, 9]
  call s:tmux_bind_key(i, ':b'.i.'<cr>', ['n', 'v', 'i', 't'])
endfor

" <c-a>n switch to next buffer
call s:tmux_bind_key('n', ':bn<cr>', ['n', 'v', 'i', 't'])

" <c-a>p switch to previous buffer
call s:tmux_bind_key('p', ':bp<cr>', ['n', 'v', 'i', 't'])

" <c-a>x write and close current buffer
call s:tmux_bind_key('x', ':x<cr>', ['n', 'v', 'i'])

" <c-a>X close current buffer (no write)
call s:tmux_bind_key('X', ':bd %<cr>', ['n', 'v', 'i'])

" <c-a>] paste
call s:tmux_bind_key(']', 'pa', ['n', 'v', 'i', 't'])

" <c-a>k close the current window
call s:tmux_bind_key('k', '<c-w>c', ['n', 'v', 'i', 't'])

" <c-a>; switch to previous window
call s:tmux_bind_key(';', '<c-w>p', ['n', 'v', 'i', 't'])

" <c-a>: enter command mode
call s:tmux_bind_key(':', ':', ['t'])

" <c-a>[ enter visual mode
call s:tmux_bind_key('[', 'v', ['t'])

" <c-a>H <c-a>J <c-a>K <c-a>L resize window
call s:tmux_bind_key('H', '<c-w><', ['n', 'v', 'i', 't'])
call s:tmux_bind_key('L', '<c-w>>', ['n', 'v', 'i', 't'])
call s:tmux_bind_key('J', '<c-w>+', ['n', 'v', 'i', 't'])
call s:tmux_bind_key('K', '<c-w>-', ['n', 'v', 'i', 't'])
