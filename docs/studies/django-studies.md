# Django 스터디

- 기간 : 2017년 07월 02일 부터 약 1주+
- 스터디 리더 : 한영빈(소프16)
- 스터디 방식 : Tryhelloworld *장고를 활용한 웹사이트 만들기* 코스 미리 공부해 와서 질의응답 방식으로 진행 + 보충
- 온라인 코스 : [장고를 활용한 웹사이트 만들기(Tryhelloworld)](http://tryhelloworld.co.kr/courses/%EC%9E%A5%EA%B3%A0%EB%A5%BC-%ED%99%9C%EC%9A%A9%ED%95%9C-%EC%9B%B9%EC%82%AC%EC%9D%B4%ED%8A%B8-%EB%A7%8C%EB%93%A4%EA%B8%B0)
- 구성원 : 한영빈(소프16), 김희수(소프16), 한나라(정통16)
- 스터디 모임 시각 : 화, 목, 일 오후 3시 00분 ~ 오후 5시 00분
- 모임 장소 : 스스스 랩실 또는 별도로 장소 대관

## 1회차 모임
 - 2017.07.02
 - 참석자 : 한영빈, 김희수, 한나라

### Django 설치하기
 - `pip` (Python Package Index) 를 먼저 설치해야 함.
  - https://pip.pypa.io/en/stable/installing/
 - 다음 명령을 실행하여 설치

 ```bash
 pip install django
 ```

## 2회차 모임
 - 2017.07.04
 - 참석자 : 한영빈, 김희수, 한나라
 - 장고 어드민 - 웹 인터페이스로 Django 웹사이트와 연동된 데이터베이스의 데이터를 관리할 수 있음.
 - 장고 셸 - CLI 에서 파이썬 문법으로 Djano 웹사이트와 연동된 데이터베이스의 데이터를 관리할 수 있음.
 - 참고자료
  - 장고걸스 튜토리얼 : https://tutorial.djangogirls.org/ko/
  - 모델 필드 타입 (장고 모델에서 사용 가능한 필드 타입) : https://tutorial.djangogirls.org/ko/
  - 장고 템플릿 문법 : https://docs.djangoproject.com/en/1.11/ref/templates/language/

## 3회차 모임
 - 2017.07.06
 - 참석자 : 한영빈, 김희수, 한나라
 - 진도 나간 내용은 주로, Django 에서 제공하는 템플릿 문법과 URL 패턴 등을 좀 더 응용해 보는 내용.
 - Django url 처리에 사용하는 정규표현식 : https://wayhome25.github.io/django/2017/03/18/django-ep2-regx/
 - Django request, response 객체 : https://docs.djangoproject.com/en/1.11/ref/request-response/
 - HttpResponseRedirect 객체 - 사용자를 다른 페이지로 자동 이동 시키고자 할 때 사용 : https://docs.djangoproject.com/en/1.11/ref/request-response/#django.http.HttpResponseRedirect
 - HttpResponse, `render()`대신 JsonResponse 를 사용하여, JSON 형식으로 요청에 응답할 수도 있음. : https://docs.djangoproject.com/en/1.11/ref/request-response/#jsonresponse-objects

## 4회차 모임
 - 2017.07.08
 - 참석자 : 한영빈, 김희수, 한나라
 - 템플릿 확장(상속) 추가 참고 자료 : https://tutorial.djangogirls.org/ko/template_extending/
 - 정적 파일 로드 추가 참고 자료 : https://tutorial.djangogirls.org/ko/css/
 
