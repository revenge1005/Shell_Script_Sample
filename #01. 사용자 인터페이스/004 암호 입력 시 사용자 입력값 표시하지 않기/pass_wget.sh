#!/bin/bash

### 사용처 ###
# 사용자가 암호를 입력하는 처리에서 문자열을 화면에 표시하고 싶지 않을 때

### 사용 명령어 ###
# stty, read, wget

### 해설 ###
# 이 스크립트는 사용자로부터 암호를 입력받아 ftp 사이트에서 파일을 내려받는다.
# 사용자의 입력을 read 명령으로 취득할 때 입력된 문자는 그대로 화면에 표시된다.
# 이는,【에코백】이라는 기능으로 입력된 문자를 화면에 표시하도록 터미널에 설정되어 있기 때문에 가능한 일이다.

username=choi
hostname=localhost

echo -n "Password: "

## 에코백 OFF 
## 에코백하지 않도록 설정하려면 stty 명령어로 -echo를 지정한다.
## 이러면 에코백되지 않아서 입력한 문자가 화면에 표시되지 않는다.
stty -echo

## 입력된 암호는 read 명령어로 변수 password에 대입된다.
read password

## 이대로 두면 에코백하지 않는 설정이 그대로 남으므로 암호 입력이 끝나면 원래 상태로 되돌린다.
## 에코백 ON 
stty echo

echo

wget --password="$password" "ftp://${username}@${hostname}/filename.txt"