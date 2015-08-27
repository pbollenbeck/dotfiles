# Dotfiles

## Installation

Make sure project folder exists

```sh
mkdir -p ~/projects
cd ~/projects
```

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
brew tap homebrew/bundle
brew bundle
```

Install dotfiles

```sh
rcup -d ~/projects/dotfiles -x Brewfile -x README.md
```
