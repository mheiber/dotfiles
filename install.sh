cd ~/dotfiles

for file in $(ls -a | grep "^\."); do
  if [ "$file" != "." ] && [ "$file" != ".." ] && [ "$file" != ".git" ]; then
    cmd="ln -s $(pwd)/$file ~/$file"
    echo $cmd
    eval $cmd
  fi
done


