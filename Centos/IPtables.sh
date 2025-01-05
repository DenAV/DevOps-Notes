#!/bin/bash
#
# IP Tables Configuration Script for Zabbix Server
#

# Declare variables
export IPT="iptables"

# Interface connected to the internet
export WAN=ens192
export WAN_IP=192.168.0.11

# Flush all iptables chains
$IPT -F
$IPT -F -t nat
$IPT -F -t mangle
$IPT -X
$IPT -t nat -X
$IPT -t mangle -X

# Set default policies for unmatched traffic
$IPT -P INPUT DROP
$IPT -P OUTPUT DROP
$IPT -P FORWARD DROP

# Allow local traffic for loopback
$IPT -A INPUT -i lo -j ACCEPT
$IPT -A OUTPUT -o lo -j ACCEPT

# Allow outgoing connections from the server itself
$IPT -A OUTPUT -o $WAN -j ACCEPT

# Allow established and related connections
$IPT -A INPUT -p all -m state --state ESTABLISHED,RELATED -j ACCEPT
$IPT -A OUTPUT -p all -m state --state ESTABLISHED,RELATED -j ACCEPT
$IPT -A FORWARD -p all -m state --state ESTABLISHED,RELATED -j ACCEPT

# Enable packet fragmentation for proper MTU handling
$IPT -I FORWARD -p tcp --tcp-flags SYN,RST SYN -j TCPMSS --clamp-mss-to-pmtu

# Drop invalid packets
$IPT -A INPUT -m state --state INVALID -j DROP
$IPT -A FORWARD -m state --state INVALID -j DROP

# Drop new connections not using the SYN flag
$IPT -A INPUT -p tcp ! --syn -m state --state NEW -j DROP
$IPT -A OUTPUT -p tcp ! --syn -m state --state NEW -j DROP

# Allow ICMP ping (echo-request and related types)
$IPT -A INPUT -p icmp --icmp-type echo-reply -j ACCEPT
$IPT -A INPUT -p icmp --icmp-type destination-unreachable -j ACCEPT
$IPT -A INPUT -p icmp --icmp-type time-exceeded -j ACCEPT
$IPT -A INPUT -p icmp --icmp-type echo-request -j ACCEPT

# Open ports for SSH, HTTP, and HTTPS
$IPT -A INPUT -i $WAN -p tcp -s 192.168.17.0/24 --dport 22 -j ACCEPT
$IPT -A INPUT -i $WAN -p tcp -s 192.168.0.0/20 --dport 80 -j ACCEPT
$IPT -A INPUT -i $WAN -p tcp -s 192.168.17.0/24 --dport 80 -j ACCEPT
$IPT -A INPUT -i $WAN -p tcp -s 192.168.0.0/20 --dport 443 -j ACCEPT
$IPT -A INPUT -i $WAN -p tcp -s 192.168.17.0/24 --dport 443 -j ACCEPT

# Open ports for Zabbix-Agent
$IPT -A INPUT -i $WAN -p tcp -s 10.10.10.0/24 --dport 10051 -j ACCEPT
$IPT -A INPUT -i $WAN -p tcp -s 10.10.11.0/24 --dport 10051 -j ACCEPT
$IPT -A INPUT -i $WAN -p tcp -s 192.168.0.0/18 --dport 10051 -j ACCEPT

# Open ports for MySQL
$IPT -A INPUT -i $WAN -p tcp -s 192.168.0.11 --dport 3306 -j ACCEPT

# Define logging chains
$IPT -N undef_in
$IPT -N undef_out
$IPT -N undef_fw
$IPT -A INPUT -j undef_in
$IPT -A OUTPUT -j undef_out
$IPT -A FORWARD -j undef_fw

# Log and drop packets in undefined chains
$IPT -A undef_in -j LOG --log-level info --log-prefix "-- IN -- DROP "
$IPT -A undef_in -j DROP
$IPT -A undef_out -j LOG --log-level info --log-prefix "-- OUT -- DROP "
$IPT -A undef_out -j DROP
$IPT -A undef_fw -j LOG --log-level info --log-prefix "-- FW -- DROP "
$IPT -A undef_fw -j DROP

# Save the iptables rules
/sbin/iptables-save > /etc/sysconfig/iptables
