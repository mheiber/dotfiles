functions_dir=~/dotfiles/functions

_fwrite() {
  mkdir -p $functions_dir
  for file in $(ls $functions_dir); do
    local func=$(echo $file | cut -d. -f 1)
    local cmd="\n$func() {\nsource $functions_dir/$file;\n}\n"
    $1 "$(printf "$cmd")"
  done
}

fsrc() {
    _fwrite eval
}

fsave() {
  mkdir -p $functions_dir
  local f="$functions_dir/$1.sh"
  local cmd="$(history -p !!)"
  printf "$cmd"
  printf "$cmd" > $f
  $EDITOR $f
  fsrc
}

fls() {
  mkdir -p $functions_dir
  printf "$(ls $functions_dir | cut -d. -f 1)\n"
}

flsv() {
    _fwrite printf
    printf "\n"
}

frm() {
  rm $functions_dir/$1.sh
  unset $1
}

fmv() {
  mv $functions_dir/$1.sh $functions_dir/$2.sh
  unset $1
  fsrc
}

fed() {
    $EDITOR $functions_dir/$1.sh
    fsrc
}

fdup() {
  cp $functions_dir/$1.sh $functions_dir/$2.sh
  fed $2
}

fsrc

