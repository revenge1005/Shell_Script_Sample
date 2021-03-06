#/bin/bash

### 사용처 ###
# 에러 메시지를 바탕으로 그 메시지를 출력하는 명령어를 찾고 싶을 때

### 사용 명령어 ###
# strings, grep

### 해설 ###
# 이 스크립트는 에러 메시지를 단서로 바이너리 파일에서 해당하는 에러 메시지를 출력하는 명령어를 찾는다.

################################################################################################################################################################

# 검색할 에러 메시지
message="Unknown Error"

strings -f /myapp/bin/* | grep "$message"

################################################################################################################################################################

# 시스템을 운용하다 보면 어떤 에러 메시지가 출력되는데 그게 어떤 명령어가 출력하는지 알지 못하는 경우가 있다.

# 프로그램을 펄이나 루비 같은 스크립트 언어로 작성하면 에러 메시지로 프로그램을 grep하면 된다.
# 하지만 C 언어 등으로 작성하면 실행 파일은 컴파일된 바이너리 파일이므로 단순한 텍스트 검색이 불가능하다.
# 그렇때 사용하는 방법이 strings 명령어이다.

################################################################################################################################################################

# strings 명령어는 바이너리 파일에서 문자열을 추출한다.

# 일반적으로 C 언어로 컴파일된 바이너리 파일이라도 문자열 상수는 파일 안에 그대로 저장되어 있다.
# 따라서 strings 명령어로 프로그램의 에러 메시지를 찾을 수 있다.
# 이 예제는 트러블슈팅 때 그런 에러 메시지를 출력하는 명령어를 찾아내는 스크립트이다.

################################################################################################################################################################

#### od 명령어, hexdump 명령어

# 바이너리 파일 내용을 직접 살표볼때는 파일을 8진수로 덤푸하는 od 명령어를 자주 사용한다.
# od 명령어는 다양한 옵션을 지원하는데, 단순히 바이너리 파일에 있는 문자열만 본다면 ASCII 문자열을 출력하는 -c 옵션만 기억하면 된다.

# 다음은 리눅스 커널 파일을 od 명령어로 덤프한 실행 예이다.
# [root@node2 choi]# od -c /boot/vmlinuz-3.10.0-1160.el7.x86_64
# 0000000   M   Z 352  \a  \0 300  \a 214 310 216 330 216 300 216 320   1
# 0000020 344 373 374 276   @  \0 254     300   t  \t 264 016 273  \a  \0
# 0000040 315 020 353 362   1 300 315 026 315 031 352 360 377  \0 360  \0
# 0000060  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0 202  \0  \0  \0
# 0000100   U   s   e       a       b   o   o   t       l   o   a   d   e
# 0000120   r   .  \r  \n  \n   R   e   m   o   v   e       d   i   s   k
# 0000140       a   n   d       p   r   e   s   s       a   n   y       k
# 0000160   e   y       t   o       r   e   b   o   o   t   .   .   .  \r
# (생략)

# 더 고성능인 hexdump 명령어도 자주 사용된다.
# hexdump 명령어는 -C 옵션을 써서 파일 내용을 16진수 덤프와 ASCII 문자열 셋으로 표시할 수 있다.
# [root@node2 choi]# hexdump -C /boot/vmlinuz-3.10.0-1160.el7.x86_64
# 00000000  4d 5a ea 07 00 c0 07 8c  c8 8e d8 8e c0 8e d0 31  |MZ.............1|
# 00000010  e4 fb fc be 40 00 ac 20  c0 74 09 b4 0e bb 07 00  |....@.. .t......|
# 00000020  cd 10 eb f2 31 c0 cd 16  cd 19 ea f0 ff 00 f0 00  |....1...........|
# 00000030  00 00 00 00 00 00 00 00  00 00 00 00 82 00 00 00  |................|
# 00000040  55 73 65 20 61 20 62 6f  6f 74 20 6c 6f 61 64 65  |Use a boot loade|
# 00000050  72 2e 0d 0a 0a 52 65 6d  6f 76 65 20 64 69 73 6b  |r....Remove disk|
# 00000060  20 61 6e 64 20 70 72 65  73 73 20 61 6e 79 20 6b  | and press any k|
# 00000070  65 79 20 74 6f 20 72 65  62 6f 6f 74 2e 2e 2e 0d  |ey to reboot....|
# 00000080  0a 00 50 45 00 00 64 86  04 00 00 00 00 00 00 00  |..PE..d.........|
# 00000090  00 00 01 00 00 00 a0 00  06 02 0b 02 02 14 20 35  |.............. 5|
# 000000a0  67 00 00 00 00 00 e0 d8  ae 01 10 46 00 00 00 02  |g..........F....|
# (생략)

################################################################################################################################################################

##### 주의사항 #####

# 1) 프로그램에서 동적으로 에러 메시지를 조합할 때는 strings 명령어로 바이너리 파일을 찾을 수 없다.

# 2) MAC strings 명령어에는 -f 오볏ㄴ이 없으므로 파일명을 표시할 수 없다. 따라서 (1) 부분은 for 반복문을 써서 파일마다 처리하면 된다.
# for filename in /usr/local/bin/*
# do
#   echo "$filename"
#   strings $filename | grep "$message"
# done

