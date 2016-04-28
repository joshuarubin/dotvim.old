" search and display information from arbitrary sources like files, buffers, recently used files or registers, replaced kien/ctrlp.vim
NeoBundle "Shougo/unite.vim", {"vim_version": "7.3"}

if v:version < 703
  finish
endif

if neobundle#tap("unite.vim")
  function! neobundle#hooks.on_post_source(bundle)
    function! airline#extensions#unite#apply(...)
      if &ft == 'unite'
        call a:1.add_section('airline_a', ' Unite ')
        call a:1.add_section('airline_b', ' %{get(unite#get_context(), "buffer_name", "")} ')
        call a:1.add_section('airline_c', ' ')
        return 1
      endif
    endfunction

    hi link uniteInputPrompt Special

    "  \   'start_insert': 1,
    "  \   'update_time': 200,
    call unite#custom#profile("default", "context", {
      \   "prompt": "» ",
      \   "direction": "botright",
      \   "cursor_line_highlight": "PmenuSel",
      \ })

    call unite#custom#profile("source/grep", "context", {
      \ "buffer_name" : "grep",
      \ "no_quit" : 0
      \ })

    call unite#custom#profile("source/buffer", "context", {
      \ "buffer_name" : "buffers",
      \ "start_insert" : 1
      \ })

    call unite#custom#profile("source/tag", "context", {
      \ "buffer_name" : "tag",
      \ "start_insert" : 1,
      \ "resume" : 1,
      \ "input" : ""
      \ })

    call unite#custom#profile("source/file_mru", "context", {
      \ "buffer_name" : "mru",
      \ "start_insert" : 1
      \ })

    call unite#custom#profile("source/directory_mru", "context", {
      \ "buffer_name" : "dirs",
      \ "start_insert" : 1,
      \ "default_action" : "cd"
      \ })

    " set up some custom ignores
    call unite#custom_source("file_rec,file_rec/async,file_rec/neovim,file_mru,file,buffer,grep,directory",
      \ "ignore_pattern", join([
        \ '\.git/',
        \ '\.hg/',
        \ '\.svn/',
        \ '\.bzr/',
        \ '\.cdv/',
        \ '_darcs/',
        \ 'CVS/',
        \ 'RCS/',
        \ 'SCCS/',
        \ 'tmp/',
        \ '_build/',
        \ 'autom4te\.cache/',
        \ '\.sass-cache/',
        \ 'node_modules/',
        \ 'bower_components/',
        \ 'dist/',
        \ 'Godeps/',
        \ 'vendor/',
        \ '\~$',
        \ '#.+#$',
        \ '[._].*\.swp$',
        \ 'core\.\d+$',
        \ '\.pyc$',
        \ '\.exe$',
        \ '\.so$',
        \ '\.bak$',
        \ '\.png$',
        \ '\.jpg$',
        \ '\.jpeg$',
        \ '\.gif$',
        \ '\.zip$',
        \ '\.rar$',
        \ '\.tar$',
        \ '\.tar\.gz$',
        \ '\.tar\.bz2$',
        \ ], '\|')
    \ )

    " use the fuzzy matcher for everything
    call unite#filters#matcher_default#use(["matcher_fuzzy"])
    call unite#filters#sorter_default#use(["sorter_rank"])
    call unite#set_profile("files", "context.smartcase", 1)

    let s:file_recs = "file,directory,file_rec,file_rec/neovim,file_rec/async,tag"
    let s:sorter = has("ruby") ? "sorter_selecta" : "sorter_rank"

    call unite#custom#source("tag", "sorters", ["sorter_rank"])
    call unite#custom#source(s:file_recs, "sorters", [s:sorter])
    call unite#custom#source(s:file_recs, "matchers", ["converter_relative_word", "matcher_fuzzy"])
    call unite#custom#source("file_mru", "matchers", ["converter_relative_word", "matcher_fuzzy"])
  endfunction

  call neobundle#untap()
endif

NeoBundleLazy "osyo-manga/unite-airline_themes", {"autoload":{"unite_sources":"airline_themes"}}                                      " unite airline themes, duh
NeoBundleLazy "ujihisa/unite-colorscheme",       {"autoload":{"unite_sources":"colorscheme"}}                                         " unite plugin for changing your colorscheme
NeoBundleLazy "Shougo/unite-help",               {"autoload":{"unite_sources":"help"}}                                                " unite plugin for help
NeoBundleLazy "Shougo/unite-session",            {"autoload":{"unite_sources":["session","session/new"]}}                             " unite source which nominates sessions
NeoBundleLazy "thinca/vim-unite-history",        {"autoload":{"unite_sources":["history/command","history/search","history/yank"]}}   " unite source for history of command/search
NeoBundleLazy "Shougo/neossh.vim",               {"autoload":{"unite_sources":"ssh"}}                                                 " unite source which nominates files over ssh
NeoBundle     "Shougo/neomru.vim"                                                                                                     " unite.vim mru sources, depends on shougo/unite.vim
NeoBundle     "Shougo/unite-outline"                                                                                                  " unite source which provides the buffer with an outline view
NeoBundle     "tsukkee/unite-tag"                                                                                                     " unite plugin for selecting tags or selecting files including tags

" map space to the prefix for Unite
nnoremap [unite] <nop>
nmap <space> [unite]

" gb: quick buffer open
nmap gb [unite]s
nnoremap <silent> [unite]s :<c-u>Unite -quick-match buffer<cr>

" ctrl-p: Find files
nmap <c-p> [unite]p
" if has("nvim")
"   nnoremap <silent> [unite]p :<c-u>Unite -resume -buffer-name=project -auto-resize -no-restore -input= -start-insert -hide-source-names -unique file_rec/neovim:!<cr>
" else
  nnoremap <silent> [unite]p :<c-u>Unite -resume -buffer-name=project -auto-resize -no-restore -input= -start-insert -hide-source-names -unique file_rec/async:!<cr>
" endif

" [unite]f: Find files non-recursively with option to create new file
" nnoremap <silent> [unite]f :<c-u>Unite -resume -buffer-name=files -auto-resize -no-restore -input= -start-insert -hide-source-names -unique file file/new<cr>

" ctrl-b: Find buffers
nmap <c-b> [unite]b
nnoremap <silent> [unite]b :<c-u>Unite buffer<cr>

" ctrl-d: Change current (d)irectory
nmap <c-d> [unite]d
nnoremap <silent> [unite]d :<c-u>Unite -auto-resize directory_mru<cr>

" ctrl-\: Quick outline
nmap <silent> <c-\> [unite]o
nnoremap <silent> [unite]o :<c-u>Unite -buffer-name=outline -auto-highlight -vertical -winwidth=30 outline<cr>

" ctrl-sd: (S)earch word in current (d)irectory (prompt for word)
nmap <c-s><c-d> [unite]g
nmap [unite]/ [unite]g
nnoremap <silent> [unite]g :<c-u>Unite grep:.<cr>

" ctrl-ss: (S)earch word under cur(s)or in current directory
nmap <c-s><c-s> [unite]]
nnoremap <silent> [unite]] :<c-u>Unite grep:.::<c-r><c-w><cr>

" ctrl-sg: Reopen last grep window
nmap <c-s><c-g> [unite]G
nnoremap <silent> [unite]G :<c-u>UniteResume grep<cr>

" f1: Show help
" nmap <f1> [unite]h
" nnoremap <silent> [unite]h :<c-u>Unite -buffer-name=help -auto-resize help<cr>

" ctrl-sf: Quickly (s)earch in (f)ile
nmap <c-s><c-f> [unite]l
nnoremap <silent> [unite]l :<c-u>Unite -buffer-name=search_file -start-insert -auto-resize line<cr>

" ctrl-space: Quick scratch buffer
nmap <c-space> [unite]<space>
nnoremap <silent> [unite]<space> :<c-u>Unite -buffer-name=junk -start-insert -auto-resize junkfile junkfile/new<cr>

nnoremap <f4> :UniteSessionSave

" ctrl-f: Search MRU files
nmap <c-f> [unite]f
nnoremap <silent> [unite]f :<c-u>Unite -auto-resize file_mru<cr>

" nnoremap <silent> [unite]t :<c-u>Unite -input= tag<cr>
nnoremap <silent> [unite]a :<c-u>Unite -input= tag<cr>
nnoremap <silent> [unite]e :<c-u>Unite -buffer-name=register register<cr>
nnoremap <silent> [unite]y :<c-u>Unite -buffer-name=yank -start-insert history/yank<cr>
nnoremap <silent> [unite]m :<c-u>Unite -buffer-name=mappings -auto-resize -start-insert mapping<cr>
nnoremap <silent> [unite]; :<c-u>Unite -buffer-name=history -default-action=edit -start-insert history/command command<cr>
" nnoremap <silent> [unite]a :<c-u>Unite -buffer-name=airline_themes -winheight=10 -auto-preview airline_themes<cr>
nnoremap <silent> [unite]t :<c-u>Unite tab<cr>
nnoremap <silent> [unite]c :<c-u>Unite -buffer-name=colorschemes -winheight=10 -auto-preview colorscheme<cr>

" nnoremap <silent> [unite]p :<c-u>Unite -buffer-name=sessions session<cr>

let g:unite_data_directory=GetCacheDir("unite")
let g:unite_source_tag_max_fname_length = 70
let g:unite_source_history_yank_enable=1     " enable history yank source

let g:unite_source_file_mru_limit = 1000
let g:unite_source_file_mru_filename_format = ":~:."
let g:unite_source_file_mru_time_format = ""

if executable("ag")
  let g:unite_source_rec_async_command = ["ag", "--follow", "--nocolor", "--nogroup", "-g", ""]
endif

if executable("sift")
  let g:unite_source_grep_command = "sift"
  let g:unite_source_grep_default_opts = "--line-number --no-color --ignore-case --filename"
  let g:unite_source_grep_recursive_opt = "--recursive"
elseif executable("ag")
  let g:unite_source_grep_command = "ag"
  let g:unite_source_grep_default_opts = "--vimgrep"
  let g:unite_source_grep_recursive_opt = ""
endif

let g:unite_source_rec_max_cache_files = 99999

autocmd MyAutoCmd BufEnter *
\   if empty(&buftype)
\|    nnoremap <buffer> <c-]> :<c-u>UniteWithCursorWord -immediately tag<cr>
\| endif

" custom Unite settings
autocmd MyAutoCmd FileType unite call s:unite_settings()
function! s:unite_settings()  " {{{
  " escape to exit unite window
  nmap <buffer> <esc> <plug>(unite_exit)
  imap <buffer> <esc> <plug>(unite_exit)

  imap <buffer> <c-j> <plug>(unite_select_next_line)
  imap <buffer> <c-k> <plug>(unite_select_previous_line)

  nmap <buffer> <c-j> <plug>(unite_loop_cursor_down)
  nmap <buffer> <c-k> <plug>(unite_loop_cursor_up)

  nmap <buffer> <tab>   <plug>(unite_loop_cursor_down)
  nmap <buffer> <s-tab> <plug>(unite_loop_cursor_up)
  " imap <buffer> <e-a>   <plug>(unite_choose_action)
  imap <buffer> <tab>   <plug>(unite_insert_leave)
  imap <buffer> <c-w>   <plug>(unite_delete_backward_word)
  imap <buffer> <c-u>   <plug>(unite_delete_backward_path)
  imap <buffer> '       <plug>(unite_quick_match_default_action)
  nmap <buffer> '       <plug>(unite_quick_match_default_action)
  nmap <buffer> <c-r>   <plug>(unite_redraw)
  imap <buffer> <c-r>   <plug>(unite_redraw)

  inoremap <buffer> <expr> <c-d> unite#do_action("delete")
  nnoremap <buffer> <expr> <c-d> unite#do_action("delete")

  " open file in new window or tab
  inoremap <silent> <buffer> <expr> <c-s> unite#do_action("split")
  nnoremap <silent> <buffer> <expr> <c-s> unite#do_action("split")
  inoremap <silent> <buffer> <expr> <c-v> unite#do_action("vsplit")
  nnoremap <silent> <buffer> <expr> <c-v> unite#do_action("vsplit")

  let unite = unite#get_current_unite()
  if unite.buffer_name =~# "^search"
    nnoremap <silent> <buffer> <expr> r unite#do_action("replace")
  else
    nnoremap <silent> <buffer> <expr> r unite#do_action("rename")
  endif

  nnoremap <silent> <buffer> <expr> cd unite#do_action("lcd")

  " using Ctrl-\ to trigger outline, so close it using the same keystroke
  if unite.buffer_name =~# '^outline'
    imap <buffer> <c-\> <plug>(unite_exit)
  endif

  " using Ctrl-/ to trigger line, close it using same keystroke TODO(jrubin)
  "if unite.buffer_name =~# '^search_file'
  "  imap <buffer> <c-_> <plug>(unite_exit)
  "endif
endfunction
" }}}

let g:unite_source_session_enable_auto_save = 1
let g:unite_source_session_path = GetCacheDir("sessions")
