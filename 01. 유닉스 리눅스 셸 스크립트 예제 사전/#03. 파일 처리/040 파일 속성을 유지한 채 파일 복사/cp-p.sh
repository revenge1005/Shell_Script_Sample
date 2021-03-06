#/bin/bash

### 사용처 ###
# 디렉토리를 복사할 때 파일 속성과 심볼릭 링크를 포함해서 백업하고 싶을 때

### 사용 명령어 ###
# getopts, cp

### 해설 ###
# 이 스크립트는 현재 디렉토리에 있는 myapp 디렉토리 아래 에 있는 파일, 디렉토리 전체를 지정한 디렉토리로 복사해서 백업한다.
# 이때 -a 옵션을 지정하면 파일의 타임 스탬프와 퍼미션 등 파일 속성을 유지한 채 복사한다.

################################################################################################################################################################

backup_dir="backup"

# myapp 디렉토리를 $backup_dir 밑에 백업 복사
while getopts "a" option
do
    case $option in
        a) 
            cp -a myapp "$backup_dir"
            exit
            ;;
    esac
done

cp -R myapp "$backup_dir"

################################################################################################################################################################

# getopts 명령어는 LINUX 명령을 사용하면 각 명령에 대해 option 을 지정할 수 있다.

# cp 명령어를 -a 옵션으로 실행해서 타임스탬프와 퍼미션을 유지하며 복사한다.
# cp 명령어는 옵션 없이 파일을 복사하면 파일 퍼미션은 umask로 설정한 값이 변한다.
# 또한 타임스탬프는 현재 시각으로 변경되며, 옵션 없는 cpu 명령어는 디렉토리를 복사하지 안으므로 백업 용도로 디렉토리째 복사할 때 주의해야 한다.

# -a 옵션을 붙이면 cp 명령어는 원본 파일의 소유자, 그룹, 접근권, 접근 시각 등 파일 속성을 유지한 채 파일을 복사한다.
# 또한 -a 옵션을 사용하면 -R(recursive) 옵션도 동시에 지정한 것으로 봐서 서브 디렉토리를 포함한 파일 트리를 그대로 복사한다.
# -R 옵션은 심볼릭 링크는 링크 자체를 복사하지만, 만약 심볼록 링크가 가리키는 실제 파일을 복사하고 싶으면 -R과 -L 옵션을 같이 사용한다.
# -p(preserve) 옵션을 지정하면 파일 속성도 유지할 수 있다.

################################################################################################################################################################

# cp 명령어의 man을 보면 -a 옵션은 -p 옵션에 몇가지 옵션 조합한 것이다.
# -a 옵션은 OS 마다 다소 동작이 다르다.

# 리눅스에서 -a 옵션은 -dpR 와 같다. -d는 심볼릭 링크를 심볼록 링크로 그대로 복사하는 것을 의미한다.
# FreeBSD와 MAC 이라면, -a는 -RpP 와 같다. -P는 심볼릭 링크를 심볼록 링크로 복사하는 것을 의미한다.

################################################################################################################################################################

# 복사 원본 파일의 스크립트 실행자와 파일 소유자가 다르면 속성을 유지 못할 수도 있다.
# 예를 들어 소유자가 root인 파일을 일반 사용자가 -p 옵션으로 cp 명령어를 실행해도 일반 사용자가 파일 소유자를 root로 만들 수 없으므로 
# 파일 소유자 속성은 cp 명령어를 실행한 사용자가 된다.
