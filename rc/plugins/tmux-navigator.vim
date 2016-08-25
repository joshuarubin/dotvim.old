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

  autocmd MyAutoCmd FileType vimfiler nnoremap <buffer> <c-l> :TmuxNavigateRight<cr>
  autocmd MyAutoCmd FileType vimfiler nnoremap <buffer> <c-j> :TmuxNavigateDown<cr>
else
  nnoremap <c-h> <c-w>h
  nnoremap <c-j> <c-w>j
  nnoremap <c-k> <c-w>k
  nnoremap <c-l> <c-w>l

  vnoremap <c-h> <c-w>h
  vnoremap <c-j> <c-w>j
  vnoremap <c-k> <c-w>k
  vnoremap <c-l> <c-w>l

  inoremap <c-h> <esc><c-w>h
  inoremap <c-j> <esc><c-w>j
  inoremap <c-k> <esc><c-w>k
  inoremap <c-l> <esc><c-w>l

  if has("nvim")
    tnoremap <c-h> <c-\><c-n><c-w>h
    tnoremap <c-j> <c-\><c-n><c-w>j
    tnoremap <c-k> <c-\><c-n><c-w>k
    tnoremap <c-l> <c-\><c-n><c-w>l

    " switch to insert mode when switching to terminals
    autocmd MyAutoCmd BufWinEnter,WinEnter term://* startinsert
    autocmd MyAutoCmd BufLeave term://* stopinsert
    autocmd MyAutoCmd TermOpen term://* set winfixheight

    " emulate tmux in neovim

    " <c-a>c opens a new tab
    " call s:tmux_bind_key('c', ':tabe\|terminal<cr>', ['n', 'v', 'i', 't'])
    call s:tmux_bind_key('c', ':tabnew<cr>', ['n', 'v', 'i', 't'])

    " <c-a>c opens a new horizontal split
    " call s:tmux_bind_key('s', ':split\|terminal<cr>', ['n', 'v', 'i', 't'])
    call s:tmux_bind_key('s', ':split<cr>', ['n', 'v', 'i', 't'])

    " <c-a>v opens a new vertical split
    " call s:tmux_bind_key('v', ':vsplit\|terminal<cr>', ['n', 'v', 'i', 't'])
    call s:tmux_bind_key('v', ':vsplit<cr>', ['n', 'v', 'i', 't'])

    " <c-a>t opens a terminal in the currentbuffer
    call s:tmux_bind_key('t', ':terminal<cr>', ['n', 'v', 'i'])

    " <c-a>a switches to the previous tab
    call s:tmux_bind_key('a', ':call LastTab()<cr>', ['n', 'v', 'i', 't'])

    " open the current buffer in a new tab
    call s:tmux_bind_key('!', ':tabe %<cr>', ['n', 'v', 'i', 't'])

    " vertically split current buffer
    call s:tmux_bind_key('%', ':vspl<cr>', ['n', 'v', 'i', 't'])

    " close the current tab
    call s:tmux_bind_key('&', ':tabclose<cr>', ['n', 'v', 'i', 't'])

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

    " <c-a>, rename tab
    call s:tmux_bind_key(',', ':call TabRename()<cr>', ['n', 'v', 'i', 't'])

    " <c-a>H <c-a>J <c-a>K <c-a>L resize window
    call s:tmux_bind_key('H', '<c-w><', ['n', 'v', 'i', 't'])
    call s:tmux_bind_key('L', '<c-w>>', ['n', 'v', 'i', 't'])
    call s:tmux_bind_key('J', '<c-w>+', ['n', 'v', 'i', 't'])
    call s:tmux_bind_key('K', '<c-w>-', ['n', 'v', 'i', 't'])
  endif

  autocmd MyAutoCmd FileType vimfiler nnoremap <buffer> <c-l> :wincmd l<cr>
  autocmd MyAutoCmd FileType vimfiler nnoremap <buffer> <c-j> :wincmd j<cr>
endif
