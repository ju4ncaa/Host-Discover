#!/usr/bin/env bash


function ctrl_c(){
        echo -e "\n[!] Saliendo...\n"
        exit 1
}


tput civis
trap ctrl_c SIGINT


if [ $# -ne 1 ]; then
    echo -e "\n[!] Uso: $0 <base_ip>"
    tput cnorm
    exit 1
fi

ip_base=$1
new_ip=$(echo $ip_base | grep -oP "\d{1,3}.\d{1,3}.\d{1,3}.")

for i in $(seq 1 254); do
        timeout 1 bash -c "ping -c 1 ${new_ip}${i}" &>/dev/null && echo -e "\n[+] Host: 192.168.1.$i - ACTIVE"&
done

wait

tput cnorm
