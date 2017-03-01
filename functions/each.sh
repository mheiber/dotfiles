local pre=$1
shift
local post=$@
while read -e item; do $pre $item $post; done
