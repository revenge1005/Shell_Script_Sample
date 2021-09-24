#!/bin/sh

### 사용처 ###
# 스크립트에서 -a 같은 옵션을 해석해서 동작을 변경할 때

## -a 옵션이 있는지 플래그 변수 a_flag 
## -p 옵션의 구분자를 정의 
a_flag=0
separator=""

## "getopts" - 쉘에서 명령을 실행할 때 옵션을 사용하는데, 스크립트 파일을 실행할 때도 동일하게 사용 가능하게 함
## "ap:" -【 '-a' 과 '-p' 옵션 이용하며, 이때 '-p'는 인수를 받는다. 】라는 의미
while getopts "ap:" option
do
        case $option in
                a)
                        a_flag=1
                        ;;
                p)      ## "OPTARG" - 옵션 뒤에 별도의 파라미터 값이 오는 경우, 이를 파싱한 결과값
                        separator="$OPTARG" 
                        ;;
                \?)
                        echo "Usage: test.sh [-a] [-p separator] target_dir" 1>&2
                        exit 1
                        ;;
        esac
done

## shift - 인자를 지정한 수 만큼 왼쪽으로 이동시키는 명령
## $1=A , $2=B , $3=C , $4=D 일때, shift 1 명령을 사용하면 -> $1=B , $2=C , $3=D 
shift $(expr $OPTIND - 1) ## OPTIND - 인자의 개수 값 
path="$1"

if [ $a_flag -eq 1 ]; then
        ls -a -- "$path"
else
        ls -- "$path"
fi

if [ -n "$separator" ]; then
        echo "$separator"
fi
