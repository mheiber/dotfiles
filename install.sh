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
    # for Vim mode in IntelliJ to use the same settingsn
    ln -s "$HOME/.vimrc" ~/.ideavimrc
}

osx_defaults() {
    source ./osx-defaults.sh
}

link_dots
subl_settings
osx_defaults

