# Python Basics Study(2017.04)

## 스터디 개요
 - 기간 : 2017년 04월 04일 부터 약 10주+
 - 스터디 리더 : 한영빈(소프16)
 - 스터디 방식 : Tryhelloworld 파이썬 입문 코스 미리 공부해 와서 질의응답 방식으로 진행
 - 온라인 코스 : [파이썬 입문(Tryhelloworld)](http://tryhelloworld.co.kr/courses/%ED%8C%8C%EC%9D%B4%EC%8D%AC-%EC%9E%85%EB%AC%B8)
 - 구성원 : 한영빈(소프16), 김희수(소프16), 한나라(정통16), 김규희(소프17), 장은애(소프17), 김문수(소프17), 박찬우(소프17)
 - 스터디 모임 시각 : 화요일 오후 6시 30분 ~ 오후 8시 30분
 - 모임 장소 : 스스스 랩실 또는 별도로 장소 대관

## 1회차 모임
 - 2017.04.04
 - 참석자 : 한영빈, 김희수, 한나라, 김규희, 장은애, 김문수, 박찬우.
 - 진도 : 1장 - 파이썬 설치 + Hello World 출력해보기

## 2회차 모임
 - 2017.04.11
 - 참석자 : 한영빈, 김희수, 한나라, 김규희, 장은애, 박찬우.
 - 결석 : 김문수(학생회)
 - 진도 : 2~3장

### 질문 & 다룬 내용

  - 소스코드에 영어가 아닌 문자가 있는 경우, 가장 첫 줄에 `#-*-coding:utf-8-*-` 를 넣어야 함
  - 파이썬에서는 왜 변수를 선언할 때 키워드(혹은 예약어) 를 사용하지 않는가?
   - 나라 : 파이썬의 장점?
  - 전역변수와 지역변수 구분이나 스코프 구분은 어떻게 해야 할까?
  - 파이썬에서 들려쓰기를 할 때 반드시 4칸씩 띄어쓰기 해야 하는가?
   - 꼭 4칸씩 할 필요는 없지만, 들여쓰기 할때 일관적으로 해야 한다. 한칸씩 띄어쓰기 할거면 모두 한칸씩, Tab 으로 할꺼면 전부다 Tab 으로 해야 한다.
  - 파이썬 여러 줄 주석 달기
  ```
  """
  여러줄에 걸쳐서
  주석 달기
  """
  ```

## 3회차 모임
 - 2017.04.18
 - 참석자 : 한영빈, 김문수, 박찬우.
 - 결석 : 한나라(병결), 김희수(병결), 김규희, 장은애.
 - 진도 : 4~5장

### 질문 & 다룬 내용

 - `input()` 함수를 호출하여, 사용자로 부터 입력을 받을 수 있음.
  - 인자로 문자열을 넘겨줘서, 안내문을 출력하면서 입력받을 수 있음.(예제 : `input("안내문")`)
  - 사용자로부터 입력받을 것을 리턴함.
 - `format()`함수를 이용하여, 문자열을 포맷팅 할 수 있음.

예제1
```python
a='SSS'
b='짱'
print("{}{}".format(a,b))
```
예제1 실행 결과
```
SSS짱
```
예제2
```python
string = "{}{}"
print(string.format("SSS","짱"))
```
예제2 실행 결과
```
SSS짱
```
여러줄에 걸쳐 문자열 내용을 입력하려면, 큰 따옴표 3개로(`"""`) 시작하고 마치면 됨
```python
string = """문자열
여러줄에
걸쳐서 넣어보기"""
```

## 4회차 모임
 - 2017.05.02
 - 참석자 : 김문수 , 김희수 , 장은애 , 한영빈
 - 결석 : 김규희 , 박찬우 , 한나라
 - 진도 : 6~9장

### 질문 & 다룬 내용
 - list를 이해하고 사용할 수 있음.
 - for in list와 for in range를 이해하고 사용하여 반복문을 만들 수 있음.
 - module을 이해하고 사용할 수 있음.
 - 직접 module을 만들고 사용할 수 있음.

- 가위바위보 예제 코드

```python
import random

def rsp():
    return random.choice(["바위","가위","보"])
```

```python
import rsp

draw = 0
win = 0
lose = 0

for i in range(0,100000000):
    a = rsp.rsp()
    b = rsp.rsp()

    if a==b:
        print("비김")
        draw += 1

    else:

        if a=="바위":
            if b=="가위":
                print("승리")
                win += 1
            elif b=="보":
                print("패배")
                lose += 1
        elif a=="가위":
            if b=="바위":
                print("패배")
                lose += 1
            elif b=="보":
                print("승리")
                win += 1

        elif a=="보":
            if b=="바위":
                print("승리")
                win += 1
            elif b=="가위":
                print("패배")
                lose += 1

print("a는 총 {}번 승리하고 {}번 무승부하고 {}번 패배했습니다.".format(win,draw,lose))
```

## 5회차 모임
 - 2017.05.16
 - 참석자 : 한영빈, 박찬우, 한나라, 김희수, 김규희, 장은애.
 - 결석 : 김문수(학생회)
 - 진도 : 가위바위보 플레이어 코드
 - 가위바위보 플레이어 코스 저장소
 	- https://github.com/skhu-sss/pyrsp

## 6회차
 - 2017.05.30
 - 참석자 : 한영빈, 한나라, 김희수, 박찬우, 김문수
 - 결석 : 김규희~~(탈주)~~, 장은애~~(탈주)~~
 - 진도 : 10강 - 딕셔너리와 튜플
 - 10강 복습을 위한 간단한 코딩.

```python
#-*-coding:utf-8-*-
dict = {    201632034 : "한영빈",
            201633036 : "한나라",
            201632007 : "김희수",
            201732004 : "김문수",
            201732015 : "박찬우"
            }

def getInfoById(dict, id):
    return (id, dict[id])

def getInfoByName(dict, name):
    for key, val in dict.items():
        if val == name:
            return (key, name)
```

```python
#-*-coding:utf-8-*-
import dictex as members

print(members.getInfoById(members.dict, 201632034))
print(members.getInfoByName(members.dict, "한영빈"))

a, b = members.getInfoById(members.dict, 201632034)
c, d = members.getInfoByName(members.dict, "한영빈")

print("{}{}".format(a,b))
print("{}{}".format(c,d))
```

## 7회차
 - 2017.06.08
 - 참석자 : 한영빈, 김희수
 - 결석 : 한나라(병결), 김규희~~(탈주)~~, 장은애~~(탈주)~~
 - 진도 : 11~12강 - while 반복문과 예외처리(try~except)
 - 학습한 내용을 이용하여 가위바위보 게임 만들기.
  - 딕셔너리를 활용하여 승리여부 판단
  - while 문 활용하여 게임 무한반복.(사용자가 중단 요청 시 까지.)
  - 범위 밖의 값 입력 시 예외처리 하기

```python
 #-*-coding:utf-8-*-

 import random

 winConditions = {"가위":"보","바위":"가위","보":"바위"}
 selection = {1:"가위",2:"바위",3:"보"}
 print("가위,바위,보 게임")
 while True:
     player = input("가위(1), 바위(2), 보(3) 중 하나를 숫자로 선택하세요. 종료하려면, 0을 입력하세요.")
     if(player==0):
         exit()
     bot = random.choice(["가위","바위","보"])
     try:
         if player not in [1,2,3]:
             raise ValueError
     except ValueError as e:
         print(e)
         print("올바른 값이 아닙니다.")
         continue
     if winConditions[selection[player]] is bot:
         print("이겼습니다.")
     elif selection[player] is bot:
         print("비겼습니다.")
     else:
         print("졌습니다.")
     print("나:{}, 상대방:{}".format(selection[player], bot))
```

## 8회차
 - 2017.06.24
 - 참석자 : 한영빈, 김희수, 한나라
 - ~~진도 : 13~15 강~~
 - 플젝과 앞으로의 스터디 일정에 관한 토론
 
## 9회차
- 2017.06.29 목
- 참석자 : 한영빈, 김희수, 한나라
- 진도 : 13~16 강
- Java 와 달리 클래스에서 필드를 사전에 선언하지 않음. 사전에 선언하기 보단 생성자에서 선언과 동시에 초기화 함
- 오버라이드(재정의) 를 할 때 부모 클래스의 것을 오버라이드 한다는 표시(예: Java 의 `@Override`, Kotlin 의 `override` 등)가 따로 없음.

## 10회차
 - 2017.07.02 일
 - 참석자 : 한영빈.김희수, 한나라
 - 진도 : 17~18강
