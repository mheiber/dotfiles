# Usage:
# `dirpin` pins current directory so can just type `<short_dir_name>` instead of `cd <long_dir_name>` to go
# `dirpin <alias>` does the same, but uses alias instead of `short_dir_name`

cmd="cd $(pwd)"
short_dir=$(pwd | rev | cut -d"/" -f 1 | rev)
func_name=${1:-$short_dir}
echo $cmd > $FUNCTIONS_DIR/$func_name.sh
fsrc

