let g:go_def_mapping_enabled = 1
let g:go_fmt_autosave = 1
let g:go_fmt_command = 'goimports'
let g:go_fmt_fail_silently = 1
let g:go_fmt_options = '-s '
let g:go_fmt_experimental = 0
let g:go_auto_type_info = 0
let g:go_auto_sameids = 0
let g:go_echo_command_info = 0

let g:go_list_height = 10
let g:go_def_mode = 'guru'
let g:go_def_reuse_buffer = 1

if $TERM_PROGRAM ==# 'Alacritty.app' || $TERM ==# 'xterm-kitty' || has('gui_running')
  if has('gui_running')
    let g:go_highlight_operators = 1
    let g:go_highlight_types = 1
  endif

  let g:go_highlight_fields = 1
  let g:go_highlight_functions = 1
  let g:go_highlight_methods = 1
  let g:go_highlight_build_constraints = 1
  let g:go_highlight_generate_tags = 1
  let g:go_highlight_array_whitespace_error = 1
  let g:go_highlight_chan_whitespace_error = 1
  let g:go_highlight_space_tab_error = 1
  let g:go_highlight_trailing_whitespace_error = 1
  let g:go_highlight_extra_types = 1
endif

let g:go_highlight_string_spellcheck = 1
let g:go_highlight_format_strings = 1

let g:go_snippet_engine = 'neosnippet'

let g:go_metalinter_enabled  = [
      \ 'deadcode',
      \ 'errcheck',
      \ 'gas',
      \ 'goconst',
      \ 'gofmt',
      \ 'goimports',
      \ 'golint',
      \ 'gosimple',
      \ 'gotype',
      \ 'ineffassign',
      \ 'interfacer',
      \ 'misspell',
      \ 'staticcheck',
      \ 'unconvert',
      \ 'unused',
      \ 'varcheck',
      \ 'vet',
      \ 'vetshadow',
\ ]
