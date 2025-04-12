#!/bin/bash

Time()
{
   TIME=$(date "+%a %d %B, %H:%M")
   echo $TIME
}

Disk()
{
	DISK=$(df -h | grep /dev/vda3 | awk -F " " '{printf $3"/"$2"("$5")"}')
	echo "Disk: $DISK"
}

Mem()
{
	RAM=$(free -h | grep Mem | awk -F" " '{print $1" " $3"/"$2}')
	SWAP=$(free -h | grep Swap | awk -F" " '{print $1" " $3"/"$2}')
	echo "$RAM | $SWAP"
}

#current workspace
C_Ws()
{
	WS=$(bspc query -D -d --names)
	echo $WS
}

#focused window
F_Win()
{
	WIN_ID=$(bspc query -N -n)
	WIN_NAME=$(xprop -id $WIN_ID | grep "WM_NAME" | head -n1|awk -F '"' '{printf $2}' )
	echo $WIN_NAME
}

while true; do
	echo -e "%{l} $(C_Ws) - $(F_Win)%{c}$(Time) %{r}$(Mem) | $(Disk)"
	sleep 0.2s
done
