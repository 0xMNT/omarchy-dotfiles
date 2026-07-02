#!/bin/bash

EXTERNAL="HDMI-A-1"
INTERNAL="eDP-1"
EXTERNAL_WORKSPACES="1 2 3 4 5"

move_workspaces_to() {
    local monitor=$1
    for ws in $EXTERNAL_WORKSPACES; do
        hyprctl dispatch moveworkspacetomonitor "$ws $monitor"
    done
}

handle() {
    case $1 in
        monitoradded*"$EXTERNAL"*)
            move_workspaces_to "$EXTERNAL"
            ;;
        monitorremoved*"$EXTERNAL"*)
            move_workspaces_to "$INTERNAL"
            ;;
    esac
}

socat -u "UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock" - \
    | while read -r line; do handle "$line"; done
