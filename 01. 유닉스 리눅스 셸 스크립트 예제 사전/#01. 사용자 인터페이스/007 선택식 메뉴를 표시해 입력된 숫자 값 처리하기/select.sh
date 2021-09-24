#!/bin/bash

### 사용처 ###
# 입력값을 써서 대화식 처리를 화고 싶을 때

### 사용 명령어 ###
# read, case

### 해설 ###
# 번호가 적힌 메뉴를 표시해서 사용자에게 값을 입력받아서 지정한 번호를 처리한다.

while :
do
        echo "Menu:"
        echo "1) list file"
        echo "2) current directory"
        echo "3) exit"

        read number
        case $number in
                1) ls ;;
                2) pwd ;;
                3) exit ;;
                *) echo "Error: Unknown Command" ;;
        esac

        echo
done