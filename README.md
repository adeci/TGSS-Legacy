# **TGSS-Legacy**
**Tmux Game Server Scripts (Legacy)**  

This repository contains a collection of shell scripts for managing game servers using **tmux**.  
It's a rather dirty way of handling things, abusing **tmux** for process management, but it works alright.  
These scripts are **unmaintained** but may still be useful for those who need a simple way to run multiple game servers.  

## **Overview**
- Uses **tmux** to manage multiple game server sessions on a shared socket such that any server user can easily attach and manage any game session.
- Requires a dedicated server user (**`server`**) under which all game servers run.  
- Automatically starts configured servers at boot via **cron**.
- Contains some tweaked scripts to run and manage a few game servers that may save some time for someone.

---

## **Setup**
1. **Ensure a dedicated `server` user exists**
2. **Organize the game server content and server scripts somewhere**
3. **Add aliases to make interacting with the shared socket easier**

---

## **Aliases**
Bash or Zsh rc:
```
alias serverattach="tmux -S /var/tmux/shared-socket attach -t"
alias sa="tmux -S /var/tmux/shared-socket attach -t"

alias serverlist="tmux -S /var/tmux/shared-socket list-sessions"
alias sl="tmux -S /var/tmux/shared-socket list-sessions"

alias serverkill="tmux -S /var/tmux/shared-socket kill-session -t"
alias sk="tmux -S /var/tmux/shared-socket kill-session -t"

alias servernew="tmux -S /var/tmux/shared-socket new-session -d -s"
alias sn="tmux -S /var/tmux/shared-socket new-session -d -s"

# Command I use to start the servers as a different user
# Makes sure the server process is owned by server user
# Replace start_servers.sh with wherever you put it
alias startservers="sudo -u server /home/server/server_scripts/start_servers.sh && sl"
```
---

## **Crontab**
Ensure the specified servers start up on system reboot and maybe use some of the included scripts/your own to periodically restart servers for performance. Examples below.
```sh
# Starts all the servers that are set up on boot
@reboot /home/server/server_scripts/start_servers.sh 

# Restarts Palworld server every 6 hours and reruns start_servers
0 */6 * * * /home/server/server_scripts/palworld/kill_server_session.sh && /home/server/server_scripts/start_servers.sh 

# Restarts Minecraft1 server at 5 AM and 5 PM
0 5,17 * * * /home/server/server_scripts/minecraft/kill_minecraft_server_1.sh >> /home/server/server_scripts/start_servers.log 2>&1 && /home/server/server_scripts/start_servers.sh
```
---

## **Final Notes**
I have since migrated away from this architecture for server hosting as it is not ideal nor a clean solution due to undermining systemd process management and needing to bake in hacky solutions to things that could be achieved with basic syscalls. However, it does work well with very minimal effort if you can do the very basics with tmux.
