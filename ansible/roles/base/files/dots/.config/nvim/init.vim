call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-sensible'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'connorholyday/vim-snazzy'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'lilyinstarlight/vim-sonic-pi'
Plug 'preservim/nerdtree'
Plug 'https://github.com/jalvesaq/vimcmdline.git'
Plug 'ryanoasis/vim-devicons'
Plug 'https://github.com/chrisbra/unicode.vim.git'
Plug 'https://github.com/tpope/vim-surround.git'
Plug 'rktjmp/lush.nvim'
Plug 'https://github.com/nanotech/jellybeans.vim.git'
Plug 'tomasr/molokai'
Plug 'ecomba/vim-ruby-refactoring'
Plug 'liuchengxu/space-vim-dark'
Plug 'https://github.com/vim-scripts/AutoComplPop.git'

call plug#end()

let mapleader = ","
let localleader = "\\"

autocmd VimEnter * wincmd p

command! FR set filetype=ruby

set tabstop=2 softtabstop=2 expandtab shiftwidth=2 autoindent

au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
      let g:airline_symbols = {}
endif

let g:airline_symbols.space = "\ua0"
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 0
let g:airline_theme = 'powerlineish'

:set termguicolors
let g:Hexokinase_highlighters = [ 'virtual' ]


colorscheme molokai

set omnifunc=syntaxcomplete#Complete


function! OpenCompletion()
    if !pumvisible() && ((v:char >= 'a' && v:char <= 'z') || (v:char >= 'A' && v:char <= 'Z'))
        call feedkeys("\<C-x>\<C-o>")
    endif
endfunction

function! Smart_TabComplete()
  let line = getline('.')                         " current line

  let substr = strpart(line, -1, col('.')+1)      " from the start of the current
                                                  " line to one character right
                                                  " of the cursor
  let substr = matchstr(substr, "[^ \t]*$")       " word till cursor
  if (strlen(substr)==0)                          " nothing to match on empty string
    return "\<tab>"
  endif
  let has_period = match(substr, '\.') != -1      " position of period, if any
  let has_slash = match(substr, '\/') != -1       " position of slash, if any
  if (!has_period && !has_slash)
    return "\<C-X>\<C-P>"                         " existing text matching
  elseif ( has_slash )
    return "\<C-X>\<C-F>"                         " file matching
  else
    return "\<C-X>\<C-O>"                         " plugin matching
  endif
endfunction

inoremap <tab> <C-r>=Smart_TabComplete()<CR>



set clipboard+=unnamedplus

let g:sonic_pi_command = 'sonic-pi-tool'
let g:sonic_pi_check = 'check'
let g:sonic_pi_run = 'start-server'
let g:sonic_pi_eval = 'eval-stdin'
let g:sonic_pi_stop = 'stop'
let g:sonic_pi_logs = 'logs'
let g:sonic_pi_record = 'record'
let g:sonic_pi_autolog_enabled = 0
let g:sonic_pi_log_width = 30
let g:sonic_pi_enabled = 1
let g:vim_redraw = 1

nnoremap <A-Right> <C-w>l
nnoremap <A-Left> <C-w>h
nnoremap <A-Up> <C-w>k
nnoremap <A-Down> <C-w>j

let g:NERDTreeChDirMode=2
let g:NERDTreeIgnore=['\.rbc$', '\~$', '\.pyc$', '\.db$', '\.sqlite$', '__pycache__']
let g:NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$', '\.bak$', '\~$']
let g:NERDTreeShowBookmarks=1
let g:nerdtree_tabs_focus_on_files=1
let g:NERDTreeMapOpenInTabSilent = '<RightMouse>'
let g:NERDTreeWinSize = 50
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite
nnoremap <F2> :NERDTreeToggle<CR>
noremap <F3> :NERDTreeToggle<CR>


inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif


inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() :
      \ "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"


nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

let cmdline_app           = {}
let cmdline_app['ruby']   = 'pry'
let cmdline_app['sh']     = 'bash'
let cmdline_in_buffer = 1

let cmdline_map_start          = '<LocalLeader>s'
let cmdline_map_send           = '<Space>'
let cmdline_map_send_and_stay  = '<LocalLeader><Space>'
let cmdline_map_source_fun     = '<LocalLeader>f'
let cmdline_map_send_paragraph = '<LocalLeader>p'
let cmdline_map_send_block     = '<LocalLeader>b'
let cmdline_map_send_motion    = '<LocalLeader>m'
let cmdline_map_quit           = '<LocalLeader>q'

nnoremap <silent> <leader>e :call Fzf_dev()<CR>

if executable('rg')
  let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
  set grepprg=rg\ --vimgrep
  command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)
endif

function! Fzf_dev()
  let l:fzf_files_options = '--preview "bat --theme="OneHalfDark" --style=numbers,changes --color always {2..-1} | head -'.&lines.'"'

  function! s:files()
    let l:files = split(system($FZF_DEFAULT_COMMAND), '\n')
    return s:prepend_icon(l:files)
  endfunction

  function! s:prepend_icon(candidates)
    let l:result = []
    for l:candidate in a:candidates
      let l:filename = fnamemodify(l:candidate, ':p:t')
      let l:icon = WebDevIconsGetFileTypeSymbol(l:filename, isdirectory(l:filename))
      call add(l:result, printf('%s %s', l:icon, l:candidate))
    endfor

    return l:result
  endfunction

  function! s:edit_file(item)
    let l:pos = stridx(a:item, ' ')
    let l:file_path = a:item[pos+1:-1]
    execute 'silent e' l:file_path
  endfunction

  call fzf#run({
        \ 'source': <sid>files(),
        \ 'sink':   function('s:edit_file'),
        \ 'options': '-m ' . l:fzf_files_options,
        \ 'down':    '40%' })
endfunction
