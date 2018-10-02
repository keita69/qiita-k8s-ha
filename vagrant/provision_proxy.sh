#!/bin/bash

# please set ${PROXY_USER}, if your environment is behind proxy. 

if [ -n "${PROXY_USER}" ]; then
  # mod your proxy info
  USER=${PROXY_USER}
  PW=${PROXY_PW}
  SV=${PROXY_SERVER}
  PORT=${PROXY_PORT}
  
  # environment for all user
  sudo tee -a  /etc/profile << EOS
http_proxy=http://${USER}:${PW}@${SV}:${PORT}/
https_proxy=${http_proxy}
no_proxy=localhost,192.168.*,127.0.*,172.16.*
HTTP_PROXY=${http_proxy}
HTTPS_PROXY=${https_proxy}
NO_PROXY=${no_proxy}
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

