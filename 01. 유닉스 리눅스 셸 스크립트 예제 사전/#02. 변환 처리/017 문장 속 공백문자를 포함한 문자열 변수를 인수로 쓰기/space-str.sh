#!/bin/bash

### 사용처 ###
# 공백문자를 포함한 문자열을 한 문장으로 다루고 싶을 때

### 사용 명령어 ###
# echo

### 해설 ###
# 이 스크립트는 공백문자를 포함한 문자열을 if문으로 비교해서 값이 "invalid value" 라는 문자열일 때 에러를 출력
# 공백을 포함한 문자열 취급이 핵심이다.
# 셸 스크립트에서 변수 구분자는 셸 변수 IFS로 정의하는데 기본값은 공백 기호, 탭, 줄바꿈이 지정되어 있다.
# 즉, 공백문자는 변수의 구분자를 뜻하는 특별한 의미가 있다.
# 그러므로 공백문자가 포함된 문자열이 저장된 변수를 따옴표 처리하지 않으면 쪼개진 것처럼 인식하여 생각과 다른 동작을 할 수도 있다.

result="invalid value"

if [ "$result" = "invalid value" ]; then
        echo "ERROR: $result" 1>&2
        exit 1
fi


# shell 스크립트에서 변수 구분자는 쉘 변수 IFS로 정의하는데 기본값은 공백 기호, 탭, 줄 바꿈이 지정되어 있다.
# 즉, 공백 문자는 변수의 구분자를 뜻하는 특별한 의미가 있다.

# 그러므로 공백 문자가 포함된 문자열이 저장된 변수를 따옴표 처리하지 않으면 쪼개진 것처럼 인식하여 생각과 다른 동작을 할 수도 있다.