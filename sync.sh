#! /bin/bash

RCLONE_CONFIG=/home/pi/.config/rclone/rclone.conf
rclone sync -v dropbox:[Your Dropbox Folder Name] /home/pi/Videos