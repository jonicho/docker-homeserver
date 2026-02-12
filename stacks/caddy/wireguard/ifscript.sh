#!/bin/bash

# Use like this inside a wireguard config:
# PostUp = /path/to/script/ifscript.sh %i up
# PreDown = /path/to/script/ifscript.sh %i down

set -xe

interface=$1
action=$2

droute=$(ip route | grep default | awk '{print $3}')
homenet=192.168.1.0/24
dockernet=172.16.0.0/12

if [[ "$action" = "up" ]]; then
    ip_route_action="add"
    ip_route_insert_arg="I"
    ip_route_append_arg="A"
elif [[ "$action" = "down" ]]; then
    ip_route_action="del"
    ip_route_insert_arg="D"
    ip_route_append_arg="D"
else
    echo "Invalid action \"$action\"!"
    exit 1
fi

ip route $ip_route_action $homenet via $droute
iptables -$ip_route_insert_arg OUTPUT -d $homenet -j ACCEPT
ip route $ip_route_action $dockernet via $droute
iptables -$ip_route_insert_arg OUTPUT -d $dockernet -j ACCEPT
iptables -$ip_route_append_arg OUTPUT ! -o $interface -m mark ! --mark $(wg show $interface fwmark) -m addrtype ! --dst-type LOCAL -j REJECT
