# The Sway configuration file in ~/.config/sway/config calls this script.
# You should see changes to the status bar after saving this script.
# If not, do "killall swaybar" and $mod+Shift+c to reload the configuration.

# uptime
uptime_formatted=$(uptime | \
		       awk '{print $3}' | sed s/,// )

# The abbreviated weekday (e.g., "Sat"), followed by the ISO-formatted date
# like 2018-10-06 and the time (e.g., 14:01)
date_formatted=$(date "+%H:%M")

# Returns the battery status: "Full", "Discharging", or "Charging".
battery_status=$(apm -l)

# run them lmao
echo "up " $uptime_formatted "   |   " $battery_status"%   |  " $date_formatted
