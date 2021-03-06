#!/bin/bash
Port=9231
pid=`ps ax | grep gunicorn | grep $Port | awk '{split($0,a," "); print a[1]}' | head -n 1`
if [ -z "$pid" ]; then
  echo "no gunicorn deamon on port $Port"
else
  kill $pid
  echo "killed gunicorn deamon on port $Port"
fi

# Author of this code -- 'takasoft' user on StackOverflow
# https://stackoverflow.com/questions/14604653/how-to-stop-gunicorn-properly