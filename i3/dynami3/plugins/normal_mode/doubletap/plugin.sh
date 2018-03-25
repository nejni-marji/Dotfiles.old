#!/bin/bash
cat $p_dir/doubletap.conf
cat << EOM
bindsym \$n_ak \$exec i3-msg mode "\$n_am" && sleep .135 && xdotool key \$n_nk
mode "\$n_am" {
	bindsym \$n_ak mode "\$n_nm"; \$exec sleep .25 && i3-msg mode "normal"
	bindsym \$n_nk mode "\$n_nm"; \$exec xdotool keyup \$n_ak key \$n_ak && i3-msg mode "default"
}

mode "\$n_nm" {
	bindsym \$n_nk mode "default"
}
EOM
