# MiohitoKiri's neoVim config files

> These config file can **only** work on neoVim, vim user may have some plugin invalid.

## Screenshots

![](https://i.imgur.com/WBUwZ0C.jpg)
![](https://i.imgur.com/xuc4mUX.png)

## Plugins

### Plugin Manager

 - [junejunn/vim-plug](https://github.com/junegunn/vim-plug)

### airline

 - [vim-airline/vim-airline](https://github.com/vim-airline/vim-airline)
 - [vim-airline/vim-airline-themes](https://github.com/vim-airline/vim-airline-themes)


### fzf

 - [junegunn/fzf](https://github.com/junegunn/fzf)
 - [junegunn/fzf.vim](https://github.com/junegunn/fzf.vim)


### tag

 - [vim-scropts/taglist.vim](https://github.com/vim-scripts/taglist.vim)
 - [preservim/tagbar](https://github.com/preservim/tagbar)


### git-support

 - [motemem/git-vim](https://github.com/motemen/git-vim)
 - [airblade/vim-gitgutter](https://github.com/airblade/vim-gitgutter)


### auto completion & lsp

 - [neovim/nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)
 - [nvim-lua/completion-nvim](https://github.com/nvim-lua/completion-nvim)
 - [nvim-lua/lsp-status.nvim](https://github.com/nvim-lua/lsp-status.nvim)


### something else

Nert tree
 - [Shouge/defx.nvim](https://github.com/Shougo/defx.nvim)

Golang support
 - [fatih/vim-go](https://github.com/fatih/vim-go)

Goyo
 -[junegunn/goyo.vim](https://github.com/junegunn/goyo.vim)

Color Theme
 - [dracula/vim](https://github.com/dracula/vim)
 - [frazrepo/vim-rainbow](https://github.com/frazrepo/vim-rainbow)


## How Deploy

1. Install neoVim nightly, python3 and pip3

```sh
# On macOS
brew install --HEAD neovim
brew install python3 pip3
# On Archlinux, with AUR
yay -S neovim-nightly
sudo pacman -Sy python3 pip3
```

2. neoVim Python3 Support
Using pip3 install pynvim
```sh
pip3 install pynvim
```

2. Clone this repo to `~/.config`
```sh
git clone https://github.com/MiohitoKiri5474/nvim.git ~/.config/nvim
```

3. vim-plug upgrade, plugin install & update and make remote contorl work
```sh
vim +PlugUpgrade +PlugInstall +PlugUpdate +qa
vim +UpdateRemotePlugins +qa
```


... or using the shell script in this repo after installed neoVim, python3 and pip3
```sh
./setup.sh
```
