#!/bin/bash

# Use like this inside a wireguard config:
# PostUp = /path/to/script/ifscript.sh %i up
# PreDown = /path/to/script/ifscript.sh %i down

set -xe

interface=$1
action=$2

droute=$(ip route | grep default | awk '{print $3}')
homenet=$HOME_NETWORK
dockernet=172.16.0.0/12

if [[ "$action" = "up" ]]; then
    ip_route_action="add"
    iptables_insert_arg="I"
    iptables_append_arg="A"
elif [[ "$action" = "down" ]]; then
    ip_route_action="del"
    iptables_insert_arg="D"
    iptables_append_arg="D"
else
    echo "Invalid action \"$action\"!"
    exit 1
fi

ip route $ip_route_action $homenet via $droute
iptables -$iptables_insert_arg OUTPUT -d $homenet -j ACCEPT
ip route $ip_route_action $dockernet via $droute
iptables -$iptables_insert_arg OUTPUT -d $dockernet -j ACCEPT
iptables -$iptables_append_arg OUTPUT ! -o $interface -m mark ! --mark $(wg show $interface fwmark) -m addrtype ! --dst-type LOCAL -j REJECT
