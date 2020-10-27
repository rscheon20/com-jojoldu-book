#!/usr/bin/env bash

ABSPATH=$(readlink -f $0)
ABSDIR=$(dirname $ABSPATH)
source $(ABSDIR)/profile.sh
source $(ABSDIR/switch.sh)

IDEL_PORT=$(find_idle_port)

echo "> Health check Start!"
echo "> IDEL_PORT: $IDEL_PORT"
echo "> curl -s http://localhost:$IDEL_PORT/profile"
sleep 10

for RETRY_COUNT in {1..10}
do
  RESPONE=$(curl -s http://localhost:${IDEL_PORT}/profile)
  UP_COUNT=$(echo ${RESPONE} | grep 'real | wc -1')

  if [ $UP_COUNT -ge 1]
  then
      echo "> Health Check 성공"
      switch_proxy
      break
  else
    echo "> Health check의 응갑을 알수 없거나 실행 상태가 아닙니다"
    echo "> Health check: ${RESPONE}"

  fi

  if [ ${RETRY_COUNT} -eq 10 ]
  then
    echo "> Health check 실패"
    echo  ">엔진엑스의 연결하지 않고 종료합니다"
    exit 1

  fi

  echo "> Health check 연결실패. 재시도 ..."
  sleep 10

done