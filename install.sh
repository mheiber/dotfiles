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

# Sublime settings
subl_settings(){
    local subl_dir="$HOME/Library/Application Support/Sublime Text 3/Packages/User"
    local saved_subl_dir="$(pwd)/subl-settings"
    mkdir -p "$subl_dir"
    echo "$subl_dir"
    for file in $(ls -a "$saved_subl_dir"); do
      # todo: use the is_safe function instead of repeating this
        if [ "$file" != "." ] && [ "$file" != ".." ] && [ "$file" != ".git" ] && [ "$file" != ".DS_Store" ]; then
            ln -s -f $@ "$saved_subl_dir/$file" "$subl_dir/$file"
        fi
    done
}

osx_defaults() {
    source ./osx-defaults.sh
}

link_dots
subl_settings
osx_defaults

