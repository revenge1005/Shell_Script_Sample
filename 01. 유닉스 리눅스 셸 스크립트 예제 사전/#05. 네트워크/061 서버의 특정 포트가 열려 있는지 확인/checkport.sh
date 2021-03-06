#/bin/bash

### 사용처 ###
# 네트워크 방화벽 설정이 바른지 확인하는 스크립트를 실행하고 싶을 때

### 사용 명령어 ###
# nc

### 해설 ###
# 이 스크립트는 nc 명령어로 대상 서버 TCP 포트 상태를 확인해서 접속 불가능한 TCP 포트를 fail-port.log 파일에  출력한다.

# 서버 구축 시 네트워크나 방화벽 설정이 제대로 되었는지 확인해야 할 때가 있다.

# 포트마다 일일이 확인하는 것은 힘드므로 필요한 포트를 한꺼번에 확인해주는 스크립트를 사용하면 편리하다.
# 또한 스크립트를 사용하면 실수나 빠트림 방지가 가능하므로 자동화 장점이 있다.

################################################################################################################################################################

ipaddr="192.168.219."
faillog="fail-port.log"

# 확인할 포트 80, 2222, 8080
for port in 80 2222 8080                              # (1)
do
    nc -w 5 -z $ipaddr $port                            # (2)

    if [ $? -ne 0 ]; then
        echo "Failed at port: $port" >> "$faillog"      # (3)
    fi
done

################################################################################################################################################################

# (1)에서 for문을 써서 셸 변수 port 80, 2222, 8080을 순서대로 대입한다.

# (2)에서 접속 확인을 위해 nc 명령어를 사용한다.
# nc 명령어를 Netcat이라고 부르며, TCP/UDP 패킷으로 다양한 네트워크 확인이 가능한다.
# -z 옵션은 TCP 3 way 핸드 쉐이크만 하고 실제 통신은 일어나지 않는다.
# -w 옵션은 타임 아웃 설정, 방화벽 설정에 따라서는 서버 존재 자체를 숨기기 위해 포트 접속 시 아무런 응답을 하지 않도록 무시하는 기능이 있다.
# 이럴 때는 nc 명령어 동작 자체가 정지하게 되는데 예제에서는 -w 5로 5초간 응답이 없으면 타임 아웃으로 종료 처리한다.

# (3)에서 if문으로 nc 명령어가 성공 했는지 판별한다.
# -ne는 같지 않으면 참으므로 nc 명령어가 실패했을때 if문 내부가 실행된다.
# 실패한 포트 번호만 fail-port.log에 출력한다.

################################################################################################################################################################

# Netcat

# Netcat이라 불리는 명령어는 nc 명령어 외에도 포트 스캔툴 nmap에 따라오는 ncat 명령어가 있다.

# GNU Netcat이란 소프트웨어도 있으며, 하지만 GNU Netcat은 예전에 개발 중지되어서 현재는 그다지 쓰지 않는다.
# 하지만 nc 명령어와 ncat 명려어는 빈번히 사용된다.

# nc 명령어와 ncat 명령어는 옵션도 거의 같고 동작도 비슷하지만 세부 동작이나 메시지 출력이 다른다.
# 따라서 셸 스크립트에서 사용할 때는 주의해야 하며, Netcat 명령어라고 할 때는 nc 또는 netcat일 수도 있으므로 미리 확인하기 바란다.
