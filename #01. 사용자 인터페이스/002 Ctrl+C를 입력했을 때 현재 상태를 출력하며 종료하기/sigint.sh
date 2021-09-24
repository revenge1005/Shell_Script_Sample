#!/bin/sh

### 사용처 ###
# 시간이 오래 걸리는 처리나 무한 반복 처리에서 사용자가 도중에 끝내기 위해 'Ctrl+C' 키를 입력 하더라도 종료하기 전에 어떤 처리를 하고 싶을 때


## 명령행 인수로 지정한 URL에 1초에 한 번씩 curl 명령어로 접근하고, 키보드 'Ctrl + C'가 입려되면 동작을 멈추고 지금까지 접근한 횟수를 표시
count=0

## SIGINT를 받은 프로세스는 종료되지만, Shell 스크립트에서는 시그널을 받을 때 동작을 'trap' 명령어로 제어 가능 
## 사용법 -> trap '하고 싶은 처리' 시그널
trap ' echo
        echo "Try count: $count"
        exit ' INT

while :
do
        ## curl 명령어로 1초마다 한 번씩 웹 사이트에서 내려받아서 통신이 정상인지 확인하는 스크립트
        curl -o /dev/null $1
        echo ""
        count=$(expr $count + 1)
        sleep 1
done
