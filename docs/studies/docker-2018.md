# Docker Study (2018.06~)

## 개요

## 스터디 개요
- 기간 : 2018년 6월 26일 부터 약 5~7주
- 스터디 리더 : 한영빈(소프16)
- 교재 : [가장 빨리 만나는 Docker(원고 온라인상에 공개되어 있음)](http://pyrasis.com/docker.html), [Docker Docs](https://docs.docker.com/)의 일부 문서
- 구성원 : 한영빈(소프16), 김희수(소프16), 고다경(소프14), 김유진(소프17), 김문수(소프17), 김경현(IT학부18), 김남수(컴공14)
- 스터디 모임 시각 : 수요일 오후 6시 ~ 오후 8시
- 모임 장소 : 동아리 랩실(필요에 따라 다른 장소도 가능)

## 스터디 방식

- 각자 미리 해당 주차 진도 공부해오기
- 매주 한명씩 돌아가면서, 해당 주차 진도를 상세히 공부하여 발표
- 매주 한명씩 돌아가며 해당 주차 스터디에서 다룬 내용을 위키에 기록 (해당 주차 발표자가 아닌 사람이 기록)

## 스터디 진도
> 각 주차별 진도에 필요에 따라 부가적인 내용이 추가될 수 있음.

- 1주차 : 스터디 개요 안내, 1~2장 / 발표자, 기록자 - 한영빈
- 2주차 : 3~5장 / 발표자 - 김유진, 기록자 - 고다경
- 3주차 : 6~7장 / 발표자 - 김희수, 기록자 - 김문수
- 4주차 : 8~9장 / 발표자 - 고다경, 기록자 - 김희수
- 5주차 : 10~14장 / 발표자 - 김남수, 기록자 - 김유진
- 6주차 : 16~19장 / 발표자 - 김문수, 기록자 - 김남수

## 1주차

- 출석 : 한영빈, 고다경, 김희수, 김유진
- 결석 : 김경현(아르바이트로 인해 불참), 김문수(장염으로 인해 병결)

### 스터디 진행 관련 결정 사항

- 위키 문서에 사용할 편집기 : Atom + Teletype

### 스터디에서 다룬 사항

- [슬라이드 자료 링크](docker-2018-slides/docker-week-1.pdf)
- 가상머신(VM) 에 대한 소개
- 클라우드 컴퓨팅의 등장과 클라우드 환경에서의 가상머신
- 가상머신 이미지와 Immutable Infrastructure
- 컨테이너에 대한 소개와 컨테이너와 가상머신의 차이점
- 도커와 다른 컨테이너 이미지에 대한 간단한 소개
- 도커 이미지 구조에 대한 간단한 소개
- 도커 사용 사례

## 2주차

- 발표자 : 김유진 / 기록자 : 고다경
- 출석 : 한영빈, 고다경, 김희수, 김유진, 김남수
- 지각 : 김문수
- 결석 : 김경현(아르바이트로 인해 불참)

- 도커 기본 명령어(search, pull, images, run, ps, start, restart, attach, exec, stop, rm, rmi)
- Dockerfile 작성
- docker 이미지 히스토리 볼때 `missing` 은 무엇인가?
  - https://github.com/moby/moby/issues/20131
- docker build로 이미지 생성
- docker history로 이미지 히스토리
- docker cp 명령으로 파일 꺼내기
- docker commit 컨테이너 변경사항을 이미지로 생성
- docker diff 컨테이너 변경된 파일 확인
- docker inspect 세부 정보 확인
- Docker Multi Stage build
  - https://docs.docker.com/develop/develop-images/multistage-build/#name-your-build-stages

## 3주차

- 발표자 : 김희수 / 기록자 : 김문수
- 출석 : 한영빈, 고다경, 김희수, 김남수
- 결석 : 김유진(집안 경조사로 인해 불참), 김경현(무단결석)

- [슬라이드 자료 링크](docker-2018-slides/docker-study-week-3.pptx)
- dorkerfile 명령어(.dokerignore,FROM,MAINTAINER,RUN,CMD,ENTRYPOINT,EXPOSE,ENV,ADD,COPY,VOLUME,USER,WORKDIR,ONBUILD)
  - entrypoint 와 cmd 의 차이점
      - entrypoint: 컨테이너안에 명령어들을 넣어놓고 그 명령어들을 실행할때 사용
      - cmd: 컨테이너안에 돌아가는 디폴트값
- docker link - docker ps 에 링크 정보가 나오지 않음.
    - `docker inspect <컨테이너 이름>` 으로 연결 정보 확인 가능.
- 다른 서버에 컨테이너 연결하기
   - `--link` option 사용과 네트워크를 생성해 연결하는 방법 두가지가 있다.
   - 교재와 다르게 `docker ps`로 조회시 연결 상태를 확인할 수 없음.
- 다른 컨테이너와 연결하는것은 오케스트레이션이 더편함

## 4주차

- 발표자 : 고다경 / 기록자 : 김희수
- 출석 : 한영빈, 고다경, 김희수, 김문수, 김경현(화상)
- 결석 : 김유진(식중독), 김남수(개인 일정)

### 스터디에서 다룬 내용

- [슬라이드 자료 링크](docker-2018-slides/docker-study-week-4.pdf)
- Docker로 애플리케이션 배포하기
  - 서버 한 대에 배포하기
    - 개발자 PC
      - Git 설치 및 저장소 생성
      - Node.js로 웹 서버 작성
      - Dockerfile 작성
      - SSH키 생성
        ```bash
        ~$ssh-keygen
        ```
    - 서버 PC
      - Git 설치 및 저장소 생성
      - Docker 설치
      - SSH키 설정
        - 서버의 /home/<서버 사용자 계정> 디렉터리 아래에 .ssh 디렉터리를 생성하고, 권한을 설정합니다.
          ```bash
          ~$ mkdir .ssh # .ssh 디렉터리 생성
          ~$ chmod 700 .ssh # .ssh 디렉터리 권한 설정
          ```
        - authorized_keys파일 불러오고 권한 설정
          ```bash
          $ chmod 600 authorized_keys
          ```
      - Git Hook 설정
        - post-receive 파일 생성
          ```bash
          #!/bin/bash

          APP_NAME=exampleapp
          APP_DIR=$HOME/$APP_NAME
          REVISION=$(expr substr $(git rev-parse --verify HEAD) 1 7)

          GIT_WORK_TREE=$APP_DIR git checkout -f

          cd $APP_DIR
          docker build --tag $APP_NAME:$REVISION .
          docker stop $APP_NAME
          docker rm $APP_NAME
          docker run -d --name $APP_NAME -p 80:80 $APP_NAME:$REVISION
          ```

    - 개발자 PC에서 소스 Push하기
      - <exampleapp> 저장소 디렉터리로 이동한 뒤 git remote add 명령으로 origin 주소를 설정합니다.
        ```bash
        ~/exampleapp$ git remote add origin <서버 사용자 계정>@<서버 IP 주소 또는 도메인>:exampleapp
        ```

      - git push 명령으로 소스를 서버에 올립니다.
        ```bash
        ~/exampleapp$ git push origin master
        ```
    - 웹 브라우저에서 서버IP주소로 접속

- 서버 여러 대에서 배포하기
  - ~~할 필요 없음~~
  - Kubernetes , docker-swarm을 쓰도록 하자.  

- cAdvisor 를 이용한 도커 컨테이너 모니터링
    - cAdvisor = Container Advisor: 구글에서 개발한 컨테이너 모니터링 도구.
    - 간단히 cAdvisor 이미지 받아서 컨테이너 실행하면 바로 모니터링 가능.
    - 최근 1분간의 자료만 보여주므로, 긴 시간동안의 자료를 보려면 몇가지 프로그램 더 붙여야 함.
    - InfluxDB(시계열 데이터용 데이터베이스), Grafana(대시보드) 등을 같이 사용. InfluxDB 대신 Elastic 많이 사용하기도 함.
    - 아래 Docker Compose 파일을 이용하여 셋을 한번에 배포 가능.
    ```yaml
    version: "3"

    services:
      influx:
        image: influxdb
        volumes:
          - influx:/var/lib/influxdb
        environment:
          INFLUXDB_DB: cadvisor
          INFLUXDB_USER: cadvisor
          INFLUXDB_USER_PASSWORD: cadvisor

      cadvisor:
        image: google/cadvisor:latest
        ports:
          - 8080:8080
        volumes:
          - /:/rootfs:ro
          - /var/run:/var/run:rw
          - /sys:/sys:ro
          - /var/lib/docker/:/var/lib/docker:ro
          - /dev/disk/:/dev/disk:ro
        links:
          - influx
        command: -logtostderr -docker_only -storage_driver=influxdb -storage_driver_db=cadvisor -storage_driver_host=influx:8086
        restart: unless-stopped

      grafana:
        image: grafana/grafana:latest
        ports:
          - 4000:3000
        volumes:
          - grafana:/var/lib/grafana
        links:
          - influx

    volumes:
      influx:
        driver: local
      grafana:
        driver: local
    ```
    - Compose 파일 배포
        - `docker-compose up`
    - Compose 파일 배포(백그라운드)
        - `docker-compose up -d`
    - Compose 파일 문법 참조자료
        - https://docs.docker.com/compose/compose-file/