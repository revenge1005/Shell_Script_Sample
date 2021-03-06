#/bin/bash

### 사용처 ###
# 확장자가 제각각인 파일들을 하나의 확장자로 변경하고 싶을 때

### 사용 명령어 ###
# mv

### 해설 ###
# 이 스크립트는 현재 디렉토리에 있는 확장자가 .htm과 html인 모든 파일을 .txt 확장자로 변경한다.

################################################################################################################################################################

for filename in *
do
    case "filename" in
        *.htm | *.html)
        # 파일명 앞 부분을 취득
        headname=${filename%.*}

        # 파일명을 .txt로 변환
        mv "$filename" "${headname}.txt"
        ;;
    esac
done

################################################################################################################################################################

# 이 스크립트는 확장자만 다른 파일이 있으면 파일을 덮어쓰게 된다.

# 리눅스에는 rename이라는 명령어가 있어서 파일명 일부를 간단히 변경할 수 있다.
# 이 명령어를 쓰면 예제와 같은 동작을 다음처럼 간결하게 작성할 수 있다.
# rename .htm .txt *.htm
# rename .html .txt *.html

# 그런데 리눅스 rename 명령어는 레드헷 계열 리누긋와 데비안 계열 리눅스에서의 문법이 다르다.
# 이 방법은 레드햇 계열의 CentOS 등에서는 사용 가능하지만, Ubuntu 같은 데비안 계열에서는 에러가 발생한다.
