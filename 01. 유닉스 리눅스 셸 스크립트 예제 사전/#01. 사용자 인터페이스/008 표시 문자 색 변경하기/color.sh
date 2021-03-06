#!/bin/bash

### 사용처 ###
# 메시지 표시에 문자색을 바꾸거나 반전시키기 등 주의를 끌고 싶을 때

### 사용 명령어 ###
# echo

### 해설 ###
# Important Message 라는 문자열을 빨강색으로 표시

echo "Script Start."

## 배경색을 회색(47), 문자색을 빨강(31)으로 바꿈
echo -e "\033[47;31m Important Message \033[0m"

echo "Script End."

## Shell 스크립트에서 문자열을 표시할 때 echo 명령을 사용하고 이때 메시지 일부를 강조하고 싶다면 -e 옵션을 지정해서 【이스케이프 시퀀스】라는 제어 코드로 표시할 문자에 색을 입힐 수 있다.

##       "  \033[파라미터m        표시할_문자열       \033[0m   "

## 파라미터를 여러 개 지정할 때는 ; 으로 나열하며, 위 예제에서 파라미터로 31번과 47번을 합쳐서 지정함

## 문자색 지정을 초기화하려면 0을 지정하여 " \033[0m "이라고 작성해야 한다. 

## 이렇게 안하면 그 이후 모든 문자색이 변하므로 위 문자열 끝에 작성하는 것이 일반적이다.

## 색 지정 번호는 30번대가 문자색(Foreground Color), 40번대가 배경색(Background Color)이다.
## (이런 번호는 리눅스에서 " man console_codes " 으로 확인 가능)