#!/bin/bash

ICON_BLUETOOTH=""
ICON_BATTERY_FULL=""
ICON_BATTERY_THREE_QUARTERS=""
ICON_BATTERY_HALF=""
ICON_BATTERY_QUARTER=""
ICON_BATTERY_EMPTY=""

tooltip=""

value="$(based-connect C8:7B:23:A2:CC:B0 -b)"

if [[ $? != 0 ]]; then
    exit 1
fi

ICON_BATTERY=""
if [[ $value -ge 90 ]]; then
    ICON_BATTERY=$ICON_BATTERY_FULL
elif [[ $value -ge 75 ]]; then
    ICON_BATTERY=$ICON_BATTERY_THREE_QUARTERS
elif [[ $value -ge 50 ]]; then
    ICON_BATTERY=$ICON_BATTERY_HALF
elif [[ $value -ge 25 ]]; then
    ICON_BATTERY=$ICON_BATTERY_QUARTER
else
    ICON_BATTERY=$ICON_BATTERY_EMPTY
fi

tooltip=${tooltip%\\n}

echo "{\"text\": \"$ICON_BLUETOOTH $ICON_BATTERY\", \"tooltip\": \"$tooltip\"}"
