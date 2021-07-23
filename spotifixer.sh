#!/bin/bash
# Start client if not running
if ! pgrep -x "spotify" > /dev/null
then
    spotify &
    sleep 1
fi
if [ $# -eq 1 ]
then
    qdbus org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Pause && qdbus org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.OpenUri "string:$1"
fi
