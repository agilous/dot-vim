installation
------------

* Clone git repo into home directory
* `mv dot-vim .vim`
* `cd ~/.vim`
* Run `git submodule init` and `git submodule update`
* `ln -s ~/.vim/vimrc ~/.vimrc`
* `ln -s ~/.vim/gvimrc ~/.gvimrc`

#### CTags
* download from [Sourceforge](http://sourceforge.net/projects/ctags/files/ctags/5.8/ctags-5.8.tar.gz/download?use_mirror=softlayer)
* `tar xzvf ctags-5.8.tar.gz`
* `cd ctags-5.8`
* `./configure`
* `make`
* `sudo make install`
* if there are any problems, read this: http://runtime-era.blogspot.com/2012/05/exuberant-ctags-in-osx-107.html

#### JSHint
* `brew install node`
* `curl https://npmjs.org/install.sh | sh`
* `npm install -g jshint`

customizations
--------------

* Comma is &lt;leader&gt;
* <leader>cf - copy current file's path. This is good for a testing workflow where you copy the spec file's path, go to the terminal, and paste in the path after an rspec command
* Command / - comment out current line or visually selected lines
* <leader>v - creates empty vertical split
* <leader>ws - removes trailing whitespace
* <leader>rt - generate ctags for current directory for find definition
* Control ] - go to definition
* Control s - split window and go to corresponding rspec file

plugin additions
----------------

### Control-P
* `cd ~/.vim`
* `git clone https://github.com/kien/ctrlp.vim.git bundle/ctrlp.vim`
* `git submodule add https://github.com/kien/ctrlp.vim.git bundle/ctrlp.vim`
* Command t - find file
* <leader>b - find file in open buffers
* <leader>cpc - refresh file buffer ("control-p clear")

### NERD Tree
* <leader>nt - open/close NERD tree

### Zoomwin
* <leader><leader> - set focus on current window/show all open windows

### Kwbd
* <leader>bd - close buffer without closing split window

### Git Grep
* <leader>gg - git grep search for input

### JSHint
* Saving js files with errors will show a red squiggle.
* Open the quickfix window (:copen|:cclose) to see the error and line number.
