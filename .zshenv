#!/usr/bin/env zsh
set -o emacs
source ~/.secrets.sh

alias b=/tmp/bin/buck2
export PATH=/tmp/bin:$PATH

alias keymap='vim ~/qmk_firmware/keyboards/lily58/keymaps/maxwell/keymap.c'

alias rg='rg --smart-case'

# These two functions are the most important:
# bp() to edit this file and easily add a function and then source the file.
# src() to source this file (used in ~/.zshrc and for existing open shells)
bp() {
    nvim ~/.zshenv
    src
}


src() {
    source ~/.zshenv
}



D=~/Desktop

erlversion() {
     erl -eval 'erlang:display(erlang:system_info(otp_release)), halt().'  -noshell
}


mkdialyzer() {
    cd ~/otp
    make -j 15 libs
    cd -
}

edlinter() {
    vim $WADIR/../arcanist/lint/WhatsAppSignedSourceLinter.php
}



# for running otp tests
setotp() {
    export ERL_TOP=$(pwd)
    export PATH=$ERL_TOP/bin:$PATH
}

mkcd() {
    mkdir -p $1 &&
    cd $1
}

lf() {
    if [ -d $1 ]; then
        ls $@
    else
        echo 'is file'
        cat $@
    fi
}



nixsrc() {
  /Users/mheiber/.nix-profile/etc/profile.d/nix.sh
}

wifi() {
    ipconfig getifaddr en0
}


export EDITOR=nvim

export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# if [ -n "$NVIM_LISTEN_ADDRESS" ]; then
#   export EDITOR="nvr -cc tabedit --remote-wait +'set bufhidden=wipe'"
# else
#   export EDITOR="nvim"
# fi
alias vim=nvim

vin() {
    vim -c "Nn"
}


# DEVVM defined in secrets
dev1() {
    mosh mheiber@$DEVVM
}
dev2() {
    mosh mheiber@$DEVVM2
}

export PATH=/usr/local/smlnj/bin:$PATH

export PATH=~/devtool/Idris2/:$PATH

export PATH=/Applications/Racket\ v7.8/bin/:$PATH

# why isn't this the default?
export ERL_AFLAGS="-kernel shell_history enabled"
# export PATH='~/Library/Application\ Support/ErlangInstaller/23.0.2/bin':$PATH

# gst() {
#     git status
# }

gamendtime() {
    dt = "$(date)"
    GIT_COMMITTER_DATE="$(date)" git commit --amend --no-edit --date "$(date)"
}

pushup() {
    git push --set-upstream origin $(git rev-parse --abbrev-ref HEAD)
}

brooze(){
    sudo chown -R $(whoami) /usr/local/bin /usr/local/lib /usr/local/sbin
    chmod u+w /usr/local/bin /usr/local/lib /usr/local/sbin
    brew install $1
}

loud() {
    echo $@
    $@
}

section() {
    echo "######## $@"
}

loopit() {
    while true; do
        sleep $1
        shift
        $@
    done
}

alias fswatch='/usr/local/Cellar/fswatch/1.15.0/bin/fswatch'
# eval `opam config env`
export OCAMLRUNPARAM=b
if [ -e /Users/mheiber/.nix-profile/etc/profile.d/nix.sh ]; then . /Users/mheiber/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

source "$HOME/.cargo/env"


export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk-14.0.2.jdk/Contents/Home
export PATH=$JAVA_HOME/bin:$PATH
export PATH=/Users/mheiber/.local/bin:$PATH

export PATH=~/.ghcup/bin$PATH

# alias elp=elp-t
alias cb='cargo build'
alias cr='cargo run'
alias ck='cargo check'
alias crt='RUST_BACKTRACE=1 cargo run'
alias ct='cargo test'
alias cf='cargo fmt'
alias ctt='RUST_BACKTRACE=1 cargo test'
alias sptd='brew services restart spotifyd'

# bypass paywall
story() {
    loc=~/Desktop/out.html 
    curl -L $1 -o $loc
    open $loc
}
hm() {
    mkdir -p ~/Dropbox/hm
    vim ~/Dropbox/hm/_next.md
}
hmbuck2() {
    mkdir -p ~/Dropbox/hm/buck2
    vim ~/Dropbox/hm/buck2/_next.md
}

linkup() {
    ln -sf ../linked/* .
}

atapl() {
    mkdir -p ~/Dropbox/atapl
    cd ~/Dropbox/atapl
    vim atapl.md
}

alias notes='vim -c Nn'


