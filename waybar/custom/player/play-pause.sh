#!/bin/bash

playerctl --ignore-player=firefox --follow status --format "{{status}}" 2> /dev/null |
    while read status; do
        echo **$status**
        if [[ $status == "Playing" ]]
        then
           echo "{\"class\": \"playing\", \"text\": \"$1\"}"
        elif [[ $status == "Paused" ]]
        then
           echo "{\"class\": \"paused\", \"text\": \"$2\"}"
        else
           echo "{\"class\": \"hidden\"}"
        fi
    done
