let mapleader=","

set nocompatible
filetype off

set rtp+=~/.vim/vundle/
call vundle#begin()

runtime! plugins.vim

call vundle#end()

set number
set ruler

" Set encoding
set encoding=utf-8

" Highlight current line
au BufEnter * setlocal cursorline
au BufLeave * setlocal nocursorline
au BufLeave * setlocal colorcolumn=0

" Whitespace stuff
set nowrap
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set list listchars=tab:\ \ ,trail:·

" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

" Tab completion
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.class,.svn,vendor/gems/*,*/target/**

" Status bar
set laststatus=2

" CTags
map <Leader>rt :!ctags --extra=+f -R *<CR><CR>
map <C-\> :tnext<CR>

" Local vimrc configuration
let g:localvimrc_sandbox=0
let g:localvimrc_ask=0

nnoremap <silent> <leader>bd :Kwbd<CR>

" % to bounce from do to end etc.
runtime! macros/matchit.vim

" Searching
" open up a git grep line, with a quote started for the search
nnoremap <leader>gg :GitGrep 
nnoremap <leader>ag :Ag 

" copy current filename into system clipboard - mnemonic: (c)urrent(f)ilename
nnoremap <silent> <leader>cf :let @* = expand("%:~")<CR>

" Remember last location in file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif
endif

function s:setupWrapping()
  set wrap
  set wm=2
  set textwidth=72
endfunction

function s:setupMarkup()
  "call s:setupWrapping()
  set spell
endfunction

" make and python use real tabs
au FileType make                                     set noexpandtab

" Thorfile, Rakefile and Gemfile are Ruby
au BufRead,BufNewFile {Gemfile,Rakefile,Thorfile,config.ru}    set ft=ruby

"set json as javascript file type
au BufNewFile,BufRead *.json set ft=javascript

" md, markdown, and mk are markdown and define buffer-local preview
au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn} call s:setupMarkup()

" au BufRead,BufNewFile *.txt call s:setupWrapping()

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" Opens an edit command with the path of the currently edited file filled in
" Normal mode: <Leader>e
map <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

" Opens a tab edit command with the path of the currently edited file filled in
" Normal mode: <Leader>t
map <Leader>te :tabe <C-R>=expand("%:p:h") . "/" <CR>

" Inserts the path of the currently edited file into a command
" Command mode: Ctrl+P
cmap <C-P> <C-R>=expand("%:p:h") . "/" <CR>

" Unimpaired configuration
" Bubble single lines
nmap <C-Up> [e
nmap <C-Down> ]e
" Bubble multiple lines
vmap <C-Up> [egv
vmap <C-Down> ]egv

" Use modeline overrides
set modeline
set modelines=10

set autoindent

" Default color scheme
set background=dark

" Directories for swp files
set directory=/tmp/

" MacVIM shift+arrow-keys behavior (required in .vimrc)
let macvim_hig_shift_movement = 1

syntax on
filetype plugin indent on

let g:user_zen_expandabbr_key = '<D-e>' 

"handy mapping for vertical split windows
map <leader>v :vsplit <cr>

" Easier split navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

"re-select after indenting
vnoremap < <gv
vnoremap > >gv

" Map the escape key to 
inoremap jj <Esc>
inoremap jk <Esc>

"remove search hilighting
set nohlsearch
noremap <silent><Leader>/ :noh <CR>
nnoremap <leader><space> :noh<cr>

" make vim regexs behave like normal regexes
nnoremap / /\v
vnoremap / /\v

noremap <F1> <Esc>

"mappings for working with buffers
noremap <C-n> :bn <Enter>
noremap <C-p> :bp <Enter>
noremap <leader>c :enew <Enter>

"Mappings for working with buffers
noremap <leader>n :bn <Enter>
noremap <leader>p :bp <Enter>
noremap <leader>l :ls <Enter>
noremap <leader>c :enew <Enter>
set hidden

"Customization of ctrl-p plugin
noremap <leader>t :CtrlP <Enter>
let g:ctrlp_working_path_mode = 2

"Handy text processing commands
command TrimWhiteSpace %s/\s\+$//
command TitleCase s/\<\(\w\)\(\w*\)\>/\u\1\L\2/g

"Automatically remove trailing whitespace
autocmd FileType ruby,python,javascript,java autocmd BufWritePre <buffer> :%s/\s\+$//e

"Handy mapping to cd to current files directory
noremap <leader>cd :cd %:p:h <Enter>

"Automatically read file changes from disk
set autoread

"Turn off the any audible or visual bell
set vb t_vb=

" With the following mapping a user can press F5 to delete all trailing whitespace.
" The variable _s is used to save and restore the last search pattern register
" (so next time the user presses n they will continue their last search),
" and :nohl is used to switch off search highlighting (so trailing spaces will not be highlighted while the user types).
" The e flag is used in the substitute command so no error is shown if trailing whitespace is not found.
" Unlike before, the substitution text must be specified in order to use the required flag.
nnoremap <silent> <Leader>ws :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>

" Find the related spec for any file you open. Requires
"  * Your specs live in spec/ or fast_spec/
"  * Your pwd (current dir) is the project root
"  * You use the same dir structure in your code and specs so that
"    code living at lib/foo/bar.rb has a spec at spec/lib/foo/bar.rb
"
" This method handles files in fast_spec unlike the :A and :AV functions
" that ship with rails.vim
function! FindSpec()
  let s:fullpath = expand("%:p")
  let s:filepath = expand("%:h")
  let s:fname = expand("%:t")

  " Possible names for the spec/test for the file we're looking at
  let s:test_names = [substitute(s:fname, ".rb$", "_spec.rb", ""), substitute(s:fname, ".rb$", "_test.rb", "")]

  " Possible paths
  let s:test_paths = ["spec", "fast_spec", "test"]
  for test_name in s:test_names
    for path in s:test_paths
      let s:filepath_without_app = substitute(s:filepath, "app/", "", "")
      let s:spec_path = path . "/" . s:filepath_without_app . "/" . test_name
      let s:full_spec_path = substitute(s:fullpath, s:filepath . "/" . s:fname, s:spec_path, "")
      if filereadable(s:full_spec_path)
        execute ":botright vsp " . s:full_spec_path
        return
      endif
    endfor
  endfor
endfunction

nnoremap <C-s> :call FindSpec()<CR>

" Make working with wrap easier
noremap <silent> <Leader>w :call ChooseWrap()<CR>
function ChooseWrap()
  let l:choice=confirm("Toggle Wrapping?", "&yes\n&no", 0)
  if l:choice==1
    if &wrap
      call DisableDisplayWrapping()
    else
      call EnableDisplayWrapping()
    endif
  endif
endfunction

function EnableDisplayWrapping()
  if !&wrap
    setlocal wrap
    " don't skip wrapped lines
    nnoremap j gj
    nnoremap k gk
    vnoremap j gj
    vnoremap k gk
    nnoremap <buffer> <Up> gk
    nnoremap <buffer> <Down> gj
    inoremap <buffer> <Up> <C-O>gk
    inoremap <buffer> <Down> <C-O>gj
    vnoremap <buffer> <Up> gk
    vnoremap <buffer> <Down> gj
  endif
endfunction

function DisableDisplayWrapping()
  if &wrap
    setlocal nowrap
    nunmap j
    nunmap k
    vunmap j
    vunmap k
    nunmap <buffer> <Up>
    nunmap <buffer> <Down>
    iunmap <buffer> <Up>
    iunmap <buffer> <Down>
    vunmap <buffer> <Up>
    vunmap <buffer> <Down>
  endif
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PROMOTE VARIABLE TO RSPEC LET
" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! PromoteToLet()
  :normal! dd
  " :exec '?^\s*it\>'
  :normal! P
  :.s/\(\w\+\) = \(.*\)$/let(:\1) { \2 }/
  :normal ==
endfunction
:command! PromoteToLet :call PromoteToLet()
:map <leader>pl :PromoteToLet<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Test-running stuff
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <Leader>r :call RunCurrentTest()<CR>
function! RunCurrentTest()
  let in_test_file = match(expand("%"), '\(.feature\|_spec.rb\|_test.rb\)$') != -1
  if in_test_file
    call SetTestFile()

    if match(expand('%'), '\.feature$') != -1
      call SetTestRunner("!zeus cucumber")
      exec g:bjo_test_runner g:bjo_test_file
    elseif match(expand('%'), '_spec\.rb$') != -1
      call SetTestRunner("!zeus rspec")
      exec g:bjo_test_runner g:bjo_test_file
    else
      call SetTestRunner("!ruby -Itest")
      exec g:bjo_test_runner g:bjo_test_file
    endif
  else
    exec g:bjo_test_runner g:bjo_test_file
  endif
endfunction

function! SetTestRunner(runner)
  let g:bjo_test_runner=a:runner
endfunction

function! RunCurrentLineInTest()
  let in_test_file = match(expand("%"), '\(.feature\|_spec.rb\|_test.rb\)$') != -1
  if in_test_file
    call SetTestFileWithLine()
  end

  exec "!zeus rspec" g:bjo_test_file . ":" . g:bjo_test_file_line
endfunction

function! SetTestFile()
  let g:bjo_test_file=@%
endfunction

function! SetTestFileWithLine()
  let g:bjo_test_file=@%
  let g:bjo_test_file_line=line(".")
endfunction

function! CorrectTestRunner()
  if match(expand('%'), '\.feature$') != -1
    return "cucumber"
  elseif match(expand('%'), '_spec\.rb$') != -1
    return "rspec"
  else
    return "ruby"
  endif
endfunction
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
