#!/bin/bash

### 사용처 ###
# 키보드에서 글자 하나가 입력되면 Enter 입력 없이 처리를 속행하고 싶을 때

### 사용 명령어 ###
# stty, dd

### 해설 ###
# 사용자에게 입력을 받고 싶을 때, read 명령을 써서 키 입력을 얻을 수 있으며 이때  반드시 줄바꿈이 필요하다. 
# (즉, 사용자 문자를 입력한 다음 Enter 키를 눌러야만 한다.)

# 단순히 YES/NO를 묻는다면 Enter 키를 누르지 않고 처리를 하고 싶을 때 【터미널 상태를 설정하는 stty 명령어】로 
# 터미널을 【raw 모드】로 하면 키 버퍼 처리를 하지 않으므로 문자마다 처리할 수 있다.

​# raw 모드로 할 때 현재 터미널 설정이 지워지므로 나중에 설정을 원래대로 돌릴 수 있도록 현재 터미널 설정을 
#【stty -g】명령어 출력 결과를 tty_state 변수에 저장한다.


echo -n "Type Your Answer [y/n]: "

## 현재 터미널 수정을 Shell 변수 tty_state에 백업하고
## 터미널을 raw 설정함 
tty_stat=$(stty -g)
stty raw

## 키보드에서 문자 하나 읽기 
##【dd 명령어】에서는 입출력 블록 크기를 1, 입력에서 출력으로 복사하는 블록 수를 1로 해서 입력된 문자를 변수 
## char에 저장, 그리고 dd 명령 실행 메시지는 필요 없으므로 /dev/null로 리다이렉트해서 버림
char=$(dd bs=1 count=1 2> /dev/null)

## 터미널 설정을 원래대로 돌림
stty "$tty_stat"

echo

## 입력된 문자에 따라 처리 분기 
case "$char" in
        [yY])
                echo "Input: Yes"
                ;;
        [nN])
                echo "Input: No"
                ;;
        *)
                echo "Input: What?"
                ;;
esac