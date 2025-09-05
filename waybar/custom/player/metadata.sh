#!/bin/bash

pkill playerctl
playerctl --ignore-player=firefox --follow metadata --format "{{xesam:title}} - {{xesam:artist}}" 2> /dev/null |
    while read text;
    do
        if [[ $text == "n" ]]
        then
            echo "{\"class\": \"hidden\"}"
        else
            echo "{\"text\": \"$text\"}"
        fi
    done
