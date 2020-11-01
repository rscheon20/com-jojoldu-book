#!/usr/bin/env bash

ABSPATH=$(readlink -f $0)
ABSDIR=$(dirname $ABSPATH)
source ${ABSDIR}/profile.sh

function switch_proxy() {
  IDEL_PORT=$(find_idle_port)

  echo "> 전환할 port:  $IDEL_PORT"
  echo "> Port전환"
  echo "set \$service_url http://127.0.0.1:${IDEL_PORT};" | sudo tee /etc/nginx/conf.d/service_url.inc

  echo "> 엔진엑스 Reload"
  sudo systemctl reload nginx
}