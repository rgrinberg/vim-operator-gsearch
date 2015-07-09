" default values for settings {{{
if !exists("g:gsearch_ag_command")
  let g:gsearch_ag_command = 'Ag! -Q'
endif

if !exists("g:gsearch_ack_command")
  let g:gsearch_ack_command = 'Ack! -Q'
endif

if !exists("g:gsearch_ctrlsf_command")
  let g:gsearch_ctrlsf_command = 'CtrlSF'
endif
"}}}
" operators {{{
function! operator#gsearch#ggrep(motion_wise)
  call s:search_cmd_quote('Ggrep', a:motion_wise)
endfunction

function! operator#gsearch#ag_word(motion_wise)
  call s:search_cmd_quote(g:gsearch_ag_command . ' -w', a:motion_wise)
endfunction

function! operator#gsearch#ag(motion_wise)
  call s:search_cmd_quote(g:gsearch_ag_command, a:motion_wise)
endfunction

function! operator#gsearch#ack(motion_wise)
  call s:search_cmd_quote(g:gsearch_ack_command, a:motion_wise)
endfunction

function! operator#gsearch#ctrlsf(motion_wise)
  call s:search_cmd_quote(g:gsearch_ctrlsf_command, a:motion_wise)
endfunction

function! operator#gsearch#dash(motion_wise)
  call s:search_cmd('Dash', a:motion_wise)
endfunction

function! operator#gsearch#helpgrep(motion_wise)
  call s:search_cmd('helpgrep', a:motion_wise)
endfunction
"}}}
" internal {{{
function! s:search_cmd_quote(cmd, motion_wise)
  execute a:cmd . ' ' . s:ag_quote(s:operator_sel(a:motion_wise))
endfunction

function! s:search_cmd(cmd, motion_wise)
  execute a:cmd . ' ' . fnameescape(s:operator_sel(a:motion_wise))
endfunction

function! s:operator_sel(motion_wise)
  let v = operator#user#visual_command_from_wise_name(a:motion_wise)
  let [save_reg_k, save_regtype_k] = [getreg('k'), getregtype('k')]
  try
    execute 'normal!' '`[' . v . '`]"ky'
    " return s:get_visual_selection()
    return getreg('k')
  finally
    call setreg('k', save_reg_k, save_regtype_k)
  endtry
endfunction

" Stolen from: http://stackoverflow.com/questions/1533565/how-to-get-visually-selected-text-in-vimscript
" currently not used as we are pasting to a random register instead
function! s:get_visual_selection()
  let [lnum1, col1] = getpos("'<")[1:2]
  let [lnum2, col2] = getpos("'>")[1:2]
  let lines = getline(lnum1, lnum2)
  let lines[-1] = lines[-1][: col2 - (&selection == 'inclusive' ? 1 : 2)]
  let lines[0] = lines[0][col1 - 1:]
  return join(lines, "\n")
endfunction
"}}}

function! s:ag_quote(str)
  " This was old escaping mechanism
  " return shellescape(fnameescape(str))
  return escape(fnameescape(escape(a:str, '#%')), '()')
endfunction
