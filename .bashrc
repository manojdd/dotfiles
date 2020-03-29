if systemctl -q is-active graphical.target && [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
  exec startx
fi

alias fp="firefox -private-window"
alias ko="killall xinit"

alias vpnoff="sudo systemctl stop wg-quick@*"
alias start="sudo systemctl start"
alias stop="sudo systemctl stop"
alias mplayer="mplayer -lavdopts threads=4 00006.MTS"
