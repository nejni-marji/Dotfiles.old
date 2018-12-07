#!/bin/bash
if [[ -z $1 ]]; then

i3-input \
-P 'DuckDuckGo: ' \
-F 'exec --no-startup-id firefox --new-window "https://duckduckgo.com/?q=%s"' \

else

i3-input \
-P 'DuckDuckGo: '"$1 " \
-F 'exec --no-startup-id firefox --new-window "https://duckduckgo.com/?q='"$1"'+%s"' \

fi
