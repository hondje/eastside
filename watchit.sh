#!/bin/bash

##	General Form: watchit augments watch with colors added
##	Usage: watchit <command you wanna watch>
##	Alternative tenative thinking: watchit <arg> to run preset
##	command(s)


function wifi-scan() {

	if [[ $1 == "short" ]]; then
		watch --color -t -n1 nmcli -c yes -f BARS,SSID,CHAN,RATE,SIGNAL dev wifi list;
	else
		watch --color -t -n1 nmcli -c yes dev wifi list;
	fi
}

function nm-network-status() {
	
	if [[ $1 == "short" ]]; then
		watch --color -t -n1 nmcli -c yes radio all;
	else
		watch --color -t -n1 nmcli -c general status;
	fi
}

function nm-dev-status() {
	watch --color -t -n1 nmcli -c yes dev status;
}

##
##
##

function net-ip4() {
	watch --color -t -n1 ip -c -br -4 address show;
}

function net-ip6() {
	watch --color -t -n1 ip -c -br -6 address show;
}

function net-hood() {
	local r_or_n=$1

	watch --color -t -n1 "ip -c $r_or_n show | ccat \
		--bg=dark -G Decimal="darkgreen" --color=always"
}

function net-hotspot() {

}
