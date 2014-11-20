Bundle 'rking/ag.vim'

Bundle 'vim-scripts/bufexplorer.zip'

Bundle 'scrooloose/nerdcommenter'

Bundle 'scrooloose/syntastic'
  let g:syntastic_enable_signs=1
  let g:syntastic_quiet_messages = {'level': 'warnings'}
  let g:syntastic_disabled_filetypes = ['sass']
Bundle 'sjl/vim-sparkup'

Bundle 'kien/ctrlp.vim'
  set wildignore+=*/vendor/*,*/tmp/*,*/node_modules/*,*/bower_components/*
  map <Leader>b :CtrlPBuffer<CR>
  map <Leader>cpc :CtrlPClearCache<CR>

Bundle 'tpope/vim-repeat'

Bundle 'scrooloose/nerdtree'
  let NERDTreeHijackNetrw = 0
  let NERDTreeIgnore=['\.rbc$', '\~$']
  map <Leader>nt :NERDTreeToggle<CR>

Bundle 'tpope/vim-surround'
  let g:surround_35 = "#{\r}"
  let g:surround_45 = "<% \r %>"
  let g:surround_61 = "<%= \r %>"

" Javascript
Bundle 'kchmck/vim-coffee-script'
  au BufNewFile,BufRead *.coffee set filetype=coffee

Bundle 'AndrewRadev/vim-eco'

" Git
Bundle 'airblade/vim-gitgutter'

" Rails
Bundle 'tpope/vim-rails'
