#!/bin/bash

STATUS="$(pgrep openvpn)"

if [ -z "$STATUS" ]; then
  text="{\"text\":\"\",\"class\":\"inactive\",\"tooltip\":\"OpenVPN is not running\"}"
  if [ $1 = 'toggle' ]; then
    sudo_password=$(echo "Enter sudo to start" | wofi --dmenu -P --lines 1 --width 100)
    HISTIGNORE="*sudo -s*" && echo $sudo_password | sudo -S openvpn /home/f0ur3y3s/.config/openvpn/vta.ovpn > /dev/null 2>&1 & disown
    text="{\"text\":\"\",\"class\":\"active\",\"tooltip\":\"OpenVPN is running\"}"
  fi
else
  text="{\"text\":\"\",\"class\":\"active\",\"tooltip\":\"OpenVPN is running\"}"
  if [ $1 = 'toggle' ]; then
    sudo_password=$(echo "Enter sudo to quit" | wofi --dmenu -P --lines 1 --width 100)
    HISTIGNORE="*sudo -s*" && echo $sudo_password | sudo -S pkill openvpn > /dev/null 2>&1 & disown
    text="{\"text\":\"\",\"class\":\"inactive\",\"tooltip\":\"OpenVPN is not running\"}"
  fi
fi

echo $text