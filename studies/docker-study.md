# Docker Study

> 스터디 구성원 모집이 마감되었습니다.(2016.10.07 11:00PM)

## 스터디 개요
 - 기간 : 2016년 10월 12일 부터 약 5~7주
 - 스터디 리더 : 한영빈(소프16)
 - 스터디 방식 : 커리큘럼에 따라 각자 미리 공부해 와서, 질문과 답변 주고받기
 - 교재 : [가장 빨리 만나는 Docker(원고 온라인상에 공개되어 있음)](http://pyrasis.com/docker.html), [Docker Docs](https://docs.docker.com/)의 일부 문서
 - 구성원 : 한영빈(소프16), 김준수(소프11), 추건우(소프15), 배다슬(소프12, 고정 참석자 아님)
 - 스터디 모임 시각 : 수요일 오후 7시 30분 ~ 오후 9시 30분
 - 모임 장소 : 스스스 랩실

## 계획중인 스터디 커리큘럼
 - 1주차 : 1~5장
 - 2주차 : 6~7장
 - 3주차 : 8~9장
 - 4주차 : 10~14장
 - 5주차 : 16~19장
 - 6주차 : Docker Compose (예정. 다른 주제로 변경될 수 있음)

## 1주차 모임
 - 2016.10.12
 - 진도 : 1~5장
 - 참석자 : 한영빈, 김준수, 추건우, 배다슬
 - 도커 설치 : 책의 내용은 오래 되어 안 될 수도 있으므로, 도커 공식 문서 참조 권장.
  - https://www.docker.com/products/overview
  - 우분투에 설치 하려는 경우 다음 문서를 참조.
  - https://docs.docker.com/engine/installation/linux/ubuntulinux/
 - [Docker run reference](https://docs.docker.com/engine/reference/run/)
 - `docker run [image] /bin/bash`의 옵션으로 `-it`를 입력하지 않는 경우는 어떻게 될까?
  - `-i` 옵션은 interactive로 입력과 출력을 할 수 있게 해준다. 시각적으로는 보이나 shell의 `id@domain$` 부분이 나타나지 않는다.
  - `-t` 옵션은 tty로 shell의 `id@domain$`부분이 시각적으로 보인다. 그러나 입출력이 불가능 하다.
  - 그러므로 shell을 `run`하는 경우에는 `-it`옵션을 줘야 정상적으로 사용할 수 있다.
 - 컨테이너를 백그라운드 모드로 돌리려면, `docker run` 으로 새 컨테이너를 만들 때 `-d` 옵션 사용
 - 컨테이너의 포트와 호스트의 포트를 연결 하려면, `-p` 옵션을 사용한다.
  - 예시 : 호스트의 80번포트와, 컨테이너의 3000번 포트를 연결
  - `docker run -p 80:3000 <image>:<tag>`
 - Docker Hub 이외의 Registry 에서 이미지 가져오기.
  - 이미지를 `pull` 할 때, 이미지 이름 앞에 해당 registry의 도메인을 붙임.
    - 예시 : `quay.io` 에서 `letsencrypt` 이미지를 가져오려는 경우.
    - `docker pull quay.io/letsencrypt/letsencrypt:latest`
    - 인증이 필요한 경우, 해당 registry 에 로그인 하면 됨.
      - 예시 : GitLab Container Registry 에 로그인.
      - `docker login registry.gitlab.com`
 - gitlab의 registry에서 이미지를 가져오는 방법
  - `docker login registry.gitlab.com` 명령을 통해 gitlab의 registry에 로그인을 한다.
  - `docker pull registry.gitlab.com/<user>/<repo>:<name>` 명령을 통해 등록된 registry를 당겨올 수 있다.

 - 추건우 공부 내용 링크 :https://drive.google.com/open?id=1e9U65MQRzANiSjWH1OzNx0bpe4jqX4NNXPy9BhhQb04
 - Docker 에서 관리하는 설정, 이미지, 컨테이너 등은 `/var/lib/docker` 에 보관됨

## 2주차 모임
 - 2016.11.02
 - 진도 : 6~7장
 - 참석자 : 한영빈, 김준수
 - 결석 : 추건우, 배다슬
 - 도커 개인저장소 구축
 - 서버로 사용할 컴퓨터에 registry를 받아두고 클라이언트에서 daemon실행할 때 아래 명령을 통해서 실행해준다.
  - `sudo docker daemon --insecure-registry=<ip_address:port_number>`
  - systemd 사용자의 경우 daemon을 항상 이런식으로 실행할 경우는 다음 문서를 참고
   - http://www.developmentalmadness.com/2016/03/09/docker-configure-insecure-registry-for-systemd/
  - insecure-registry를 설정해주는경우에는 http 통신이 가능하지만 권장되지는 않는다. 인증서를 가지고 https 통신을 하도록 하자.
 - 볼륨 지정 시 해당 위치 찾기
  - 해당 container에 볼륨지정
   - `docker run -v /data <image_name>`
  - 호스트의 볼륨 위치

```bash
docker inspect -f "{{range .Mounts}}{{.Source}}{{end}}" <image_name>
```
   - archlinux 기준으로 `/var/lib/docker/volumes/<image_id>/_data`에 위치함
   - [`docker inspect` 포맷 관련 자료](https://docs.docker.com/engine/reference/commandline/inspect/)
