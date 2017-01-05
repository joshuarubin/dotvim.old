nnoremap <silent> <leader>n :silent :nohlsearch<cr>

" find merge conflict markers
noremap <leader>fc /\v^[<\|=>]{7}( .*\|$)<cr>

" <leader>``: Force quit all
nnoremap <leader>`` :qa!<cr>

" <leader>q: Quit all, very useful in vimdiff
nnoremap <leader>q :qa<cr>

" <leader>cd: Switch to the directory of the open buffer
nnoremap <leader>cd :lcd %:p:h<cr>:pwd<cr>

" <leader>m: Maximize current split
nnoremap <leader>m <c-w>_<c-w><bar>

" <leader>,: Switch to previous split
nnoremap <leader>, <c-w>p

" adjust viewports to the same size
noremap <leader>= <c-w>=

" formatting shortcuts
nnoremap <leader>fef :call rubix#preserve('normal gg=G')<cr>
nnoremap <leader>f$ :call rubix#trim()<cr>
vnoremap <leader>s :sort<cr>

nnoremap <leader>w :w<cr>

cnoremap <c-j> <down>
cnoremap <c-k> <up>
cnoremap <c-f> <left>
cnoremap <c-g> <right>

" ctrl-v: Paste
cnoremap <c-v> <c-r>"

" Q: Closes the window
nnoremap Q :q<cr>

" W: Save
nnoremap W :w<cr>

" J: join without the cursor jumping around
" nnoremap J mzJ`z

" j, k: move up and down by row (of a wrapped line), not line
" nnoremap j gj
" nnoremap k gk

" Y: yank from the cursor to the end of the line (like D and C)
nnoremap Y y$

" U: Redos since 'u' undos
nnoremap U :redo<cr>

" _ : Quick horizontal splits
nnoremap <silent> _ :sp<cr>

" | : Quick vertical splits
nnoremap <silent> <bar> :vsp<cr>

" +/-: Increment number
nnoremap + <c-a>
nnoremap - <c-x>

" ctrl-sr: Easier (s)earch and (r)eplace
nnoremap <c-s><c-r> :%s/<c-r><c-w>//gc<left><left><left>

" ctrl-w: Delete previous word, create undo point
inoremap <c-w> <c-g>u<c-w>

" ctrl-s: Save
inoremap <c-s> <esc>:w<cr>

inoremap <expr> <down> pumvisible() ? "\<c-n>" : "\<down>"
inoremap <expr> <up>   pumvisible() ? "\<c-p>" : "\<up>"

" ctrl-c: Inserts line below
inoremap <c-c> <c-o>o

" ctrl-v: Paste. For some reason, <c-o> is not creating an undo point in the mapping
inoremap <c-v> <c-g>u<c-o>gP

" ctrl-c: copy (works with system clipboard due to clipboard setting)
vnoremap <c-c> y`]

" d: Delete into the blackhole register to not clobber the last yank
nnoremap d "_d

" dd: I use this often to yank a single line, retain its original behavior
nnoremap dd dd

" gp to visually select pasted text
nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'

" c: Change into the blackhole register to not clobber the last yank
nnoremap c "_c

" y: Yank and go to end of selection
xnoremap y y`]

" p: Paste in visual mode should not replace the default register with the deleted text
xnoremap p "_dP

" d: Delete into the blackhole register to not clobber the last yank. To 'cut', use 'x' instead
xnoremap d "_d

" enter: Highlight visual selections
xnoremap <silent> <cr> y:let @/ = @"<cr>:set hlsearch<cr>

" backspace: Delete selected and go into insert mode
xnoremap <bs> c

" <|>: Reselect visual block after indent
xnoremap < <gv
xnoremap > >gv

" .: repeats the last command on every line
xnoremap . :normal.<cr>

" @: repeats macro on every line
xnoremap @ :normal@

" tab: Indent (allow recursive)
xmap <tab> >

" shift-tab: unindent (allow recursive)
xmap <s-tab> <

" ctrl-a r to redraw the screen now
noremap <silent> <c-a>r :redraw!<cr>

" ctrl-w to delete the current buffer without closing the window
nnoremap <silent> <c-w><c-w> :confirm :Kwbd<cr>

" scrolling in insert mode
inoremap <c-d> <s-down>
inoremap <c-u> <s-up>
inoremap <c-e> <c-x><c-e>
inoremap <c-y> <c-x><c-y>

" plugin specific mappings

" dispatch
nnoremap <silent> <leader>k :Make<cr>

" surround
" ctrl-sw: Quickly surround word (must be recursive)
nmap <c-s><c-w> ysiw

" dash (must be recursive)
nmap <silent> <leader>d <plug>DashSearch

" undotree
nnoremap <leader>u :UndotreeToggle<cr>

" gitgutter
nnoremap <silent> <leader>gg :GitGutterToggle<cr>

" bufsurf
nnoremap <silent> Z :BufSurfBack<cr>
nnoremap <silent> X :BufSurfForward<cr>

" vimpager
nnoremap <silent> <leader>v :Page<cr>

" tagbar
nnoremap <silent> <leader>t :TagbarToggle<cr>
nnoremap <silent> <leader>2 :TagbarToggle<cr>

" tabularize
nnoremap <leader>a&     :Tabularize /&<cr>
vnoremap <leader>a&     :Tabularize /&<cr>
nnoremap <leader>a=     :Tabularize /=<cr>
vnoremap <leader>a=     :Tabularize /=<cr>
nnoremap <leader>a:     :Tabularize /:<cr>
vnoremap <leader>a:     :Tabularize /:<cr>
nnoremap <leader>a::    :Tabularize /:\zs<cr>
vnoremap <leader>a::    :Tabularize /:\zs<cr>
nnoremap <leader>a,     :Tabularize /,<cr>
vnoremap <leader>a,     :Tabularize /,<cr>
nnoremap <leader>a,,    :Tabularize /,\zs<cr>
vnoremap <leader>a,,    :Tabularize /,\zs<cr>
nnoremap <leader>a<bar> :Tabularize /<bar><cr>
vnoremap <leader>a<bar> :Tabularize /<bar><cr>
nnoremap <leader>a\|    :Tabularize /\|<cr>
vnoremap <leader>a\|    :Tabularize /\|<cr>
nnoremap <leader>a#     :Tabularize /#<cr>
vnoremap <leader>a#     :Tabularize /#<cr>

" fugitive/gitv
nnoremap <silent> <leader>gs :Gstatus<cr>
nnoremap <silent> <leader>gd :Gvdiff<cr>
nnoremap <silent> <leader>gc :Gcommit<cr>
nnoremap <silent> <leader>gb :Gblame<cr>
nnoremap <silent> <leader>gl :Glog<cr>
nnoremap <silent> <leader>gp :Gpush<cr>
nnoremap <silent> <leader>gr :Gremove<cr>
nnoremap <silent> <leader>gw :Gwrite<cr>
nnoremap <silent> <leader>ge :Gedit<cr>
nnoremap <silent> <leader>gm :Gmove<cr>
nnoremap <silent> <leader>g. :Gcd<cr>:pwd<cr>
nnoremap <silent> <leader>gu :Gpull<cr>
nnoremap <silent> <leader>gn :Gmerge<cr>
nnoremap <silent> <leader>gf :Gfetch<cr>
nnoremap <silent> <leader>gv :Gitv<cr>
nnoremap <silent> <leader>gV :Gitv!<cr>

if g:rubix_complete == 'neocomplete'
  imap <expr> <c-g> neocomplete#undo_completion()
endif

if g:rubix_complete == 'deoplete'
  imap <expr> <c-g> deoplete#undo_completion()
endif

if g:rubix_snippet == 'neosnippet'
  imap <expr> <c-k> neosnippet#expandable_or_jumpable() ? "\<plug>(neosnippet_expand_or_jump)" : "\<esc>\<c-w>k"
  smap <expr> <c-k> neosnippet#expandable_or_jumpable() ? "\<plug>(neosnippet_expand_or_jump)" : "\<c-w>k"
  smap <expr> <tab> neosnippet#expandable_or_jumpable() ? "\<plug>(neosnippet_expand_or_jump)" : "\<tab>"
  imap <expr> <tab> pumvisible() ? "\<c-n>" : (neosnippet#expandable_or_jumpable() ? "\<plug>(neosnippet_expand_or_jump)" : "\<tab>")
  imap <expr> <s-tab> pumvisible() ? "\<c-p>" : "\<tab>"
  imap <expr> <cr> rubix#neosnippet_cr()
endif

if g:rubix_snippet == 'ultisnips'
  smap <expr> <tab> rubix#ultisnips_tab()
  imap <expr> <tab> rubix#ultisnips_tab()
  imap <expr> <s-tab> pumvisible() ? "\<c-p>" : "\<tab>"
  imap <expr> <cr> rubix#ultisnips_cr()
endif

" snippets handle the <cr> mapping, but since all (2) endwise mappings were
" disabled, this restores the other one
imap <expr> <c-x><cr> "<plug>AlwaysEnd"

" tmux style navigation
if !exists("$TMUX")
  nnoremap <c-h> <c-w>h
  nnoremap <c-j> <c-w>j
  nnoremap <c-k> <c-w>k
  nnoremap <c-l> <c-w>l

  vnoremap <c-h> <c-w>h
  vnoremap <c-j> <c-w>j
  vnoremap <c-l> <c-w>l

  inoremap <c-h> <esc><c-w>h
  inoremap <c-j> <esc><c-w>j
  inoremap <c-l> <esc><c-w>l

  " <c-k> is also the snippet expand key,
  " only overwrite if it is not already set
  " and check for smap and xmap separately (from vmap)

  if maparg('<c-k>', 'x') == ''
    xnoremap <c-k> <c-w>k
  endif

  if maparg('<c-k>', 's') == ''
    snoremap <c-k> <c-w>k
  endif

  if maparg('<c-k>', 'i') == ''
    inoremap <c-k> <esc><c-w>k
  endif

  if has("nvim")
    tnoremap <c-h> <c-\><c-n><c-w>h
    tnoremap <c-j> <c-\><c-n><c-w>j
    tnoremap <c-k> <c-\><c-n><c-w>k
    tnoremap <c-l> <c-\><c-n><c-w>l
    tnoremap <c-y> <c-\><c-n><c-y>
    tnoremap <c-u> <c-\><c-n><c-u>

    " switch to insert mode and press <up> for shell history when in normal mode
    autocmd MyAutoCmd TermOpen term://* nnoremap <buffer> <up> i<up>
    autocmd MyAutoCmd TermOpen term://* nnoremap <buffer> <c-r> i<c-r>

    " disable macros in terminal windows
    autocmd MyAutoCmd TermOpen term://* nnoremap <buffer> q iq
  endif
endif

" fzf
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)
nnoremap <silent> <c-p> :FilesProjectDir<cr>
nnoremap <silent> <c-b> :Buffers<cr>
nnoremap <silent> <c-f> :History<cr>
nnoremap <silent> <c-s><c-a> :RgRepeat<cr>
nnoremap <silent> <c-s><c-s> :RgProjectDirCursor<cr>
nnoremap <silent> <c-s><c-d> :RgProjectDirPrompt<cr>
nnoremap <silent> <c-s><c-f> :BLines<cr>

" netrw
noremap <silent> <c-n> :call rubix#toggle_netrw()<cr>
