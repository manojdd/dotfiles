  # Fixes IntelliJ rendering issue. See https://wiki.archlinux.org/index.php/Java#IntelliJ_IDEA
  wmname compiz
  feh --recursive --randomize --bg-fill ~/pictures/wallpapers/

  cpu() {
    #echo -e "💻 $(top -bn1 | sed -n '/Cpu/p' | awk '{print $2}' | sed 's/..,//')%"
    echo -e " $(top -bn1 | sed -n '/Cpu/p' | awk '{print $2}' | sed 's/..,//')%"
  }
  mem() {
  echo -e "$(free -m | awk '/Mem/ {printf "🧠 %d%", $3*100/$2}')"
  }
  temp() {
  echo -e 🌡️CPU "$(sensors | awk '/Tdie/ {print substr($2, 2)}') GPU $(nvidia-settings -q gpucoretemp -t | head -n 1)" 
  }
  volume() {
    echo -e "🔊 $(amixer get Master | grep -o "[0-9]*%")"
  }
  
  packages() {
    echo -e $(pacman -Qu | grep -v "\[ignored\]" | wc -l | sed "s/^/📦/;s/^📦0$//g")
  }

  datetime() {
  echo -e "📅 $(date +'%a %b %d %l:%M:%S %p')"
  }

  vpn() {
      IF=$(ip addr | grep inet)
      if [ "$IF" != "$PREV_IF" ]; then
        PREV_IF=$IF   
        # IP_INFO=$(curl -s https://am.i.mullvad.net/json | jq) IP_BAR=echo $([[ $(jq -r '.mullvad_exit_ip' <<< $IP_INFO) = "true" ]]) && echo "VPN:"$(jq -r '.city' <<< $IP_INFO) &
        # exec 3< <(curl -s https://am.i.mullvad.net/json | jq -c &)
        # IP_INFO=$(read <&3 line; echo "$line";)
        # IP_BAR=$(echo $([[ $(jq -r '.mullvad_exit_ip' <<< $IP_INFO) = "true" ]]) && echo "🔒"$(jq -r '.city' <<< $IP_INFO))
      fi
      echo -e "$IP_BAR"
  }

numlockx &
dunst &
picom &
  while true;
  do
  #exec dwm 2>~/.dwm.log

    IF=$(ip addr | grep inet)
    if [ "$IF" != "$PREV_IF" ]; then
        echo "Calling VPN api at $(date)" >> ~/status.log
        PREV_IF=$IF
        IP_INFO=$(curl -s https://am.i.mullvad.net/json | jq)
        # IP_BAR=$(echo $([[ $(jq -r '.mullvad_exit_ip' <<< $IP_INFO) = "true" ]]) && echo "VPN:"$(jq -r '.city' <<< $IP_INFO))
        # IP_BAR=$(echo $([[ $(echo $IP_INFO | jq -r '.mullvad_exit_ip') = "true" ]]) && echo "VPN:"$(echo $IP_INFO | jq -r '.country'))
        MULLVAD_CONNECTED="$(echo $IP_INFO | jq -r '.mullvad_exit_ip')"
        if [ $MULLVAD_CONNECTED = "true" ]; then
          IP_BAR="🔒$(echo $IP_INFO | jq -r '.country')";
        else
          IP_BAR="🔓$(echo $IP_INFO | jq -r '.country')";
        fi

        # IP_INFO=$(curl -s https://am.i.mullvad.net/json | jq) IP_BAR=echo $([[ $(jq -r '.mullvad_exit_ip' <<< $IP_INFO) = "true" ]]) && echo "VPN:"$(jq -r '.city' <<< $IP_INFO) &
        # exec 3< <(curl -s https://am.i.mullvad.net/json | jq -c &)
        # IP_INFO=$(read <&3 line; echo "$line";)
        # IP_BAR=$(echo $([[ $(jq -r '.mullvad_exit_ip' <<< $IP_INFO) = "true" ]]) && echo "VPN:"$(jq -r '.city' <<< $IP_INFO))
    fi
  # xsetroot -name "$(status)"
  xsetroot -name "$(packages) | $(temp) | $(volume) | $IP_BAR | $(cpu) | $(mem) | $(datetime); $(cat /tmp/bottombar)"
  sleep 1s;
  done &

  #exec dwm
  # Run dwm in a loop, allows you to restart dwm without killing the session. To kill the session, run `killall xinit`
  while true;
  do
  dwm 2> ~/.dwm.log
  done
#xautolock -time 1 -locker i3lock -notify 30 -corners ---- &

#🌡

#while true; do echo 🌡️CPU "$(sensors | awk '/Tdie/ {print substr($2, 2)}') GPU $(nvidia-settings -q gpucoretemp -t | head -n 1)" > /tmp/bottombar; sleep 1s; done

