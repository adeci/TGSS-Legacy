#!/usr/bin/expect

set force_conservative 0  ;# set to 1 to force conservative mode even if
                          ;# script wasn't run conservatively originally
if {$force_conservative} {
        set send_slow {1 .1}
        proc send {ignore arg} {
                sleep .1
                exp_send -s -- $arg
        }
}

set timeout -1
spawn /home/server/game_servers/terraria_server/start-tModLoaderServer.sh

expect -exact "Use steam server (y/n): "
send -- "n\r"
expect -exact "Choose World: "
send -- "1\r"
expect -exact "Max players (press enter for 16): "
send -- "16\r"
expect -exact "Server port (press enter for 7777): "
send -- "7777\r"
expect -exact "Automatically forward port? (y/n): "
send -- "n\r"
expect -exact "Server password (press enter for none): "
send -- "12\r"

interact
