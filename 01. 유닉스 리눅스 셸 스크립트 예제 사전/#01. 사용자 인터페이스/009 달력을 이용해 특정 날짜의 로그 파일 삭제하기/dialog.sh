#!/bin/bash

### 사용처 ###
# 날짜를 지정하는 대화식 달력을 표시해서 선택하고 싶을 때

### 사용 명령어 ###
# dialog, awk

### 해설 ###
# 이 스크립트는 달력을 표시하고 날짜를 선택받아 그 날짜가 파일명에 있는 로그 파일을 삭제한다.

LOG_DIR=/myapp/ap1/log

## dialog 명령어로 달력 출력 
## 선택한 날짜는 표준 에러 출력이므로 임시 파일에 리다렉트 
## "dialog  --calender  text  height  width"
## text : 표시할 문자 메시지  /  height : 문자 메시지 줄 수  /  width : 다이얼로그 박스 폭
##【dialog 명령어】선택 결과는 표준 에러 출력으로 출력되므로 이 값을 나중에 rm 명령어 인수로 사용하기 위해 임시 파일로 리다이렉트 한다.
##【dialog 명령어】가 출력하는 날짜는 일/월/년 순서로 출력됨
dialog --calendar "Select Data" 2 60 2> cal.tmp                         # ----- (1) ----- # 

## 달력 기능은 일/월/년 형식으로 출력되므로 년원일로 바꿈
##【awk 명령어】 뒤 -F 옵션을 써서 /를 구분자로 지정, $1에 10, $2에 12, $3에 2020 라는 값이 들어감
date_str=$(awk -F / '{print $3$2$1}' cal.tmp)                           # ----- (2) ----- # 

## 취소되면 임시 파일을 삭제하고 종료
## (3)은 다이얼로그에서 취소할 때 아무것도 하지 않고 종료하는 처리, 달력 선택에서 <Cancel>을 누르면 cal.tmp가 
## 비게 되므로 변수 date_str 값도 빈 문자열이 되어 빈 문자열인가 판단해서 비었으면 임시 파일을 삭제하고 스크립트 종료
if [ -z "$date_str" ]; then                                             # ----- (3) ----- # 
        rm -f cal.tmp
        exit
fi

## (4)에서 지정한 날짜의 파일을 삭제한다.
rm -i ${LOG_DIR}/app_log.$date_str                                      # ----- (4) ----- #

## 임시 파일 삭제
rm -f cal.tmp