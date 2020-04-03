#!/bin/bash
#
#	Copyleft 2020 Tomm Purnell
#
#	netrek-init.sh -
#		Bring up hosts and share keys auto-magically
#
#	Usage: netrek-init.sh [ hostsdir ]
#
#---------------------------------------------------------------------

set -o nounset                              # Treat unset variables as an error
set -e -o pipefail			    # Fail as Early As Possible

export LC_ALL=C
export LANG=C


SELF="$(readlink -f "${BASH_SOURCE[0]}")"
export PATH="${SELF%/*}:$PATH"

VARIABLE=""
VAR_ARRAY=()

SAVE_CONFIG=0
CONFIG_FILE=""

PROGRAM="${0##*/}"
ARGS=( "$@" )

cmd() {
	echo "[#] $*" >&2
	"$@"
}

die() {
	echo "$PROGRAM: $*" >&2
	exit 1
}

read_bool() {
	case "$2" in
	true) printf -v "$1" 1 ;;
	false) printf -v "$1" 0 ;;
	*) die "\`$2' is neither true nor false"
	esac
}

auto_su() {
	[[ $UID == 0 ]] || exec sudo -p "$PROGRAM must be run as root. Please enter the password for %u to continue: " -- "$BASH" -- "$SELF" "${ARGS[@]}"
}

#------------------------------------------


rsync -azP hondje@box.digital-deforestation.com:/home/hondje/tinc/ /etc/tinc


create_node() {
    TINC_NETWORK="$1"
    TINC_NODE="$2"
    TINC_PREFIX="$3"
    
    mkdir -p /etc/tinc/${TINC_NETWORK}/hosts
    rsync -azvP hondje@172.105.76.66:/home/hondje/tinc/${TINC_NETWORK}/hosts/ /etc/tinc/${TINC_NETWORK}/hosts
    TINC_HOSTS=( /etc/tinc/${TINC_NETWORK}/hosts/* )
}

create_tinc_conf() {
    TINC_HOSTS=( $(basename -a /etc/tinc/${TINC_NETWORK}/hosts/*) )
    NODENUM=$(( ${#TINC_HOSTS[@]} + 1 ))
    NODE_ADDR="${TINC_PREFIX}.${NODENUM}"
    
    :> /etc/tinc/${TINC_NETWORK}/tinc.conf
    printf "Name %s\n" $TINC_NODE >> /etc/tinc/${TINC_NETWORK}/tinc.conf
    printf "Device /dev/net/tun\n" >> /etc/tinc/${TINC_NETWORK}/tinc.conf
    printf "GraphDumpFile /etc/tinc/%s/graph.dot\n" $TINC_NETWORK >> /etc/tinc/${TINC_NETWORK}/tinc.conf
    printf "LocalDiscovery yes\n" >> /etc/tinc/${TINC_NETWORK}/tinc.conf
    printf "ConnectTo %s\n" ${TINC_HOSTS[@]} >> /etc/tinc/${TINC_NETWORK}/tinc.conf
}

create_tinc_host() {
    LOCAL_IP_ADDRS=( $( hostname --all-ip-addresses ) ) 
    :> /etc/tinc/${TINC_NETWORK}/hosts/${TINC_NODE}
    
    printf "#  %s\n" $TINC_NODE >> /etc/tinc/${TINC_NETWORK}/hosts/${TINC_NODE}
    printf "Address %s\n" ${LOCAL_IP_ADDRS[@]} >> /etc/tinc/${TINC_NETWORK}/hosts/${TINC_NODE}
    printf "Compression 9\n" >> /etc/tinc/${TINC_NETWORK}/hosts/${TINC_NODE}
    printf "Subnet %s/32\n" ${NODE_ADDR} >> /etc/tinc/${TINC_NETWORK}/hosts/${TINC_NODE}
    
    scp /etc/tinc/${TINC_NETWORK}/hosts/${TINC_NODE} \
        hondje@172.105.76.66:/home/hondje/tinc/${TINC_NETWORK}/hosts/
}

create_key() {
    
    yes | tincd -n ${TINC_NETWORK} -K
}

create_updown() {
    :> /etc/tinc/${TINC_NETWORK}/tinc-up
    printf "ip link set %s up\n" $INTERFACE >> /etc/tinc/${TINC_NETWORK}/tinc-up
    printf "ip addr add %s/24 dev %s\n" ${NODE_ADDR} $INTERFACE >> /etc/tinc/${TINC_NETWORK}/tinc-up
    
    :> /etc/tinc/${TINC_NETWORK}/tinc-down
    printf "ip addr del %s/24 dev %s\n" ${NODE_ADDR} $INTERFACE >> /etc/tinc/${TINC_NETWORK}/tinc-down
    printf "ip link set %s up\n" $INTERFACE >> /etc/tinc/${TINC_NETWORK}/tinc-up
}

    
