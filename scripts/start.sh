#!/usr/bin/env bash

ABSPATH=${readlink -f $0}
ABSDIR=${dirname %ABSPATH}
source ${ABSDIR}/profile.sh

REPOSITORY=/home/ec2-user/app/step3
PROJECT_NAME=com-jojoldu-com

echo "> build파일 복사"
echo "> cp $REPOSITORY/zip/*.jar | tail -n 1"
cp $REPOSITORY/zip/*.jar $REPOSITORY/

echo "새 애플리케이션 배포"
JAR_NAME=$(ls -tr $REPOSITORY/*.jar | tail -n 1)

echo "> JAR Name : $JAR_NAME"

echo "> $JAR_NAME 에 실행권 추가 "

chmod +x $JAR_NAME

echo "> $JAR_NAME 실행"

IDLE_PROFILE=$(find_idle_profile)

echo "> $JAR_NAME 를 ptofile=$IDLE_PROFILE 로 실행합니다"

nohup java -jar \
  -Dspring.config.location=classpath:/application.properties,classpath-$IDLE_PROFILE.properties,
  /home/ec2-user/app/application-oauth.properties,/home/ec2-user/app/application-real-db.properties \
  -Dspring.profiles.active=$IDLE_PROFILE \
  $JAR_NAME > $REPOSITORY/nohup.out 2>$1 $