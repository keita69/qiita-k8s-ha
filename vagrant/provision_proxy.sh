#!/bin/bash

# 'BEHIND_PROXY' is set to true if the environment is behind a proxy.
BEHIND_PROXY=true

if [ ${BEHIND_PROXY} ]; then
  # mod your proxy info
  USER=XXXXXXXXXXX
  PW=XXXXXXXXXXX
  SV=XXXXXXXXXXX
  PORT=8080

  # environment for all user
  sudo tee -a  /etc/profile << EOS
export http_proxy=http://${USER}:${PW}@${SV}:${PORT}/
export https_proxy=http://${USER}:${PW}@${SV}:${PORT}/
export no_proxy=localhost,192.168.*,127.0.*,172.16.*
export HTTP_PROXY=http://${USER}:${PW}@${SV}:${PORT}/
export HTTPS_PROXY=http://${USER}:${PW}@${SV}:${PORT}/
export NO_PROXY=localhost,192.168.*,127.0.*,172.16.*,10.96.0.0/12,10.244.0.0/16
EOS

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

