# total commander
alias smc="sudo mc";
# change directory
alias ..='cd ..'
alias ...='cd ../../../'
alias ....='cd ../../../../'
alias .....='cd ../../../../'
alias .4='cd ../../../../'
alias .5='cd ../../../../..'
alias c='clear'
alias ls='ls --color=auto'
alias l.='ls -d .* --color=auto'
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias bc='bc -l'
# alias sshgen %u ='ssh-keygen -t rsa -b 8192 %u'
# keygen
alias rssh='exec bash'
alias cmd='sudo bash ~/.cmd_shell.sh'
alias tcmd='bash ~/.cmd_wp1.sh'
alias ecmd='sudo nano ~/.cmd_wp1.sh'
alias rm_tmp='sudo apt-get autoremove && sudo apt-get autoclean && sudo find /tmp/* -type f -atime +1 -delete && sudo journalctl --vacuum-size=100M && sudo journalctl --vacuum-time=1days && sudo find ~/.cache/* -type f -atime +1 -delete'
alias rewifi='sudo ifdown wlp3s0 |sleep 10 | sudo ifup wlp3s0'
# https://www.cyberciti.biz/faq/linux-list-users-command/
# https://phoenixnap.com/kb/how-to-list-users-linux 
alias all_users='cut -d: -f1 /etc/passwd'
alias rm_app='echo -e "y\n" & sudo apt autoremove & sudo apt clean & sudo apt autoclean & sudo apt install -f & sudo dpkg --configure -a | sudo apt update & sudo aptitude update & sudo aptitude upgrade'
alias t-start='sudo service transmission-daemon start'
alias t-stop='sudo service transmission-daemon stop'
alias t-reload='sudo service transmission-daemon reload'
alias t-list='transmission-remote -n 'transmission:transmission' -l'
alias t-basicstats='transmission-remote -n 'transmission:transmission' -st'
alias t-fullstats='transmission-remote -n 'transmission:transmission' -si'
