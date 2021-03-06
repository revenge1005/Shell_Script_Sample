#/bin/bash

### 사용처 ###
# 오늘 날짜에서 지난달 년월표기(YYYYMM)을 조합해서 해당 날짜가 파일명에 있는 로그 파일을 아카이브하고 싶을 때

### 사용 명령어 ###
# date, tar

### 해설 ###
# 이 스크립트는 오늘 날짜를 기준으로 해서 지난달 년월표기(YYYYMM)를 조합해서 로그 파일에 지난달 분량을 아카이브한다.

################################################################################################################################################################

logdir="log/myapp"

# 이번달 15일 날짜 취득
thismonth=$(date '+%Y/%m/15 00:00:00')                                    # (1)

# 지난달 15일 YYYMM으로 취득
# 1 month age는 지난달의 같은 '날(일)'이 되므로 망ㄹ일을 피하도록
# 변수 thismonth에 15일을 지정함
last_YYYYMM=$(date -d "$thismonth -1 month ago" '+%Y%m')                  # (2)

# 지난달 로그 파일을 아카이브
tar cvf ${last_YYYYMM}.tar ${logdir}/access.log-${last_YYYYMM}*           # (3)

################################################################################################################################################################

# 지난달 날짜 표기를 얻고 싶다면 리눅스에서는 date 명령어 -d 옵션으로 한 달전을 뜻하는 "1 month ago"를 지정하면 편하다.
# 하지만 이 옵션을 사용할 때는 주의해야 할 사항이 있다.

# date 명령 "1 month ago" 실패 예제
# $ date "+%Y%m%d %H%M:%S"
# 2021/03/30 00:00:05
# $ date "+%Y%m%d %H%M:%S" "1 month ago"
# 2021/03/02 00:00:05

# 이 결과 처럼 3월 30일에 date -d "1 month ago"를 실행해도 2월 말인 2월 28일이 되지 않으며, 
# 이것은 리눅스 date 명령어로 "1 month ago"를 지정하면 지난달의 같은 날을 취득하기 때문이다.

# (오늘) 3월 30일  --------------->  2월 30일 ?  --------------->  3월 2일
#                      1개월 전                2월 28일 + 2일로 해석

# 이런 상황이 발생하지 않도록 모든 달에 존재하는 날짜를 지정해서 "1 month ago"를 사용한다. (즉, 1일~28일 중 하루를 지정한다.)

################################################################################################################################################################

# (2)에서 앞서 15일로 지정한 이번달 날짜에서 지난달을 얻기 위해 date "1 month ago" 날짜랄 얻는다.
# '+%Y%m'을 지정해서 지난달로 년월표기(YYYYMM)를 얻는다.

# (3)에서 지난달 날짜로 로그 파일을 아카이브한다.

