#!/bin/bash

### 사용처 ###
# 환경변수가 설정되었으면 그 값을 쓰고 설정되지 않았으면 스크립트에서 정한 기본값을 사용하고 싶을 때

### 사용 명령어 ###
# cp, tar

### 해설 ###
# 이 스크립트는 변수 TMPDIR 값을 확인해서 설정값이 있으면 그 값을, 설정되어 있지않거나 빈 문자열이면 /tmp를 작업 디렉토리로 하여 아카이브 파일을 푼다.


cp largefile.tar.gz ${TMPDIR:=/tmp}                       ## -------------(1)------------- ##
cd $TMPDIR
tar xzf largefile.tar.gz

echo "Extract files to $TMPDIR."


## (1)에 있는 ":=" 는 변수에 값이 설정되어 있는지 확인해서 값이 대입한다.

## "${변수명:=값}" 이라고 적으면 변수가 설정되어 있지 않거나 비어 있을 때는 지정한 값을 대입한다.

## 즉, 환경변수 TMPDIR에 /var/tmp라는 값이 미리 설정되어 있으면 작업 디렉토리는 /var/tmp가 된다.

## 한편, 환경변수 TMPDIR에 값이 설정되어 있지 않거나 빈 문자열이면 스크립트는 기본값으로 정한 /tmp를 작업 디렉토리로 사용한다.


### 변수 연산자 ###
# 1) ${varname}         - varname에 해당하는 변수 치환이 이루어짐

# 2) ${varname:=value}  - varname의 값이 null이면 value 값으로 할당, 만약 null이 아니면 기존의 값을 그냥 사용

# 3) ${varname:+value}  - varname의 값이 null이 아니면 value 값으로 할당, null 이라면 값을 varname에 할당하지 않음

# 4) ${varname:-value}  - varname의 값이 null 이라면 기존의 값을 그냥 사용, null이 아니면 value의 값을 varname에 할당하지 않음

# 5) ${varname:?value}  - varname의 값이 null이면 value의 값을 오류 메시지로 출력하고 프로그램 종료