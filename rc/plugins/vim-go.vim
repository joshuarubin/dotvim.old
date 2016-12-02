let g:go_def_mapping_enabled = 0
let g:go_fmt_command = "goimports"
let g:go_fmt_fail_silently = 1
let g:go_fmt_options = "-s "
let g:go_auto_type_info = 0
let g:go_fmt_experimental = 0
let g:go_doc_keywordprg_enabled = 0

let g:go_list_height = 10
let g:go_def_mode = "guru"
let g:go_def_reuse_buffer = 1

let g:go_highlight_operators = 0
let g:go_highlight_fields = 0
let g:go_highlight_types = 0
let g:go_highlight_functions = 0
let g:go_highlight_methods = 0
let g:go_highlight_build_constraints = 0
let g:go_highlight_generate_tags = 0

let g:go_highlight_array_whitespace_error = 1
let g:go_highlight_chan_whitespace_error = 1
let g:go_highlight_space_tab_error = 1
let g:go_highlight_trailing_whitespace_error = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_string_spellcheck = 1
let g:go_highlight_format_strings = 1
let g:go_snippet_engine = g:rubix_snippet

if has("nvim")
  let g:go_term_enabled = 1
else
  let g:go_dispatch_enabled = 1
endif

let g:go_metalinter_enabled  = [
\   'errcheck',
\   'misspell',
\   'unused',
\ ]

" run :GoBuild or :GoTestCompile based on the go file
function! BuildGoFiles()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#cmd#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

autocmd MyAutoCmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
autocmd MyAutoCmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
autocmd MyAutoCmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
autocmd MyAutoCmd Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')
