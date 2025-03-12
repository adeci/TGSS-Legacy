#!/bin/bash
echo "Starting srb2k Server"
# start srb2k dedicated server with modfiles in order loadfirst->chars->tracks->loadlast
shopt -s globstar && shopt -s nocaseglob && shopt -s nullglob && /home/server/game_servers/srb2k/lsdl2srb2kart -dedicated -file /home/server/.srb2kart/mods/loadfirst/* /home/server/.srb2kart/mods/chars/* /home/server/.srb2kart/mods/tracks/* /home/server/.srb2kart/mods/loadlast/*
