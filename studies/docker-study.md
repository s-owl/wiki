# Docker Study

> 스터디 구성원 모집이 마감되었습니다.(2016.10.07 11:00PM)

## 스터디 개요
 - 기간 : 2016년 10월 12일 부터 약 5~7주
 - 스터디 리더 : 한영빈(소프16)
 - 스터디 방식 : 커리큘럼에 따라 각자 미리 공부해 와서, 질문돠 답변 주고받기
 - 교재 : [가장 빨리 만나는 Docker(원고 온라인상에 공개되어 있음)](http://pyrasis.com/docker.html), [Docker Docs](https://docs.docker.com/)의 일부 문서
 - 구성원 : 한영빈(소프16), 김준수(소프11), 추건우(소프15), 배다슬(소프12)
 - 스터디 모임 시각 : 수요일 오후 7시 30분 ~ 오후 9시 30분

## 계획중인 스터디 커리큘럼
 - 1주차 : 1~5장
 - 2주차 : 6~7장
 - 3주차 : 8~9장
 - 4주차 : 10~14장
 - 5주차 : 16~19장
 - 6주차 : Docker Compose (예정. 다른 주제로 변경될 수 있음)

## 1주차 모임
 - 2016.10.12
 - 참석자 :
 - 도커 설치 : 책의 내용은 오래 되어 안 될 수도 있으므로, 도커 공식 문서 참조 권장.
  - https://www.docker.com/products/overview
 - [Docker run reference](https://docs.docker.com/engine/reference/run/)
 - `docker run [image] /bin/bash`의 옵션으로 `-it`를 입력하지 않는 경우는 어떻게 될까?
  - `-i` 옵션은 interactive로 입력과 출력을 할 수 있게 해준다. 시각적으로는 보이나 shell의 `id@domain$` 부분이 나타나지 않는다.
  - `-t` 옵션은 tty로 shell의 `id@domain$`부분이 시각적으로 보인다. 그러나 입출력이 불가능 하다.
  - 그러므로 shell을 `run`하는 경우에는 `-it`옵션을 줘야 정상적으로 사용할 수 있다.
  - 컨테이너를 백그라운드 모드로 돌리려면, `docker run` 으로 새 컨테이너를 만들 때 `-d` 옵션 사용
