#!/bin/bash
cat $p_dir/plugin.conf
cat << EOM
bindsym \$mod+\$n_dk mode "normal"
mode "normal" {
	bindsym Return mode "default"
	bindsym Escape mode "default"
	bindsym Control+c mode "default"
	bindsym Control+bracketleft mode "default"
	bindsym \$mod+\$n_dk mode "default"
	bindsym \$n_dk mode "default"
EOM

cat $tmpconf \
| grep -P '^\s*bindsym \$(mod|MOD)\+(?!.*(nop|\\)$)' \
| perl -pe 's/^\s*bindsym \$(mod|MOD)\+/\tbindsym /'

echo '}'
