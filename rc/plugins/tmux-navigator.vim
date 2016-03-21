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

" seamless navigation between tmux panes and vim splits
if exists("$TMUX")
  NeoBundle "christoomey/vim-tmux-navigator"

  autocmd MyAutoCmd FileType vimfiler nmap <buffer> <c-l> :TmuxNavigateRight<cr>
  autocmd MyAutoCmd FileType vimfiler nmap <buffer> <c-j> :TmuxNavigateDown<cr>
else
  nmap <c-h> <c-w>h
  nmap <c-j> <c-w>j
  nmap <c-k> <c-w>k
  nmap <c-l> <c-w>l

  if has("nvim")
    tmap <c-h> <c-\><c-n><c-w>h
    tmap <c-j> <c-\><c-n><c-w>j
    tmap <c-k> <c-\><c-n><c-w>k
    tmap <c-l> <c-\><c-n><c-w>l

    " switch to insert mode when switching to terminals
    autocmd BufWinEnter,WinEnter term://* startinsert

    " emulate tmux in neovim

    " <c-a>c opens a terminal in a new tab
    call s:tmux_bind_key('c', ':tabe\|terminal<cr>', ['n', 'v', 'i', 't'])

    " <c-a>c opens a terminal in a new horizontal split
    call s:tmux_bind_key('s', ':split\|terminal<cr>', ['n', 'v', 'i', 't'])

    " <c-a>v opens a terminal in a new vertical split
    call s:tmux_bind_key('v', ':vsplit\|terminal<cr>', ['n', 'v', 'i', 't'])

    " <c-a>a switches to the previous window
    call s:tmux_bind_key('a', '<c-w><c-p>', ['n', 'v', 'i', 't'])

    " open the current buffer in a new tab
    call s:tmux_bind_key('!', ':tabe %<cr>', ['n', 'v', 'i', 't'])

    " vertically split current buffer
    call s:tmux_bind_key('%', ':vspl<cr>', ['n', 'v', 'i', 't'])

    " horizontally split current buffer
    call s:tmux_bind_key('"', ':spl<cr>', ['n', 'v', 'i', 't'])

    " <c-a>w list open tabs
    call s:tmux_bind_key('w', ':tabs<cr>', ['n', 'v', 'i', 't'])

    " <c-a>o cycle through open windows
    call s:tmux_bind_key('o', '<c-w>w', ['n', 'v', 'i', 't'])

    " <c-a>N (where N is number key) switch to tab N
    for i in [1, 2, 3, 4, 5, 6, 7, 8, 9]
      call s:tmux_bind_key(i, i.'gt', ['n', 'v', 'i', 't'])
    endfor

    " <c-a>n switch to next tab
    call s:tmux_bind_key('n', 'gt', ['n', 'v', 'i', 't'])

    " <c-a>p switch to previous tab
    call s:tmux_bind_key('p', 'gT', ['n', 'v', 'i', 't'])

    " <c-a>x write and close current buffer
    call s:tmux_bind_key('x', ':x<cr>', ['n', 'v', 'i'])

    " <c-a>X close current buffer (no write)
    call s:tmux_bind_key('X', ':bd %<cr>', ['n', 'v', 'i'])

    " <c-a>] paste
    call s:tmux_bind_key(']', 'pa', ['n', 'v', 'i', 't'])

    " <c-a>h switch to window to left
    call s:tmux_bind_key('h', '<c-w><c-h>', ['n', 'v', 'i', 't'])

    " <c-a>j switch to window below
    call s:tmux_bind_key('j', '<c-w><c-j>', ['n', 'v', 'i', 't'])

    " <c-a>k switch to window above
    call s:tmux_bind_key('k', '<c-w><c-k>', ['n', 'v', 'i', 't'])

    " <c-a>l switch to window to right
    call s:tmux_bind_key('l', '<c-w><c-l>', ['n', 'v', 'i', 't'])

    " <c-a>: enter command mode
    call s:tmux_bind_key(':', ':', ['t'])

    " <c-a>[ enter visual mode
    call s:tmux_bind_key('[', 'v', ['t'])
  endif

  autocmd MyAutoCmd FileType vimfiler nmap <buffer> <c-l> :wincmd l<cr>
  autocmd MyAutoCmd FileType vimfiler nmap <buffer> <c-j> :wincmd j<cr>
endif
