# Dotfiles

## Installation

Clone this repository

```sh
git clone https://github.com/pbollenbeck/dotfiles
```

Install homebrew

```sh
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

Install homebrew packages

```sh
brew bundle ~/projects/dotfiles/Brewfile
```

Install dotfiles

```sh
rcup -d ~/projects/dotfiles -x Brewfile -x README.md
```
