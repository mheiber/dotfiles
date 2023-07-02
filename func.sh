# inspired by fish's functions features, but I don't use it anymore, see ./functions/README.md
export FUNCTIONS_DIR=~/dotfiles/functions

mkdir -p $FUNCTIONS_DIR

fsrc() {
  for file in $(ls $FUNCTIONS_DIR); do
    local func=$(echo $file | cut -d. -f 1)
    local cmd="\n$func() {\nsource $FUNCTIONS_DIR/$file;\n}\n"
    alias $func="source $FUNCTIONS_DIR/$file"
    # $1 "$(printf "$cmd")"
  done
}

fsave() {
  local f="$FUNCTIONS_DIR/$1.sh"
  local cmd="$(history -p !!)"
  printf "$cmd"
  printf "$cmd" > $f
  $EDITOR $f
  fsrc
}

flsv() {
  head -n 999999 $FUNCTIONS_DIR/*
}

fls() {
    ls $FUNCTIONS_DIR
}

frm() {
  rm $FUNCTIONS_DIR/$1.sh
  unset $1 | cut -d. -f 1
}

fmv() {
  mv $FUNCTIONS_DIR/$1.sh $FUNCTIONS_DIR/$2.sh
  unset $1
  fsrc
}

fed() {
    $EDITOR $FUNCTIONS_DIR/$1.sh
    fsrc
}

fdup() {
  cp $FUNCTIONS_DIR/$1.sh $FUNCTIONS_DIR/$2.sh
  fed $2
}

fsrc

