if exists('g:loaded_operator_search')
  finish
endif

call operator#user#define('ag',     'operator#gsearch#ag')
call operator#user#define('ack',    'operator#gsearch#ack')
call operator#user#define('ggrep',  'operator#gsearch#ggrep')
call operator#user#define('ctrlsf', 'operator#gsearch#ctrlsf')

let g:loaded_operator_search = 1
