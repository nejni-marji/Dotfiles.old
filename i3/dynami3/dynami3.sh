#!/bin/bash
export dir=~/.i3
export dy_dir="$(dirname "${BASH_SOURCE[0]}")"
export plugins=$dy_dir/plugins
export lock_cmd="$dy_dir/lock_dynami3.sh"

export preconf=$dir/preconfig
export tmpconf=$dy_dir/data/tmpconfig
export outconf=$dy_dir/data/outconfig
export finconf=$dir/config

cat $preconf > $tmpconf
cat $preconf > $outconf

parse_config() {
	< "$dy_dir/dynami3.conf" \
	grep -Po '^[^#]*' \
	| perl -pe 's/^\s*//' \
	| perl -pe 's/\s*(?=.$)\s//'
}

#parse_config
#exit

mapfile -t plugins_list < <(parse_config)

#echo test:
#for i in "${plugins_list[@]}"; do
#	echo "$i"
#done
#exit

for p_name in "${plugins_list[@]}"; do
	export p_name="$p_name"
	echo debug: $p_name
	export p_dir="$plugins/$p_name"
	export p_run="$plugins/$p_name/plugin.sh"

	{
		cat $tmpconf
		"$p_run" >/dev/null 2&>/dev/null && {

			echo "# {{{ dynami3: $p_name #"
			"$p_run" | perl -pe 's/^/\t/'
			echo "# }}} $p_name"

		} || {

			echo "# dynami3: $p_name: plugin failed #"
			espeak "dynam_i3 error: $p_name" #TODO: error reporting thru nagbar

		}
	} > $outconf

	cat $outconf > $tmpconf
done

cat $outconf > $finconf
