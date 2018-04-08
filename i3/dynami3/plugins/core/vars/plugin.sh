#!/bin/bash
lock_func() {
	$dy_dir/bin/lock_dynami3.sh get $1 && {
		echo "set \$$2 $3"
	} || {
		echo "set \$$2 $4"
	}
}

source $p_dir/plugin.conf
