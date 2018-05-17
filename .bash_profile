export EDITOR=vim
export PATH=$PATH:/opt/bb/bin
source ~/dotfiles/func.sh

# usage: join -o joined.pdf ./pdfs/*.pdf
alias joinpdfs="/System/Library/Automator/Combine\ PDF\ Pages.action/Contents/Resources/join.py"

export CLASSPATH=".:/usr/local/lib/antlr-4.7.1-complete.jar:$CLASSPATH"
alias antlr4='java -jar /usr/local/lib/antlr-4.7.1-complete.jar'
alias grun='java org.antlr.v4.gui.TestRig'

antlrcompile() {
    sudo antlr4 $1.g4
    javac $1*.java
}

antrlrun() {
    echo $2 | grun $1 prog -gui
}



parity() {
    docker run -ti parity/parity:v1.7.0
}

vout() {
    cp ~/dev/ValentinePhone/android/app/build/outputs/apk/debug/app-debug.apk ~/dev/valentine-server/public
}

vrout() {
    cp ~/dev/ValentinePhone/android/app/build/outputs/apk/release/app-release-unsigned.apk ~/dev/valentine-server/public/x.apk
    cd ~/dev/valentine-server
    git add .
    git commit -m "WIP"
    git push heroku master
    cd -
    echo done
}
cds() {
    pushd $1 > /dev/null
}

b() {
    # history_forward+=($(pwd))
    popd > /dev/null
}

f() {
    local arr=$history_forward
    index=${#arr[@]}
    echo $index
    #unset $(arr[${#arr[@]}-1])


}

note(){
    $EDITOR ~/dev/_n
}

export PROMPT_COMMAND='history -a'

# so we use homebrew versions of system apps
export PATH=/usr/local/bin:$PATH

# android
alias amen='adb shell input keyevent 82'
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/platform-tools
touch ~/.gradle/gradle.properties && echo "org.gradle.daemon=true" >> ~/.gradle/gradle.properties

# ulimit -n 10240 # Set File Descriptor limit to be high

earless() {
  local pid=$(lsof -i:$1 -t)
  kill -KILL $pid
}

alias u='pushd .. && ls'

repeat() {
  local secs=$1
  shift
  $@
  sleep $secs
  repeat $secs $@
}

export CLASSPATH=".:/usr/local/lib/antlr-4.6-complete.jar:$CLASSPATH"
alias antlr4='java -jar /usr/local/lib/antlr-4.6-complete.jar'
alias grun='java org.antlr.v4.gui.TestRig'

export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

ks() {
    VBoxManage controlvm $vm poweroff
}

kr (){
     VBoxManage controlvm $vm poweroff
     VBoxManage snapshot $vm restore good
     VBoxManage startvm $vm --type headless
}
                
# replace path to Vagrantfile directory with path to your Vagrantfile directory
alias kv='pushd ~/dev/imge-koh2/vagrant2 && vagrant ssh'

export PYTHONPATH=/Library/Python/2.7/site-packages/
export GOPATH=~/go
export PATH="$GOPATH/bin:$PATH"
export GOSRC="$GOPATH/src/github.com/mheiber/"

alias nk='rm -rf node_modules'


# this is useful if you want to run a binary from `node_modules`.
# You can use it like this: `nm mocha test` and `nm db-migrate up`
# instead of `./node_modules/.bin/mocha test` and `./node_modules/.bin/db-migrate up`
nm() {
  arg=$1
  shift
  ./node_modules/.bin/$arg $*
}

# mysql stuff
alias ms='mysql.server start'
alias msk='mysql.server stop'
# kill all queries the dirty way
alias mskaq='for i in {994..1145}; do mysql -uroot  -e "kill $i" ; done &> /dev/null &'

# redis
alias rs='redis-server'
alias rsk='redis-server stop'

# npm

alias ns='npm start'
alias nd='npm run dev'
 
gcur() {
    git branch | cut -d" " -f2
}

test -f ~/.git-completion.bash && . $_

source ~/.bashrc


# export RUST_SRC_PATH=/usr/local/src/rust-1.10.0/src
# alias mit-scheme="/Applications/MIT-Scheme.app/Contents/Resources/mit-scheme"

# chrome file.html to open file
alias chrome="open -a 'Google Chrome'"


alias CLIB='/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/clang/7.3.0/include'export PATH=$PATH:$HOME/Library/Android/sdk/platfor‌​m-tools/
export PATH=$PATH:$HOME/Library/Android/sdk/platform-tools
export PATH=$PATH:$HOME/Library/Android/sdk/tools
# stuff there
source ~/.stuff

# OPAM configuration
. /Users/maxwellheiber/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true

source ~/.cargo/env 
export RUST_SRC_PATH=/Users/maxwellheiber/.rustup/toolchains/stable-x86_64-apple-darwin/lib/rustlib/src/rust/src

export PATH=$PATH:$HOME/dev/tools/emsdk-portable/emscripten/1.37.9
export PATH=$PATH:$HOME/dev/tools/emsdk-portable

if [[ $PWD == $HOME ]]; then
    cd dev
fi

alias calc="node -r ~/calclib.js "

