# my-environment 🕶 🍎 🚀

My custom environment: plugins and tools

## Terminal 💻

### iTerm2

```shell
brew cask install iterm2
```

Auto-Starting Tmux in iTerm2

- Send text at start:

```shell
# tmux attach -t <session name> || tmux new -s <session name>
tmux
```

### Brew

export brew

```shell
brew bundle dump
```

import

```shell
brew bundle
```

### Essential terminal improvements

Make your terminal more friendly:

- Install

```shell
brew install fortune cowsay
```

- Add the following line to the ~/.bash_profile or ~/.zshrc

```shell
fortune | cowsay
```

Have fun ✌🏼

### Oh My Zsh

Plugins: 

```sh
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
```

```sh
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
```

## VIM 

### Plug Manager

```shell
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

### Go Language Server

To enable Go language server in nvim-coc, you need to install the coc-go extension by running the following command in your terminal:

```shell
:CocInstall coc-go
```

### Check if everything is fine:

```shell
:checkhealth
```

## Go

[Staticcheck](https://github.com/dominikh/go-tools)

```shell
go install honnef.co/go/tools/cmd/staticcheck@latest
```

[Gow](https://github.com/mitranim/gow): Go Watch: missing watch mode for the go command. It's invoked exactly like go, but also watches Go files and reruns on changes.

```shell
go install github.com/mitranim/gow@latest
```

[Gotestsum](https://github.com/gotestyourself/gotestsum)

```shell
go install gotest.tools/gotestsum@latest
```

[Gotests](https://github.com/cweill/gotests): t's a Golang commandline tool that generates table driven tests based on its target source files' function and method signatures.

```shell
$ go get -u github.com/cweill/gotests/...
```

[Air](https://github.com/cosmtrek/air): Live reload for Go apps

```shell
go install github.com/cosmtrek/air@latest
```

[Golines](https://github.com/segmentio/golines): Golines is a golang formatter that shortens long lines, in addition to all of the formatting fixes done by gofmt

```shell
go install github.com/segmentio/golines@latest
```

[Wails](https://github.com/wailsapp/wails): Build desktop applications using Go & Web Technologies

## VS Code

### Extensions

- [Joker Smile](https://marketplace.visualstudio.com/items?itemName=marcosvidolin.joker-smile): This is a Visual Studio Code theme based on Joker's style.

## Chrome

### Extensions

- [Octotree](https://chrome.google.com/webstore/detail/octotree/bkhaagjahfmjljalopjnoealnfndnagc): Browser extension that brings your GitHub experience to the next level.
- [Dark Reader](https://chrome.google.com/webstore/detail/dark-reader/eimadpbcbfnmbkopoojfekhnkhdbieeh): Dark mode for every website. Take care of your eyes, use dark theme for night and daily browsing.
- [React Developer Tools](https://chrome.google.com/webstore/detail/react-developer-tools/fmkadmapgofadopljbjfkapdkoienihi?hl=en): React Developer Tools is a Chrome DevTools extension for the open-source React JavaScript library.
- [JSONViewer](https://chrome.google.com/webstore/detail/jsonview/chklaanhfefbnpoihckbnefhakgolnmc?hl=en): 
Validate and view JSON documents.
- [Grammarly](https://chrome.google.com/webstore/detail/grammarly-for-chrome/kbfnbcaeplbcioakkpcpgfkobkghlhen?hl=en): Grammarly helps you eliminate writing errors and find the perfect words to express yourself.
- [OneTab](https://chrome.google.com/webstore/detail/onetab/chphlpgkkbolifaimnlloiipkdnihall/related?hl=en): Whenever you find yourself with too many tabs, click the OneTab icon to convert all of your tabs into a list. 
- [ColorZilla](https://chrome.google.com/webstore/detail/colorzilla/bhlhnicpbhignbdhedgjhgdocnmhomnp?hl=en): Advanced Eyedropper, Color Picker, Gradient Generator and other colorful goodies.
- [AdBlock](https://chrome.google.com/webstore/detail/adblock-%E2%80%94-best-ad-blocker/gighmmpiobklfepjocnamgkkbiglidom): Block ads and pop-ups on YouTube, Facebook, Twitch, and your favorite websites.


## Utility Sites

[Regex101](https://regex101.com/): A very intuitive online regular expression tool

[JWT.IO](https://jwt.io/): JWT.IO allows you to decode, verify and generate JWT

[gitignore.io](https://www.gitignore.io/): Create useful .gitignore files for your project

[patorjk.com](http://patorjk.com/software/taag/#p=display&f=Graffiti&t=Type%20Something%20): Text to ASCII Art Generator

[vim-bootstrap](https://vim-bootstrap.com/): Your configuration generator for Neovim/Vim

[JSON Crack](https://jsoncrack.com/): Seamlessly visualize your JSON data instantly into graphs

[SwagDefGen](https://roger13.github.io/SwagDefGen/): Swagger Definition Objects Generator

[Carbon](https://carbon.now.sh/): Create and share beautiful images of your source code

[MongoDb Playground](https://mongoplayground.net/): Mongo Playground allows you to build mongodb queries
