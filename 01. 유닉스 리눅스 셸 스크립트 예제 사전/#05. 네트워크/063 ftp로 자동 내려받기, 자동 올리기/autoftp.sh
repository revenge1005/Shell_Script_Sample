#/bin/bash

### 사용처 ###
# ftp로 파일 연계하는 시스템에서 로그인 처리나 파일 내려받기, 올리기를 자동화하고 싶을 때

### 사용 명령어 ###
# ftp

### 해설 ###
# 이 스크립트는 지정한 FTP 서버에서 ftp 명령어를 이용해서 자동으로 파일을 내려받는다.

# 스크립트 셸 변수로 접속할 FTP 서버나 계정 정보를 지정하면 자동으로 로그인해서 파일을 내려받는다.

################################################################################################################################################################

# FTP 접속
server="192.168.219.110"
user="choi"
password="1234"                          # (1)
dir="/home/choi/myapp/log"
filename="app.log"

# (2)
ftp -n "$server" << __EOT__                        
user "$user" "$password"
binary
cd "$dir"
get "$filename"
__EOT__


################################################################################################################################################################

# (2)에서 ftp 명령어를 실행한다.
# ftp 명령어를 옵션 없이 실행하면 대화형 모드로 실행된다.

# ftp 192.168.219.110
# Connected to 192.168.219.110 (192.168.219.110).
# 220 (vsFTPd 3.0.3)
# Name (192.168.219.110:root): choi
# 331 Please specify the password.
# Password:
# 230 Login successful.
# Remote system type is UNIX.
# Using binary mode to transfer files.
# ftp> cd /home/choi/
# 250 Directory successfully changed.

# 여기서 셸 스크립트로 자동 실행하는 경우는 (2)처럼 ftp 명령어에 -n 옵션을 사용한다.
# -n 옵션은 .netc 파일로 자동 로그인하지 않도록 하는데 사용할 뿐만 아니라 셸 스크립트 자동화에도 사용한다.
# FTP 명령어는 홈 디렉토리 아래에 있는 .netrc 파일에 로그인 정보를 작성하면 자동 로그인한다.
# 여기서 -n 옵션을 쓰면 .netrc 파일을 사용하지 않는 대신 표준 입력에서 ftp 명령어를 입력할 수 있다.

# (2)에서 히어 도큐먼트로 실행할 FTP 명령어는 다음과 같다.

# 1) user 명령어로 로그인
# 2) binary 명령어로 바이너리 모드를 설정
# 3) cd 명령어로 디렉토리를 이동
# 4) get 명령어로 파일을 취득

# 이렇게 ftp 명령어 -n 옵션을 사용하면 ftp 프로토콜을 사용해서 파일 내려받기를 셸 스크립트로 자동화할 수 있다.
# 예제의 히어 도큐먼트로에 있는 get 부분을 put으로 바꾸면 파일 업로드 자동화도 가능하다.

