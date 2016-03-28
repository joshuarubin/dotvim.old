nmap <leader>f0 :set foldlevel=0<cr>
nmap <leader>f1 :set foldlevel=1<cr>
nmap <leader>f2 :set foldlevel=2<cr>
nmap <leader>f3 :set foldlevel=3<cr>
nmap <leader>f4 :set foldlevel=4<cr>
nmap <leader>f5 :set foldlevel=5<cr>
nmap <leader>f6 :set foldlevel=6<cr>
nmap <leader>f7 :set foldlevel=7<cr>
nmap <leader>f8 :set foldlevel=8<cr>
nmap <leader>f9 :set foldlevel=9<cr>

nmap <silent> <leader>n :silent :nohlsearch<cr>

" find merge conflict markers
map <leader>fc /\v^[<\|=>]{7}( .*\|$)<cr>

" <leader>``: Force quit all
nnoremap <leader>`` :qa!<cr>

" <leader>0: Run the visually selected code in python and replace it with the output
" vnoremap <silent> <leader>0 :!python<cr>

" <leader>q: Quit all, very useful in vimdiff
nnoremap <leader>q :qa<cr>

" <leader>e: Fast editing of the .vimrc
" execute "nnoremap <leader>e :e!" . fnameescape($MYVIMRC) . "<cr>"

" <leader>o: only
"nnoremap <leader>o :only<cr>

" <leader>p: Copy the full path of the current file to the clipboard
nnoremap <silent> <leader>p :let @+=expand("%:p")<cr>:echo "Copied current file \ path '".expand("%:p")."' to clipboard"<cr>

" <leader>s: Spell checking shortcuts
nnoremap <leader>ss :setlocal spell!<cr>:echo "spell ="&spell<cr>
nnoremap <leader>sj ]s
nnoremap <leader>sk [s
nnoremap <leader>sa zg]s
nnoremap <leader>sd 1z=
nnoremap <leader>sf z=

" <leader>f: Open Quickfix
nnoremap <silent> <leader>f :botright copen<cr>

" <leader>cd: Switch to the directory of the open buffer
nnoremap <leader>cd :cd %:p:h<cr>:pwd<cr>

" <leader>m: Maximize current split
nnoremap <leader>m <c-w>_<c-w><bar>

" <leader>,: Switch to previous split
nnoremap <leader>, <c-w>p

" some helpers to edit mode
" http://vimcasts.org/e/14
" map <leader>ew :e %%
" map <leader>es :sp %%
" map <leader>ev :vsp %%
" map <leader>et :tabe %%

" adjust viewports to the same size
map <leader>= <c-w>=

" map <leader>ff to display all lines with keyword under cursor and ask which one to jump to
nmap <leader>ff [I:let nr = input("Which one: ")<bar>exe "normal " . nr ."[\t"<cr>

" formatting shortcuts
" TODO(jrubin) use mqHmwgg=G`wzt`q like `R` (Reindent) map?
nmap <leader>fef :call Preserve("normal gg=G")<cr>
nmap <leader>f$ :call StripTrailingWhitespace()<cr>
vmap <leader>s :sort<cr>

nnoremap <leader>w :w<cr>

" shortcuts for windows
nnoremap <leader>v <c-w>v
nnoremap <leader>s <c-w>s
nnoremap <leader>vsa :vert sba<cr>

" json
" nmap <leader>jt <esc>:%!python -m json.tool<cr><esc>:set filetype=json<cr>

" change working directory to that of the current file
" cmap cwd lcd %:p:h
" cmap cd. lcd %:p:h

" bash like keys for the command line. These resemble personal zsh mappings
cnoremap <c-a> <home>
cnoremap <c-e> <end>

" ctrl-[hl]: Move left/right by word
cnoremap <c-h> <s-left>
cnoremap <c-l> <s-right>

" ctrl-space: Show history TODO(jrubin)
"cnoremap <c-@> <c-f>

cnoremap <c-j> <down>
cnoremap <c-k> <up>
cnoremap <c-f> <left>
cnoremap <c-g> <right>

" ctrl-v: Paste
cnoremap <c-v> <c-r>"

" w!!: Writes using sudo
cnoremap w!! w !sudo tee % >/dev/null

" some helpers to edit mode
" http://vimcasts.org/e/14
cnoremap %% <c-r>=fnameescape(expand("%:h"))."/"<cr>

" Q: Closes the window
nnoremap Q :q<cr>

" W: Save
nnoremap W :w<cr>

" R: Reindent entire file TODO(jrubin) use Preserve()?
nnoremap R mqHmwgg=G`wzt`q

" Y: Remove join lines to this, Y looks like a join of two lines into one
"noremap Y J

" U: Redos since 'u' undos
nnoremap U :redo<cr>

" _ : Quick horizontal splits
nnoremap _ :sp<cr>

" | : Quick vertical splits
nnoremap <bar> :vsp<cr>

" H: Go to beginning of line.
"noremap H ^

"noremap L g_

" :: Remap to ,. After all the remapping, ; goes to command mode, . repeats
" fFtT, : repeats it backward, and , is the leader
"noremap : ,

" N: Find next occurrence backward
"nnoremap N Nzzzv

" +/-: Increment number
" nnoremap + <c-a>
" nnoremap - <c-x>

" ctrl-sr: Easier (s)earch and (r)eplace
nnoremap <c-s><c-r> :%s/<c-r><c-w>//gc<left><left><left>

" ctrl-z: Cycle through the splits. I don't ever use enough splits to justify
" wasting 4 very easy to hit keys for them.
"nnoremap <c-z> <c-w>w

" ctrl-b: Go (b)ack. Go to previous buffer
"nnoremap <c-b> <c-^>

" cycle through buffers with ctrl-f/g
" nmap <c-f> :bnext<cr>
" nmap <c-g> :bprev<cr>

" ctrl-h: Move word back. Consistent with zsh
"noremap <c-h> b
"inoremap <c-h> <c-o>b

" ctrl-l: Move word forward. Consistent with zsh
"noremap <c-l> w
"inoremap <c-l> <c-o>w

" ctrl-w: Delete previous word, create undo point
inoremap <c-w> <c-g>u<c-w>

" ctrl-e: Go to end of line
inoremap <c-e> <esc>A

" ctrl-u: Delete til beginning of line, create undo point
inoremap <c-u> <c-g>u<c-u>

" ctrl-a: Go to beginning of line
inoremap <c-a> <esc>I

" ctrl-s: Save
inoremap <c-s> <esc>:w<cr>

" ctrl-f: Move cursor left
inoremap <c-f> <Left>

" ctrl-g: Move cursor right
inoremap <c-g> <Right>

" ctrl-j: Move cursor up
"inoremap <expr> <c-j> pumvisible() ? "\<c-e>\<Down>" : "\<Down>"

" ctrl-k: Move cursor up
"inoremap <expr> <c-k> pumvisible() ? "\<c-e>\<Up>" : "\<Up>"

" inoremap <expr> <esc>  pumvisible() ? "\<c-e>" : "\<esc>"
inoremap <expr> <down> pumvisible() ? "\<c-n>" : "\<down>"
inoremap <expr> <up>   pumvisible() ? "\<c-p>" : "\<up>"

" ctrl-c: Inserts line below
inoremap <c-c> <c-o>o

" ctrl-v: Paste. For some reason, <c-o> is not creating an undo point in the mapping
inoremap <c-v> <c-g>u<c-o>gP

" ctrl-/: Undo TODO(jrubin)
"inoremap <c-_> <c-o>u

" ctrl-c: copy (works with system clipboard due to clipboard setting)
vnoremap <c-c> y`]

" ctrl-r: easier search and replace
" vnoremap <c-r> "hy:%s/<c-r>h//gc<left><left><left>

" ctrl-s: easier substitue
vnoremap <c-s> :s/\%v//g<left><left><left>

" p: Paste
"nnoremap p gp

" d: Delete into the blackhole register to not clobber the last yank
nnoremap d "_d

" dd: I use this often to yank a single line, retain its original behavior
nnoremap dd dd

" gp to visually select pasted text
nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'

" ;: Command mode
"noremap ; :

" c: Change into the blackhole register to not clobber the last yank
nnoremap c "_c

" Up Down Left Right resize splits
nnoremap <up>    <c-w>+
nnoremap <down>  <c-w>-
nnoremap <left>  <c-w><
nnoremap <right> <c-w>>

" tab: Go to matching element
nnoremap <tab> %

" sane regex
" nnoremap / /\v
" vnoremap / /\v
"
" nnoremap ? ?\v
" vnoremap ? ?\v
"
" nnoremap :s/ :s/\v

" command-line window
" nnoremap q: q:i
" nnoremap q/ q/i
" nnoremap q? q?i

" folds
nnoremap zr zr:echo &foldlevel<cr>
nnoremap zm zm:echo &foldlevel<cr>
nnoremap zR zR:echo &foldlevel<cr>
nnoremap zM zM:echo &foldlevel<cr>

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

" tab: Indent
xmap <tab> >

" shift-tab: unindent
xmap <s-tab> <

if has('nvim')
  " terminal mode mappings

  " esc to exit terminal mode
  tnoremap <esc> <c-\><c-n>
endif

" ctrl-a r to redraw the screen now
noremap <silent> <c-a>r :redraw!<cr>
