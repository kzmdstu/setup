#!/bin/bash

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

brew install go

go install github.com/kzmdstu/seqinfo@latest
go install github.com/kzmdstu/movinfo@latest

echo 'export PATH=$PATH:"$HOME/go/bin"' >> "$HOME/.zshrc"
echo 'export SEQINFO_CONFIG=/Volumes/storm/library/site/config/seqinfo/config.toml'
source "$HOME/.zshrc"

brew install openimageio
