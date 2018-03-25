#!/bin/bash
lock_func() {
	$lock_cmd get $1 && {
		echo "set \$$2 $3"
	} || {
		echo "set \$$2 $4"
	}
}

source $p_dir/plugin.conf
