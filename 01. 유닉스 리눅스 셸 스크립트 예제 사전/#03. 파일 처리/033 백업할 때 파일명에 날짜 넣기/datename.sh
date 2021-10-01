#/bin/bash

### 사용처 ###
# 어떤 파일을 백업할 때 현재 날짜를 넣어서 간단히 복사해두고 싶을 때
### 사용 명령어 ###
# date, cp

### 해설 ###
# 이 스크립트는 현재 디랙토리에 있는 myapp.conf 라는 설정 파일을 백업한다.
# 실행하면 현재 날짜를 이용해서 파일명을 조합해 myapp.conf.20211001, 즉 "원래파일명+날짜" 형식으로 복사본을 작성한다.

################################################################################################################################################################

config="myapp.conf"

back_filename="${config}.$(date '+%Y%m%d')"

# 이미 myapp.conf.20211001 등이 있으면 초까지 넣어서 백업 파일 설정
if [ -e $back_filename ]; then
    back_filename="${config}.$(date '+%Y%m%d%H%M.%S')"
fi

cp -v "$config" "$back_filename"

################################################################################################################################################################

# date 명령어에서 자주 사용하는 필드명
# %Y : 년 (1970년~)
# %y : 년도 아래 두 글자 (00~99)
# %m : 월 (01~12)
# %d : 일 (01~31)
# %H : 시 (00~23)
# %M : 분 (00~59)
# %S : 초 (00~59)

################################################################################################################################################################

#### 주의사항

# 이 스크립트에서 초까지 파일명에 사용하므로 1초 이내 두 번 이상 실행되면 파일을 덮어쓰게 된다.
# 파일명 뒤에 1,2,3 ... 식으로 연번을 붙이는 방법도 있지만 이 방법은 언제 변경되었는지 한번에 알아보기 어렵고 
# 게다가 설정 파일 백업용이라서 1초 이내 갱신될 일도 없으므로 이 예제에서는 이미 파일이 존재하면 시분초를 붙이는 방법을 사용한다.

# 날짜로 백업 파일을 만드는 것은 간단해서 자주 쓰이는 방법이지만 임기응변이기도 한다.
# 제대로 하려면 Git이나 서브버전(Subversion) 같은 버전 관리 시스템으로 관리하는 것이 옳다.