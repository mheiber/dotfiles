# explain previous command or command given as arguments
local cmd
if [ "$#" == 0 ]; then
	echo "using hist $#"
	cmd="$(history -p !!)"
else
	echo "using $@"
	cmd=$@
fi

local uri="http://explainshell.com/explain?$cmd"
echo "$uri"
open -a google\ chrome.app "http://explainshell.com/explain?cmd=$cmd"
