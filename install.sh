#!/bin/sh

TOOLS_DIR=$HOME/.tools
TOOLS_ENV_DIR=$HOME/.toolsInfo
TOOLS_CACHE_DIR=/tmp/mac_tools_cache

xcode-select --install

# tools cache
rm -rf $TOOLS_CACHE_DIR
git clone https://github.com/bruce9399/mac_tools_cache.git $TOOLS_CACHE_DIR
# tools env
rm -rf $TOOLS_ENV_DIR
git clone https://github.com/bruce9399/mac_tools_env.git $TOOLS_ENV_DIR

# homebrew
/usr/bin/ruby $TOOLS_CACHE_DIR/homebrew.sh

brew install \
    curl \
    wget \
    thefuck \
    gcc \
    pre-commit \
    git \
    subversion \
    python@2 \
    python@3 \
    openconnect

brew cask install \
    surge \
    visual-studio-code \
    wireshark \
    iterm2 \
    virtualbox \
    typora \
    github \
    dash \
    docker \
    jetbrains-toolbox \
    google-chrome

# ohmyzsh
sh $TOOLS_CACHE_DIR/ohmyz.sh
rm -rf ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
cp $TOOLS_ENV_DIR/ohmyzsh/zshrc ~/.zshrc

# vim
cp $TOOLS_ENV_DIR/vim/vimrc ~/.vimrc

# ssh
mv ~/.ssh ~/.ssh_bak_`date +%s`
mkdir -p ~/.ssh/key
cp -r $TOOLS_ENV_DIR/ssh/* ~/.ssh
chmod -R 400 ~/.ssh/key/*.pem

# tools
rm -rf $TOOLS_DIR
git clone git@github.com:bruce9399/mac_tools_core.git $TOOLS_DIR

# git
git config --global core.quotepath false
git config --global push.default simple

zsh -s "source ~/.zshrc"
