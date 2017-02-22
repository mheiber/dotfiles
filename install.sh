cd ~/dotfiles

# link dot files
for file in $(ls -a | grep "^\."); do
  if [ "$file" != "." ] && [ "$file" != ".." ] && [ "$file" != ".git" ]; then
    cmd="ln -s $@ $(pwd)/$file ~/$file"
    echo $cmd
    eval $cmd
  fi
done

# Sublime settings
ln -s $@ ~/dotfiles/subl-setttings/ ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User

