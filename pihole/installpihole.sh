#!/bin/zsh
# https://chealion.ca/2019/08/08/pihole-on-a-mac-with-docker/
# sudo docker run -d -p 80:80 -p 53:53 -p 53:53/udp --restart=unless-stopped --env-file ~/.dotfiles/pihole/.piholeenv --name pihole pihole/pihole
docker-compose up --detach
sudo networksetup -setdnsservers Wi-Fi 127.0.0.1 208.67.222.222 208.67.220.220 8.8.8.8
networksetup -getdnsservers Wi-Fi
scutil --dns
open http://127.0.0.1/admin/