#!/bin/bash

# Use like this inside a wireguard config:
# PostUp = /path/to/script/ifscript.sh %i up
# PreDown = /path/to/script/ifscript.sh %i down

set -xe

wg_interface=$1
action=$2

phy_interface=$(ip route | grep default | awk '{print $5}')

if [[ "$action" = "up" ]]; then
    iptables_append_arg="A"
elif [[ "$action" = "down" ]]; then
    iptables_append_arg="D"
else
    echo "Invalid action \"$action\"!"
    exit 1
fi

iptables -$iptables_append_arg FORWARD -i $phy_interface -o $wg_interface -p tcp --syn --dport 80 -m conntrack --ctstate NEW -j ACCEPT
iptables -$iptables_append_arg FORWARD -i $phy_interface -o $wg_interface -p tcp --syn --dport 443 -m conntrack --ctstate NEW -j ACCEPT
iptables -$iptables_append_arg FORWARD -i $phy_interface -o $wg_interface -p tcp --syn --dport 22 -m conntrack --ctstate NEW -j ACCEPT
iptables -$iptables_append_arg FORWARD -i $phy_interface -o $wg_interface -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
iptables -$iptables_append_arg FORWARD -i $wg_interface -o $phy_interface -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
iptables -t nat -$iptables_append_arg PREROUTING -i $phy_interface -p tcp --dport 80 -j DNAT --to-destination 10.0.0.2
iptables -t nat -$iptables_append_arg PREROUTING -i $phy_interface -p tcp --dport 443 -j DNAT --to-destination 10.0.0.2
iptables -t nat -$iptables_append_arg PREROUTING -i $phy_interface -p tcp --dport 22 -j DNAT --to-destination 10.0.0.3
iptables -t nat -$iptables_append_arg POSTROUTING -o $phy_interface -j MASQUERADE
