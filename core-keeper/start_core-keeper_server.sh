#!/bin/bash
echo "Checking for Core-Keeper updates..."
/usr/games/steamcmd +login anonymous +app_update 1963720 +quit
sleep 5s
echo "Starting Core-Keeper server"
/home/server/Steam/steamapps/common/Core\ Keeper\ Dedicated\ Server/_launch.sh
