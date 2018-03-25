#!/bin/bash
echo 'Running: sudo systemctl restart wpa_supplicant@wlp2s0'
sudo systemctl restart wpa_supplicant@wlp2s0
echo 'Running: sudo systemctl restart dhcpcd@wlp2s0'
sudo systemctl restart dhcpcd@wlp2s0
	[[ "$(hostname)" == "Toshiba" ]] && echo 'Running: systemctl --user stop deluged'
	[[ "$(hostname)" == "Toshiba" ]] && systemctl --user stop deluged
	[[ "$(hostname)" == "Toshiba" ]] && echo 'Running: sudo systemctl restart ufw'
	[[ "$(hostname)" == "Toshiba" ]] && sudo systemctl restart ufw
#	[[ "$(hostname)" == "Toshiba" ]] && echo 'Running: sudo ufw disable'
#	[[ "$(hostname)" == "Toshiba" ]] && sudo ufw disable
	[[ "$(hostname)" == "Toshiba" ]] && echo 'Running: sudo systemctl restart openvpn-client@AirVPN'
	[[ "$(hostname)" == "Toshiba" ]] && sudo systemctl restart openvpn-client@AirVPN
#	[[ "$(hostname)" == "Toshiba" ]] && echo 'Running: sudo ufw enable'
#	[[ "$(hostname)" == "Toshiba" ]] && sudo ufw enable
	[[ "$(hostname)" == "Toshiba" ]] && echo 'Running: systemctl --user start deluged'
	[[ "$(hostname)" == "Toshiba" ]] && systemctl --user start deluged
