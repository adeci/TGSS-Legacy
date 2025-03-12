#!/bin/bash
echo "Checking for Palworld updates..."
/usr/games/steamcmd +force_install_dir '/home/server/Steam/steamapps/common/PalServer' +login anonymous +app_update 2394010 +quit
sleep 5s
echo "Starting Palworld server"
/home/server/Steam/steamapps/common/PalServer/PalServer.sh -useperfthreads -NoAsyncLoadingThread -UseMultithreadForDS > /dev/null
