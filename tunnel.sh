#!/bin/bash


# call it with `startTunnel &` to run it in the background
function startTunnel() {
  while true
  do
    ssh -R 1800:192.168.155.1:1800 -N user@somehost.com
    exit_code=$?
    if [ $exit_code -eq 137 ]; then
       echo "Received exit code kill signal, not restarting"
       break
    fi
  done
}

function stopTunnel() {
  ps -Af | grep 'ssh' | grep -v 'sshd' | grep -v 'grep' | awk '{print $2}' | xargs kill -9 $2
}
