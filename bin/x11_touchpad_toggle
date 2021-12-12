#! /bin/bash

# toggle touchpad status

device="Synaptics TM3127-001"
enabled=$(xinput --list-props "$device" | grep "Device Enabled" | awk '{print $NF}')

if [[ "$enabled" == "1" ]]; then
    xinput --disable "$device"
    notify-send "Touchpad disabled"
else
    xinput --enable "$device"
    notify-send "Touchpad enabled"
fi
