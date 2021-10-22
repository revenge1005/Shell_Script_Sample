#/bin/bash

### 사용처 ###
# 2월 말에 작성된 로그 파일을 선택하고 싶을 때

### 사용 명령어 ###
# expr, test, ls

### 해설 ###
# 이 스크립트는 2월 말일 파일을 표기하기 위해 올해가 윤년인지 판별한다.

# access.log-20210505 처럼 파일명에 년월일이 있는 로그 파일이 log/myapp 디렉토리에 저장되어 있다고 가정한다.

################################################################################################################################################################

# 네 자리 년도 얻기
year=$(date '+%Y')                                         #     (1)

logfile="log/myapp/access.log-"  

# 년도를 나눈 나머지 계산
mod1=$(expr $year % 4)                                     #   ┐
mod2=$(expr $year % 100)                                   #   │ (2)
mod3=$(expr $year % 400)                                   #   ┘

# 윤년인지 판정
if [ $mod1 -eq 0 -a $mod2 -ne 0 -o $mod3 -eq 0 ]; then     # (3)
    echo "leap year: $year"
    ls "${logfile}${year}0229"                             # (4)
else
    echo "not leap year: $year"
    ls "${logfile}${year}0228"                             # (5)
fi

################################################################################################################################################################

# 월말에 로그 파일을 참조해서 월별 처리를 하는 일이 많을 것이다.
# 예제처럼 파일안에 날짜가 적힌 로그파일을 다룰 때 2월 말일인지 판단하는 것은 프로그래머의 공통된 고민거리이다.

# 윤년인지 판정하는 조건
# 1) 서력이 4로 나눠 떨어지면 윤년
# 2) 단, 100으로 나눠 떨어지면 윤년이 아님
# 3) 단, 400으로 나눠 떨어지면 윤년임

# (1)에서 서력을 네 자리로 취득해서 셸 변수 year에 대입한다.

# (2)에서 년도를 나눈 나머지를 expr 명령어로 계산한다. 
# expr 명령어로 % 연산자를 써서 나머지를 계산하는데 조건 1,2,3의 각 나머지 값을 셸 변수 mod1,mod2,mod3에 대입한다.

# (3)에서는 앞에서 본 윤년 조건을 if문으로 판정한다.
# 나눠 떨어진다라는 것은 나머지가 0이라는 뜻으므로 0과 변숫값을 비교한다.
# 값이 같은지는 -eq, 같지 않은지는 -ne 연산자로 판별한다.
# -a는 AND, -o는 OR를 뜻한다.
# (3) 조건식은 "mod1 값이 0이고 mod2값은 0이 아니다" 또는 "mod3이 0"이라는 조건을 뜻한다.

# (4)와 (5)에서 윤년일 때는 2월 29일 로그 파일을, 윤년이 아니면 2월 28일 로그 파일을 ls 명령어로 표시한다.