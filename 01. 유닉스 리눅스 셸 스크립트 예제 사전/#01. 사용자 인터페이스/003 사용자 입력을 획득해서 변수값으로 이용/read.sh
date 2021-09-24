#!/bin/bash

### 사용처 ###
# 키보드에서 입력받은 값을 써서 대화형 처리를 하고 싶을 때

### 사용 명령어 ###
# read

echo "###입력 값 하나인 경우###"
echo -n "Enter your ID : "
read id

echo -e "\n###입력 값 여러개인 경우###"
echo -n "Enter your Name, Email, Age : "
read name email age

echo -e "\nNow your ID is $id"
echo -e "Now your Name is $name, Email is $email, Age is $agea\n\n"


## 사용자 입장에서 여러 값을 한 줄로 입력하는 방식은 불편하므로, 하나씩 입력으로 하자
echo -n "Enter your ID: "
read id
echo -n "Enter your Name: "
read name
echo -n "Enter your Email: "
read email

echo -e "\nNow your ID is $id."
echo "Name: $name, Email: $email"


## read 명령어를 실행하면 사용자 입력을 기다리므로 스크립트 실행이 일시정지 된다. 
## 따라서 처음 단순히 스크립트를 일시정지하고 싶을 때에도 read 명령어를 이용하기도 한다. 
## 이때 입력값은 필요 없으므로 대입하는 쉘 변수 더미(dummy) 이다.
echo "Input any Key to continue ..."
read dummy
echo "Script start."