set background=dark

colorscheme apprentice

set mouse=a " enable mouse usage (all modes)
set mousehide

if !has('nvim') && has("mouse_sgr")
  set ttymouse=sgr
endif

augroup HighlightTODO
  " ensure any instance TODO or FIXME is highlighted as an Error in any filetype
  autocmd!
  autocmd WinEnter,VimEnter * :silent! call matchadd('Error', 'TODO', -1)
  autocmd WinEnter,VimEnter * :silent! call matchadd('Error', 'FIXME', -1)
augroup END

highlight Comment cterm=italic

" gnome-terminal colors
if &term =~ '^\(xterm\|screen\)$' && $COLORTERM == 'gnome-terminal'
  set t_Co=256
endif

if exists("neovim_dot_app")
  call MacSetFont("Hasklig", 11)
elseif has("gui_running")
  if has("gui_macvim")
    set transparency=0
    set guifont=Inconsolata\ for\ Powerline:h12
  elseif has("gui_gtk")
    set guifont=Inconsolata\ for\ Powerline\ Medium\ 10
  endif
elseif $TERM_PROGRAM == "iTerm.app"
  " different cursors for insert vs normal mode
  if exists("$TMUX")
    let &t_SI = "\<Esc>[3 q"
    let &t_EI = "\<Esc>[0 q"
  else
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
  endif
endif

" fix arrow keys in terminal vim in insert mode
" if &term[:4] == "xterm" || &term[:5] == 'screen' || &term[:3] == 'rxvt'
"   inoremap <silent> <c-[>OC <right>
" endif
