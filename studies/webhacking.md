
# 웹해킹 스터디

## 스터디 개요
- webhacking.kr 의 문제를 풀어보면서 질문, 답변 주고 받는 형태로 진행
- 기간 : 2016년 10월 31일 ~ 2016년 12월 05일
- 구성원 : 김지연(소프16), 박지선(소프16), 한나라(정통16), 한영빈(소프16), 송지은(소프15)
- 모임 시각 : 월요일 오후 6시 ~ 8시
- 모임 장소 : 스스스 랩실
- 푼 문제 : 1, 3, 4, 6, 12, 14, 15, 16, 17, 18, 24, 25, 26, 27, 32, 38, 49, 56

## 1주차 모임
- 2016.10.31
- 참석자 : 김지연, 박지선, 한나라, 한영빈, 송지은
- 푼 문제
 - 김지연 : 1, 4, 26
 - 박지선 : 1, 4
 - 한나라 : 1, 4, 15
 - 한영빈 : 1, 4, 17
 - 송지은 : 6, 12

### webhacking.kr 가입방법
- 먼저 webhacking.kr 에 접속.
- 페이지 우클릭 하여 나오는 컨텍스트 메뉴에서 `페이지 소스 보기` 선택
- 페이지 소스에서 아래와 같은 주석을 볼 수 있음. 회원 가입 버튼 코드를 주석으로 달아둔 것임. `===========================================` 로 감싸진 소스 부분을 복사함.

```html
<!--
Register
===========================================
<input type=button value='Register' onclick=location.href='join/includ2_join__frm__0001.php?mode=2d8d9c1703e9df8f1e8b7d0ba1578ce0' style=width:50pt;height:20pt;border:0;background:black;color:lightgreen></td></tr>
===========================================
-->
```
- 로그인 페이지로 돌아가서, 개발자 콘솔을 염(크롬에서는 `F12`)를 누르면 열림
- `body` 태그 내부 아무곳이나 마우스 커서 대고 우클릭, 컨텍스트 메뉴에서 `Edit as HTML` 선택
- 페이지에 코드를 삽입할 수 있음.(입력칸이 생김) 조금 전 복사한 소스를 붙여넣고, 입력칸 밖을 마우슬 누르던가 하여, 코드 삽입을 마침
- 그러면 페이지에 `Register` 버튼이 나타나는 것을 볼 수 있음. 눌러서 회원가입 진행.
- ID, PW, EMAIL 칸 체우고, decode me 항목에 임의의 값(?) 이 적혀 있는데, 이는 base64 로 3~4회정도 인코딩되어 나온 값임.
- decode me 의 값을, base64 인코딩/디코딩 사이트나 프로그램으로 디코딩.
 - 예를 들면 이 사이트 : http://www.convertstring.com/ko/EncodeDecode/Base64Decode
- 입력 받는 칸에, 원래의 인코딩된 값을 넣고, 디코딩 버튼을 눌러 디코딩 함. 출력 칸에 나온 값을 입력칸에 넣고 다시 디코딩.
 - 이러한 작업을 3번정도 반복하면, IP주소 같이 생긴 값이 나옴. 이제 이를 회원가입 창으로 돌아가서, decode me 칸의 값을 지우고 넣는다.
- `[Submit]` 을 눌러 계속한다.
- 가입 완료. 이제 로그인 하여 워게임 문제를 풀어보면 된다.

### 1번 문제
- 쿠키값을 조작하여 문제를 문제를 해결한다.
- 문제 1번 페이지에서 `index.phps` 를 클릭하면, 소스코드가 힌트로 나타난다.
- 소스코드에 나와있는 힌트를 보면, 쿠키의 `user_lv` 값이 6 이상이면, 값이 1로 변경되고, 5이상이면, 답이 나옴을 알 수 있다.
- 개발자 콘솔에서 스크립트를 실행하여 쿠키값을 조작할 수 있다.
- 다음을 개발자 콘솔의 콘솔 탭에서 입력하여, 쿠키값을 조회한다.
```javascript
document.cookie
```
- 아래와 같은 사항이 출력됨을 볼 수 있다.
```javascript
"user_lv=1; PHPSESSID=<임의의 세션 값>"
```
- 다음과 같은 방법으로 페이지의 쿠키값을 조작한다. 여기서는 `user_lv` 값을 5와 6 사이인 5.1 로 조작한다.
```javascript
document.cookie = "user_lv=5.1"
```
- 페이지를 새로고침 하면 문제가 풀리는 것을 볼 수 있다.

### 4번 문제
1. 첫 화면을 보면 YzQwMzNiZmY5NGI1NjdhMTkwZTMzZmFhNTUxZjQxMWNhZWY0NDRmMg== 라는 암호가 적혀있다.
   암호를 풀어서 password에 입력하면 풀리는 문제이다.
2. ==이 있는걸 보니 base64로 디코딩하고 싶어지는 기분이 들어 해보았다.
   그러면 c4033bff94b567a190e33faa551f411caef444f2 이 나오는데 이것을 잘 살펴보면 40자리의 16진수로 이루어져있다는 것을 발견할 수 있다.
3. 고로 40*4 = 160 bit의 해시 함수 SHA-1로 해독해 보았다.
4. 그러면 또 40자리 a94a8fe5ccb19ba61c4c0873d391e987982fbbd3가 나와서 한번 더 돌려보았다.
   그랬더니 아주 깔끔하게 password값이 나온다!

### 6번 문제
- http://webhacking.kr/challenge/web/web-06/index.phps 페이지로 들어간다.
- 쿠키를 확인해보면 user와 password라는 쿠키가 생성되어있다.
- admin을 base64로 20번 인코딩하여 user, password 쿠키에 값으로 저장해준다.
- 새로고침하면 문제가 풀린다.

### 12번 문제
- 개발자도구로 소스코드를 확인하면 아스키코드 값들이 나온다.
- 그 소스코드를 복사하여 콘솔창에 입력해주고 alert를 이용해 (아스키코드를 해석한)소스코드를 확인한다.

- 콘솔창 입력 예
```
WorkTimeFun=String.fromCharCode(118,97,114,32,101,...(생략)...,34,41,41,59,13,10,125,13,10);
alert(WorkTimeFun);
```

- 후에 소스코드를 분석해보면, ck 값이 패스워드라는 것을 알 수 있다.("="은 ""으로 바꿔줬으므로, "=" 제외)
- 위와 똑같은 방법으로 콘솔창에 String.from~~~ 부분을 입력하여 alert 해주면 패스워드를 확인할 수 있다.
- Auth에 패스워드를 입력해주면 문제가 해결된다.

### 15번 문제
- 문제에 들어가면 Access_Denied 창이 뜬다.
- 확인 버튼을 누른다
- 0.5초만에 답이 나왔다가 사라진다.
- Auth에 가서 답을 입력하면 문제 해결이 된다.

### 17번 문제
- 문제에 들어가면 입력칸 하나와 체크 버튼이 나온다.
- 개발자 콘솔을 열어서 요소 검사 탭(크롬에서는 Elements 탭)으로 들어간다.
- `body` 태그 끝자락에 `script` 태그 내부를 본다.
- `script` 태그 내부에 다음과 같은 내용의 자바스크립트 코드가 있다.

```javascript
unlock=100*10*10+100/10-10+10+50-9*8+7-6+5-4*3-2*1*10*100*10*10+100/10-10+10+50-9*8+7-6+5-4*3-2*1*10*100*10*10+100/10-10+10+50-9*8+7-6+5-4*3-2*1*10*100*10*10+100/10-10+10+50-9*8+7-6+5-4*3-2*1*10/100*10*10+100/10-10+10+50-9*8+7-6+5-4*3-2*1*10*100*10*10+100/10-10+10+50-9*8+7-6+5-4*3-2*1*10+100*10*10+100/10-10+10+50-9*8+7-6+5-4*3-2*1*10-100*10*10+100/10-10+10+50-9*8+7-6+5-4*3-2*1*10/100*10*10+100/10-10+10+50-9*8+7-6+5-4*3-2*1*10/100*10*10+100/10-10+10+50-9*8+7-6+5-4*3-2*1*10/100*10*10+100/10-10+10+50-9*8+7-6+5-4*3-2*1*10/100*10*10+100/10-10+10+50-9*8+7-6+5-4*3-2*1*10/100*10*10+100/10-10+10+50-9*8+7-6+5-4*3-2*1*10/100*10*10+100/10-10+10+50-9*8+7-6+5-4*3-2*1*10/100*10*10+100/10-10+10+50-9*8+7-6+5-4*3-2*1*10/100*10*10+100/10-10+10+50-9*8+7-6+5-4*3-2*1*10/100*10*10+100/10-10+10+50-9*8+7-6+5-4*3-2*1*10*100*10*10+100/10-10+10+50-9*8+7-6+5-4*3-2*1*10*100*10*10+100/10-10+10+50-9*8+7-6+5-4*3-2*1*10*100*10*10+100/10-10+10+50-9*8+7-6+5-4*3-2*1*10*100*10*10+100/10-10+10+50-9*8+7-6+5-4*3-2*1*10*100*10*10+100/10-10+10+50-9*8+7-6+5-4*3-2*1*10*100*10*10+100/10-10+10+50-9*8+7-6+5-4*3-2*1*10*100*10*10+100/10-10+10+50-9*8+7-6+5-4*3-2*1*10+9999999999;

function sub(){ if(login.pw.value==unlock){ alert("Password is "+unlock/10); }else { alert("Wrong");  }}
```

- `unlock` 변수에 저장된 값에 해당되는 값을 입력칸에 넣고 체크 바튼을 누르면, `Password is <비밀번호?>` 가 나오는 것을 알 수 있다.
- 콘솔 탭에서 바로 위의 코드에서 `unlock=...`　부분에서 `...` 에 해당하는 부분(`100*10...1*10+9999999999`) 콘솔에 붙여넣고 실행하면 아래와 같이 계산된 값이 나온다.

```javascript
9997809307
```

- 이를 입력칸에 넣고 체크 버튼을 누르면 다음과 같은 내용의 팝업이 나타난다.

```
Password is 999780930.7
```

- `webhacking.kr` 의 Auth 메뉴로 들어가서, `Flag` 칸에 `999780930.7` 를 넣고 제출한다.
- 문제가 풀리는 것을 확인할 수 있다.

### 26번 문제		
- 'index.phps' 클릭하면 소스가 나타난다.		

```		
<?if(eregi("admin",$_GET[id])) { echo("<p>no!"); exit();}$_GET[id]=urldecode($_GET[id]);if($_GET[id]=="admin"){@solve(26,100);}?>		
```		

- `id`의 값이 `admin`이면 문제 해결된다.		
- `get[id]`에서 `admin`이란 문자열이 보이면 함수가 종료된다.		
- `admin`을 다른 형태의 값으로 넣어줘야 한다.		
- `urldecode`는 해당문자열을 url디코딩하는 함수다. `admin`을 url인코딩한 값을 `id`에 넣어주면 `urldecode`에 의해 `admin`으로 바뀐다.		
- url 인코딩 표를 이용헤서 `admin`을 바꾸면 `%61%64%6D%69%6E`.		
- 그러나 `%61%64%6D%69%6E`를 입력하면 `eregi`에 의해 막힌다.(`%61%64%6D%69%6E`가 자동으로 디코딩되버렸기 때문에)		
- `%61%64%6D%69%6E`을 인코딩해서 입력하면 문제 해결

## 2주차 모임
- 2016.11.07
- 참석자 : 김지연, 박지선, 한나라, 한영빈, 송지은
- 푼 문제
 - 김지연 : 16, 56
 - 박지선 : 18, 54
 - 한나라 : 16, 38
 - 한영빈 : 16, 14
 - 송지은 : 24, 27

### 14번 문제
- 문제 화면에서, 개발자 콘솔을 열고 요소 검사 메뉴로 들어간다.
- `script` 태그에 다음과 같은 Javascript 소스가 있는 것을 볼 수 있다.

```javascript

function ck()
{
var ul=document.URL;
ul=ul.indexOf(".kr");
ul=ul*30;
if(ul==pw.input_pwd.value) { alert("Password is "+ul*pw.input_pwd.value); }
else { alert("Wrong"); }
}
```

- `ck()` 함수에서, 화면상의 입력칸에 입력한 값과. 현재 페이지 url 문자열에서 `.kr` 의 인덱스 값에 30 을 곱한 것이 동일한 경우, 비밀번호를 팝업으로 보여주는 것을 알 수 있다.
- 콘솔 메뉴에 들어간다. 콘솔에서 `document.URL` 을 입력하면, 현제 페이지에 입력된 `URL` 을 알 수 있다.

```
<- document.URL
-> "http://webhacking.kr/challenge/javascript/js1.html"
```

- 그렇다면, 다음을 콘솔에서 실행하여, 현재 페이지 `URL` 에서 `.kr` 의 인덱스를 알 수 있다.

```
<- document.URL.indexOf('.kr')
-> 17
```

- 여기에 인덱스 값은 `17` 이다. 여기에 `30` 을 곱하면, `ck()` 함수 내 조건문의 조건을 만족하는 값이 나온다.

```
<- 17*30
-> 510
```

- `510` 을 입력칸에 넣고 `check` 를 넣으면, 다음과 같은 내용으로 플래그가 팝업에 나타나는 것을 볼 수 있다.

```
Password is 260100
```
> 굳이 입력칸에 넣고 버튼을 누르지 않고도 플래그를 구할 수 있다. `ck()` 의 코드를 보면, 입력받은 값과, 임의로 만든 값을 곱해 팝업으로 보여주고 있는데, 입력받은 값과 임의로 만든 값이 같을 때 서로 곱하므로, 함수가 임의로 만드는 값인 `510` 을 제곱하면 플래그인 `260100` 이 된다.

- 이제 이를 webhacking.kr 의 Auth 에 제출하면, 문제가 풀리는 것을 볼 수 있다.

### 16번 문제
- 문제 화면에서, 개발자 콘솔을 열고 요소 검사 메뉴로 들어간다.
- `script` 태그에 다음과 같은 Javascript 소스가 있는 것을 볼 수 있다.

```javascript

document.body.innerHTML+="<font color=yellow id=aa style=position:relative;left:0;top:0>*</font>";

function mv(cd)
{
kk(star.style.posLeft-50,star.style.posTop-50);
if(cd==100) star.style.posLeft=star.style.posLeft+50;
if(cd==97) star.style.posLeft=star.style.posLeft-50;
if(cd==119) star.style.posTop=star.style.posTop-50;
if(cd==115) star.style.posTop=star.style.posTop+50;
if(cd==124) location.href=String.fromCharCode(cd);
}


function kk(x,y)
{
rndc=Math.floor(Math.random()*9000000);
document.body.innerHTML+="<font color=#"+rndc+" id=aa style=position:relative;left:"+x+";top:"+y+" onmouseover=this.innerHTML=''>*</font>";
}
```

- `mv()` 함수 내부를 보면, 함수 인자인 `cd` 가 `124` 일때, `124` 로 이동하는 것을 볼 수 있다.
- 개발자 도구 콘솔 메뉴에서 다음 코드를 실행한다.

```javascript
mv(124);
```

- 화면이 변경되면서, 플래그 값이 나오는 것을 볼 수 있다. 이를 webhacking.kr 의 Auth 에 제출하면, 문제가 풀리는 것을 볼 수 있다.


### 18번 문제
1. index.phps를 들어가서 읽어보니 id가 guest라고 되어있는 것을 admin으로 바꾸면 solve될 것 같이 보였다.
2. 일단 id를 아무거나 때려 넣어 보다가 no=1이라고 되어있길래 1을 넣었더니 hi guest가 떴다.
3. burp suite를 이용해서 저 페이지를 잡아보았다.
4. 그리고 저 no=1 부분을 수정했다. (0 or 1 limit1, 1이렇게)
5. no=0%Aor%0A1%0Alimit%0A1,1 이런식으로 바꾸고 페이지에 반영시키면 clear!

### 24번 문제
- http://webhacking.kr/challenge/bonus/bonus-4/index.phps 페이지로 들어간다.
- 소스코드를 분석해보면 REMOTE_ADDR이란 쿠키값에 저장된 값을 ip 변수에 저장한다. ip 값을 127.0.0.1로 만들어줘서 문제를 풀면 된다.
- 우선 REMOTE_ADDR 쿠키를 생성해주고,

```php
if($_COOKIE[REMOTE_ADDR])
{
$ip=str_replace("12","",$ip);
$ip=str_replace("7.","",$ip);
$ip=str_replace("0.","",$ip);
}
```

- 이 부분에 걸리지 않도록 값을 조정하여 112277..00..00..1 을 쿠키값으로 저장해준다.
- 후에 새로고침 해주면 문제가 풀린다.

### 27번 문제
- http://webhacking.kr/challenge/web/web-12/index.phps 페이지로 들어간다.
- 필터링 된 문자들을 우회해서 sql 인젝션 해주면 된다.
- no에 1을 입력했을 때 guest가 나오므로, admin은 0이나 2를 입력해야한다고 추측하여 시도해줬다.
- 입력창에 0) or no=2 을 넣어주면 필터링이 걸리므로 우회하여 0) or no like 2 -- 로 입력해준다.
- 문제가 해결된다.

### 38번 문제
- 웹 해킹 페이지 38번에 들어가면 login과 admin의 버튼이 등장한다
- 우선 소스를 확인해보자

```html
<!--admin.php-->

```
이렇게 주석처리로 적혀있다. 그러므로 admin.php로 들어가보자.
- 바로 admin으로 들어가면 login plz라는 문구가 뜬다		
- 다시 돌아가서 아무 값을 먼저 넣고 login을 해보자		
- 값을 넣고 로그인 버튼을 넣어도 아무변화가 없다.		
- 다시 admin으로 들어가면 내가 쓴 값앞에 무언가가 붙는다.		
- 다시 한번 소스를 확인한다.

```html
<!--

 hint : admin

 -->
 ```
 이라고 적혀있다.
 - admin만 값을 넣으면 풀이가 되지 않는다
 - 여기 앞에 적혀있던 것(아이피임)을 넣고 뒤에 admin을 넣어본다
 - 문제가 솔브된다.



### 54번 문제
1. burp suite로 페이지를 잡아서 소스코드를 살펴보았다.

```html
<html>
<head>
<title>Challenge 54</title>
</head>
<body>
<h1><b>Password is <font id=aview></font></b></h1>
<script>
function run(){
  if(window.ActiveXObject){
   try {
    return new ActiveXObject('Msxml2.XMLHTTP');
   } catch (e) {
    try {
     return new ActiveXObject('Microsoft.XMLHTTP');
    } catch (e) {
     return null;
    }
   }
  }else if(window.XMLHttpRequest){
   return new XMLHttpRequest();

  }else{
   return null;
  }
 }

x=run();

function answer(i)
{
x.open('GET','?m='+i,false);
x.send(null);
aview.innerHTML=x.responseText;
i++;
if(x.responseText) setTimeout("answer("+i+")",100);
if(x.responseText=="") aview.innerHTML="?";
}

setTimeout("answer(0)",10000);

</script>
</body>
</html>
```

이라고 뜨는데 `function answer(i)`부분을 조금만 수정하면 될 것처럼 보였다.
2. `aview.innerHTML=x.responseText;`여기를 `aview.innerHTML+=x.responseText;`이렇게 부호만 바꾸고,
3. `if(x.responseText=="") aview.innerHTML="?";` 여기를 `if(x.responseText=="") alert(aview.innerHTML);`이렇게 바꾸어서 반영시켜보면 간단하게 해결된다!

### 56번 문제

- `readme` 눌렀을때 `access denied` 등장 (접근 거부)
- `hi~` 눌렀을때 `hi~` 등장
- 밑에 검색버튼에 여러가지 입력해본다.
- `hi~`를 검색하면
- `0`을 검색하면
- 그외 나머지값일때
- `h` 입력할 때 (`admin` 등장)
- 알파벳 모두 입력했을 때, `h`, `k`, `p` 입력하면 `admin` 등장
- 특수문자 중에서는 `.`, `%`, `_` 중 하나를 입력하면 `admin` 등장
- `_`는 임의의 숫자나 문자이기 때문에 `_`로 글자 수를 알 수 있다.
- `___`(3개)를 입력하면 `guest`가 등장
- `_`(언더바)를 하나씩 늘리면서 검색해보면
-  `______`(6개) 검색할 때 `admin`이 나오기 때문에
- 검색어가 6글자라는 것을 추측할 수 있다.
- 검색해서 `admin` 등장하는 문자 : `0` `h` `k` `p` `.`
- 위 문자들 조합해서 하나씩 검색해본다. ex. `k_____` 검색 , `k0____` 검색 <<노가다>>
- 여러번의 검색 후 admin의 값은 `kk.php`라는 것을 알 수 있다.
- 주소창 뒤에 적고 `Enter` 치면
- 성공 `>_<`

## 3주차 모임
- 2016.11.14
- 참석자 : 김지연, 박지선, 한나라, 한영빈, 송지은
- 푼 문제
 - 김지연 :
 - 박지선 : 25
 - 한나라 :
 - 한영빈 : 3
 - 송지은 : 32, 49


### 3번 문제
 - 문제 페이지로 들어가면, 퍼즐이 하나 나오는데, `노노그램` 혹은 `네모네모로직` 이라는 퍼즐 게임이다.
 - 5 * 5 칸이 준비되어 있고, 각 가로줄이나 세로줄 위쪽이나 왼쪽에 숫자가 배열되어 있다.
 - 적혀있는 숫자의 수 만큼, 칸을 연속해서 칠해야 하며, 숫자가 둘 이상인 경우 칠해진 칸 사이에 빈칸이 하나 이상 있어야 한다.
  - 예를 들어 1, 2 이면. 한칸 칠하고 최소 한칸 띄어서 두칸을 연속해서 칠해야 함
 - 해당 칸을 클릭해 칠하는 방식으로, 퍼즐을 풀면 아래와 같은 모양이 나온다. 그리고 `gogo` 를 눌러 다음 단계로 간다.

 ```
 ■□■□■
 □□□□□
 □■■■□
 □■□■□
 ■■■■■
 ```

 - 일일이 클릭하기 싫다면, 다음을 개발자콘솔의 콘솔 탭에서 실행한 후, `gogo` 를 눌러 다음 단계로 갈 수도 있다

 ```javascript
 let one = [kk._1, kk._3, kk._5, kk._12, kk._13, kk._14, kk._17, kk._19, kk._21, kk._22, kk._23, kk._24, kk._25]
 one.forEach((item)=>{item.value=1})
 ```

 - 이름 입력칸이 나오는데, 아무가나 넣고 클릭하면 아래와 같은 내용이 담긴 페이지가 나타난다.

 ```
 Puzzle

 name : nnnn
 answer : 1010100000011100101011111
 ip : <IP Address>
 ```

 - `answer` 값이 플래그인가? 하고 `Auth` 에 제출해 볼 수 있으나, 이는 플래그가 아니므로 틀렸다고 나온다.
 - `burpsuite` 를 이용해서 어떤 값이 전달되는지 알아보자.
  - `burpsuite` 를 열고, Proxy 탭 으로 간 뒤, Options 탭으로 간다.
  - Proxy Listener 에 아무 설정도 없다면 하나 추가하자. `Add` 를 누른다.
  - `Bind to port` 를 `8080` 으로, `Bind to address` 는 `Loopback only` 로 선택한다. 그리고, `OK` 를 누른다.
  - 추가한 항목의 `Running` 체크박스를 체크 상태로 변경한다.
  - Proxy -> Intercept  로 간다. `Intercept is off` 를 눌러 `Intercept is on` 이 되도록 만든다.
  - 사용중인 OS 의 프록시 설정을 변경하여, `burpsuite` 의 프록시 서버를 거치도록 설정한다. 주소는 `127.0.0.1`, 포트는 `8080` 으로 하면 된다.
 - 이제 다시 페이지로 돌아가서, 아까 입력칸에 나온 페이지에서 아무 값이나 넣고 버튼을 눌러보자. 필자는 `admin` 을 넣었다
 - 다음과 같은 `HTTP` 헤더와 바디가 `burpsuite` 에서 잡히는 것을 볼 수 있다.

 ```
 POST /challenge/web/web-03/index.php HTTP/1.1
 Host: webhacking.kr
 Content-Length: 41
 Cache-Control: max-age=0
 Origin: http://webhacking.kr
 Upgrade-Insecure-Requests: 1
 User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.100 Safari/537.36
 Content-Type: application/x-www-form-urlencoded
 Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8
 Referer: http://webhacking.kr/challenge/web/web-03/index.php?_1=1&_2=0&_3=1&_4=0&_5=1&_6=0&_7=0&_8=0&_9=0&_10=0&_11=0&_12=1&_13=1&_14=1&_15=0&_16=0&_17=1&_18=0&_19=1&_20=0&_21=1&_22=1&_23=1&_24=1&_25=1&_answer=1010100000011100101011111
 Accept-Encoding: gzip, deflate
 Accept-Language: ko,en-US;q=0.8,en;q=0.6,zh;q=0.4,zh-CN;q=0.2,zh-TW;q=0.2
 Cookie: PHPSESSID=660d2c9c6785948e67bf8851ed4eeea6
 Connection: close

 answer=1010100000011100101011111&id=admin
 ```

 - `answer=1010100000011100101011111&id=admin` 부분에서 `...111` 과 `&id=admin` 사이에 뭔가를 삽입해서 SQL Injection 을 시도해 보자.
 - `"`,`'`,`or 1=1`, 등을 조합하여 넣어 시도해 보자.

 | 수정된 값 | 서버로 전송한 결과
 --- | ---
 `answer=1010100000011100101011111"&id=admin` | `query error!`
 `answer=1010100000011100101011111'&id=admin` | `no hack`
 `answer=1010100000011100101011111" or 1&id=admin` | `no hack`
 `answer=1010100000011100101011111" or 1=1 &id=admin` | `no hack`
 `answer=1010100000011100101011111=&id=admin` | `no hack`
 `answer=1010100000011100101011111 || 1&id=admin` | 플래그가 나옴

 - SQL Injection 에 성공한 경우, 아래과 같은 내용이 나타난다. 그 중 `answer` 값이 플래그 이므로 제출하면 된다.
 ```
 name : admin
 answer : <flag>
 ip : localhost
 ```

### 25번 문제
- url을 먼저 살펴보면, ?file=hello 라고 되어있다.

- 아래 박스에는 hello.txt로 추정되는 것이 출력 되어있는 것으로 봐서 우리의 목표는 저곳에 password.php를 출력시키는 것으로 정해야 함을 알 수 있다.
  - ?file=hello 라고 되어있을 때 hello.txt를 출력하는 것을 통해서,
  - ?file=password 라고 단순히 해서는 password.txt를 출력할 것이고,
  - ?file=password.php 라고 한다면 password.php.txt 라는 엉뚱한 것을 출력할 것이다.

- 결국 확장자 .txt를 제거해야 한다는 결론에 이른다.

- 구글링을 통해 php에서 종료문자 %00을 사용하면 이후의 문자열이 무시된다는 것을 알게 되었다.

- 그렇다면 ?file=뒤에 무엇을 입력해야 할 지 쉽게 알 수 있을 것이다!

### 32번 문제
- join 버튼을 누르면 랭킹에 내 아이디가 추가된다.
- 아이디를 클릭하면 vote_check:ok 쿠키가 생성되며 HIT 부분의 수가 증가한다.
- 쿠키가 생성된 후로는 아이디를 눌러도 no! 라는 창이 뜨며 수가 증가하지 않는다.
- 투표의 여부를 쿠키값으로 확인하는 구조인 듯 하므로, 쿠키가 생성되기 전에 페이지를 가로채서 100번이 넘어가도록 투표를 반복한다. (`burpsuite`의 `repeater` 기능을 사용함)
- 본인 아이디의 투표 횟수가 100이 넘어가면 문제가 풀린다.

### 49번 문제
- level에 1을 입력하면 zzibong이 뜬다.
- http://webhacking.kr/challenge/web/web-24/index.phps 에서 소스코드를 확인한다.
- id를 admin으로 만들면 문제가 풀리는 것을 알 수 있다.
- 필터링 되는 문자들을 우회하여 id를 admin으로 만드는 값을 lv에 입력해준다.
- 0 or id=admin 을 필터링을 우회하여 입력
- 0%0A||%0Aid=0x61646d696e 이런식으로 입력해주면 문제가 풀린다.
