# supposed to install the dotfiles
# I haven't tried this in a while
cd ~/dotfiles

is_safe () {
    if [ "$file" != "." ] && [ "$file" != ".." ] && [ "$file" != ".git" ]; then
        return 0
    fi
    return 1
}

# link dot files
link_dots() {
    for file in $(ls -a | grep "^\."); do
      if [ "$file" != "." ] && [ "$file" != ".." ] && [ "$file" != ".git" ] && [ "$file" != ".DS_Store" ]; then
        cmd="ln -s $@ $(pwd)/$file ~/$file"
        echo $cmd
        eval $cmd
      fi
    done
}

osx_defaults() {
    source ./osx-defaults.sh
}

link_dots
osx_defaults

