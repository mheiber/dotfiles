EDITOR=vim

vm='vagrant2_koh2_1477922643009_58036'
    
kr (){
     VBoxManage controlvm $vm poweroff
     VBoxManage snapshot $vm restore good
     VBoxManage startvm $vm --type headless
}
                
# replace path to Vagrantfile directory with path to your Vagrantfile directory
alias kv='pushd ~/dev/imge-koh2/vagrant2 && vagrant ssh'

functions_dir=~/dotfiles/.functions

fsrc() {
  mkdir -p $functions_dir
  for file in $(ls $functions_dir); do

    local func=$(echo $file | cut -d. -f 1)
    local contents=$(cat $functions_dir/$file)
    local cmd="$func() {\n  $contents\n}\n\n"
    eval "$(printf "$cmd")"
  done
}

fsave() {
  mkdir -p $functions_dir
  f="$functions_dir/$1.sh"
  local cmd="$(history -p !!)"
  printf "$cmd"
  printf "$cmd" > $f
  $EDITOR $f
  fsrc
}

fed() {
  mkdir -p $functions_dir
  local f="$functions_dir/$1.sh"
  $EDITOR $f
  fsrc
}

fls() {
  mkdir -p $functions_dir
  printf "$(ls $functions_dir | cut -d. -f 1)"
}

frm() {
  rm $functions_dir/$1.sh
  unset "$1"
}

fmv() {
  mv $functions_dir/$1.sh $functions_dir/$2.sh
  unset $functions_dir/$1.sh
  fsrc
}

fdup() {
  cp $functions_dir/$1.sh $functions_dir/$2.sh
  fed $2
}

fsrc

git_color() {
  local git_status="$(git status 2> /dev/null)"
  
  if [[ ! $git_status =~ "working directory clean" ]]; then
    echo -e $COLOR_RED
    elif [[ $git_status =~ "Your branch is ahead of" ]]; then
      echo -e $COLOR_YELLOW
    elif [[ $git_status =~ "nothing to commit" ]]; then
      echo -e $COLOR_GREEN
    else
      echo -e $COLOR_OCHRE
  fi
}

function git_branch {
  local git_status="$(git status 2> /dev/null)"
  local on_branch="On branch ([^${IFS}]*)"
  local on_commit="HEAD detached at ([^${IFS}]*)"

  if [[ $git_status =~ $on_branch ]]; then
    local branch=${BASH_REMATCH[1]}
    echo "($branch)"
  elif [[ $git_status =~ $on_commit ]]; then
    local commit=${BASH_REMATCH[1]}
      echo "($commit)"
  fi
}

PS1="\[$WHITE\]\n\w"          # basename of pwd
PS1+="\[\$(git_color)\]"        # colors git status
PS1+="\$(git_branch)"           # prints current branch
PS1+="\[$BLUE\]\$\[$RESET\] "   # '#' for root, else '$'
export PS1

set -o vi

source ~/.bashrc

