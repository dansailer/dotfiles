#!/bin/zsh
sudo docker rm --force pihole
sudo networksetup -setdnsservers Wi-Fi empty
networksetup -getdnsservers Wi-Fi
scutil --dns