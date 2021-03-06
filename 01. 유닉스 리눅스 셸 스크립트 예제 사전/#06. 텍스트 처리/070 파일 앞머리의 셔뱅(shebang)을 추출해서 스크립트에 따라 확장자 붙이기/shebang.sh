#!/bin/bash

### 사용처 ###
# 확장자가 없는 스크립트 파일에 자동으로 확장자를 부여하고 싶을 때

### 사용 명령어 ###
# head, mv

### 해설 ###
# 이 스크립트는 스크립트 파일 첫 줄을 읽어서 사용된 언어에 대응하는 확장를 파일명에 부가한다.

# 관례적으로 스크립트 파일은 해당 언어에 대응하는 확장자를 파일명에 사용하며, 일반적으로 사용하는 확장자는 다음과 같다.
# sh -> sh, bash
# pl -> Perl
# rb -> Ruby
# py -> Python
# php -> PHP

################################################################################################################################################################
 
# 대상 스크립트 파일이 있는지 확인
if [ ! -f "$1" ]; then                                          # (1)
    echo "지정한 파일을 찾지 못했습니다. $1"  >&2   
    exit 1;
fi

# 파일 첫 줄 읽음
headline=$(haed -n 1 "$1")                                      # (2)

# 파일 첫 줄에 따라 확장자를 판정해서 부여함
case "$headline" in                                             # (3)
    */bin/sh|*bash*)
        mv -v "$1" "${1}.sh"
        ;;
    *perl*)
        mv -v "$1" "${1}.pl"
        ;;
    *ruby*)
        mv -v "$1" "${1}.rb"
        ;;
    *)
        echo "Unknown Type: $1"
        ;;
esac

################################################################################################################################################################
 
# 셸 스클비트의 첫 줄은 반드시 #!로 시작하는데, 이를 셔뱅(Shebang)이라고 한다.

# 유닉스에서는 파일을 실행할 때 그 파일이 기계어로 작성된 파일이라면 그대로 실행한다.
# 그렇지 않으면 파일 첫 줄을 읽어서 #! 뒤에 있는 명령어를 실행한다.
# 위 예제에서는 /bin/bash가 실행되므로, 셸 스크립트로 동작하게 된다.

# C언어 등으로 작성된 실행 파일(기계어 파일)과 셸 스크립트 파일은 실행하기 위한 최소 퍼미션이 다르며,
# C언어 등으로 만든 실행 파일은 읽기 퍼미션이 없어도 실행 권한이 있으면 실행된다.

# 반면, 셸 스크립트 파일은 일반 사용자로 실행할 때는 실행 권한만으로는 실행되지 않고 반드시 읽기 권한도 있어야 한다.

################################################################################################################################################################
 
# (1)에서는 대상 스크립트를 확인한다. 
# test 명령어 -f 연산자로 파일이 존재하는지 확인해서 부정 연산자 !를 사용해 파일 존재하지 않을 때 에러를 표시하고 종료한다.

# (2)는 head 명령어로 파일 첫 줄을 추출해서 셸 변수 headline에 저장한다.
# head 명령어는 파일 앞부분부터 읽는 명령어로, -n 옵션을 사용하면 줄 수만 추출할 수 있다.

# (3)에서는 case문을 사용해 파일 종류를 판단한다.
# mv 명령어를 사용해서 기존 파일명에 확장자를 추가하고, -v 옵션을 써서 변경 전후 파일명을 표시한다.

################################################################################################################################################################
 
### << 주의 사항 >>

# 이 스크립트는 펄, 루비, sh, bash에만 대응한다.
# 만약 루비가 /usr/bin/perl/ruby 같은 경로에 설치되었다면 오장동하게 된다.

# 이미 확장자가 설정되어 있는지 확인하지 않으므로 상황에 따라서는 확장자가 이중으로 지정될 수도 있다.

# 파일 종류를 알수 없을 때는 file 명령어가 편리하다.
# file 명령어는 다음 처럼 파일을 인수로 지정해서 그 파일이 무언인지 판단해 표시한다.
# $ file /usr/bin/startx
# /usr/bin/startx: POSIX Shell script text executable
# $ file network.day
# network.dat: tcpdump capture file (little-endian) version 2.4 (Ethernet, capture length 65535)