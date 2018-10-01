#!/bin/bash

# 'BEHIND_PROXY' is set to true if the environment is behind a proxy.
BEHIND_PROXY=false

if [ ${BEHIND_PROXY} ]; then
  # mod your proxy info
  USER=XXXXXXXXXXXX
  PW=XXXXXXXXXXXX
  SV=XXXXXXXXXXXX.com
  PORT=8080

  # curl
  echo "proxy=http://${USER}:${PW}@${SV}:${PORT}" > ~/.curlrc
  # yum
  sudo tee -a /etc/yum.conf << EOS
proxy = http://${SV}:${PORT}
proxy_username = ${USER}
proxy_password = ${PW}
EOS
  # wget
  sudo tee -a /etc/wgetrc << EOS
http_proxy= http://${USER}:${PW}@${SV}:${PORT}/
https_proxy= http://${USER}:${PW}@${SV}:${PORT}/
ftp_proxy = http://${USER}:${PW}@${SV}:${PORT}/
EOS

fi

