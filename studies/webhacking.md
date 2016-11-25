
# 웹해킹 스터디

## 스터디 개요
- webhacking.kr 의 문제를 풀어보면서 질문, 답변 주고 받는 형태로 진행
- 기간 : 2016년 10월 31일 ~ 2016년 12월 05일
- 구성원 : 김지연(소프16), 박지선(소프16), 한나라(정통16), 한영빈(소프16), 송지은(소프15)
- 모임 시각 : 월요일 오후 6시 ~ 8시
- 모임 장소 : 스스스 랩실
- 푼 문제 : 1, 3, 4, 6, 7, 10, 11, 12, 14, 15, 16, 17, 18, 20, 23, 24, 25, 26, 27, 32, 38, 39, 41, 46, 49, 54, 56, 58

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
 - 김지연 : 11, 21
 - 박지선 : 25, 46
 - 한나라 : 39, 58
 - 한영빈 : 3, 10
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
  - `answer=1010100000011100101011111"&id=admin` -> `query error!`
  - `answer=1010100000011100101011111'&id=admin` -> `no hack`
  - `answer=1010100000011100101011111" or 1&id=admin` -> `no hack`
  - `answer=1010100000011100101011111" or 1=1 &id=admin` -> `no hack`
  - `answer=1010100000011100101011111=&id=admin` -> `no hack`
  - `answer=1010100000011100101011111 || 1&id=admin` -> 플래그가 나옴

 - SQL Injection 에 성공한 경우, 아래과 같은 내용이 나타난다. 그 중 `answer` 값이 플래그 이므로 제출하면 된다.
 ```
 name : admin
 answer : <flag>
 ip : localhost
 ```

### 10번 문제
- 문제 화면에 들어가면, 빨간 사각형 하나, 회색 사각형 하나, 빨간 사각형 하나가 아래 방향으로 나열되어 있다.
- 페이지 화면은 볼거 없고... 소스를 보자!
- 개발자 콘솔이나, 페이지 우클릭시 나오는 컨텍스트 메뉴에서 `소스 보기` 누르면 나오는 소스는 아래와 같다.

```html

<html>
<head>
<title>Challenge 10</title>
</head>

<body>
<hr style=height:100;background:brown;>
<table border=0 width=900 style=background:gray>
<tr><td>
<a id=hackme style="position:relative;left:0;top:0" onclick="this.style.posLeft+=1;if(this.style.posLeft==800)this.href='?go='+this.style.posLeft" onmouseover=this.innerHTML='yOu' onmouseout=this.innerHTML='O'>O</a><br>
<font style="position:relative;left:800;top:0" color=gold>|<br>|<br>|<br>|<br>buy lotto</font>
</td></tr>
</table>
<hr style=height:100;background:brown;>

</body>
</html>

```

- `id`가 `hackme`인 `a` 태그를 보면, `a` 태그 클릭시, 해당 태그의 `style` 속성에서, `posLeft` 가 `1`씩 늘어나고, 값이 `800` 이면, 정해진 작업이 실행되는 것을 볼 수 있다.
- `posLeft` 값을 `799` 로 바꾸고 클릭 해보자. 개발자 콘솔을 열고, 콘솔 탭에서 다음을 실행한다.
 - `id` 가 `hackme` 인 요소에 접근하여, 해당 요소의 `style` 속성의 `posLeft` 값을 `799` 로 변경하는 코드이다.

```javascript
document.getElementById('hackme').style.posLeft=799
```

- 그리고, 회색 사각형 위의 `O` 글자를 누른다.(참고로 마우스를 올리면 `yOu` 라고 바뀌었다가, 때면 다시 `O` 로 바뀐다.)
- 끝. 문제가 풀렸다.

### 11번 문제
- preg_match : PHP에서 패턴이 일치하는 문자 혹은 숫자를 판단하기 위해서 사용되는 함수
- preg_match(패턴, 비교할 변수) 형태로 사용.
- &pat가 패턴, %_GET[val]가 비교할 변수
- &_GET : 값을 수집하는데 사용하는 함수
- val값이 pat패턴과 일치하면 패스워드를 출력하라고 제시되어있음.
- 패턴을 만들기 위해서는 정규식에 맞춰야함.
- "" : 패턴을 만들때 들어가는 기본 형식
-  / : 처음과 끝을 나타냄.
- [] : 안에 존재하는 문자나 숫자 중 하나만을 나타내라는 뜻. []안의 -는 범위를 나타냄.
- ex. [a-z]는 a에서 z 중 하나를 나타내라는 뜻.
- {]= : 앞에 있는 문자를 {}안의 개수만큼 출력하라는 뜻. 
- \t : tap이라는 의미를 가지며 url인코딩을 했을 경우 %09라는 값이 나옴.
- $pat = "/[1-3][a-f]{5}_.IP주소.\tp\ta\ts\ts/";을 해석하면
- 1aaaaa_.IP주소.%09p%09a%09s%09s 가 나옴.
- 이것을 주소창에 입력.(val = 1aaaaa_.IP주소.%09p%09a%09s%09s) 

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

### 39번 문제

- 우선 소스를 확인하자  `$_POST[id]`

```html
<!-- index.phps-->
```

- 주석에 index.phps가 있으므로 현주소 뒤에 붙여준다  
-  index 페이지를 보면 새로운 코드들이 있다  

```php
$pw="????";

if($_POST[id])
{
$_POST[id]=str_replace("\\","",$_POST[id]);
$_POST[id]=str_replace("'","''",$_POST[id]);
$_POST[id]=substr($_POST[id],0,15);

```

- 여기서 입력값에 대해 replace와 substr이 된다고 한다  
- replace는 대체라는 소리인것 같고 substr이 뭔지 몰라서 구글링을 했다.  
- 쿼리문을 보면 `'$_POST[id]` 이런식으로 값이 전달되고 있다  
- 싱글 쿼터가 `$_POST[id]` 앞에는 있는데 뒤에는 없다  
- 그럼 id 값과 싱글 쿼터 (' )를 넣어서 문제를 클리어 할 수 있을 것 같아서 값을 넣었더니 틀렸다고 한다. (시무룩)  
- 문제를 찾아보았다. 코드를 다시 한번 정독을 했다.  
- replace에서 싱글 쿼터는 필터링이 된다. (자만하고 소스를 제대로 확인을 안한 벌을 받았다)
- 보면 (' )를 (" )로 replace 하고 있었다.

```php
$_POST[id]=substr($_POST[id],0,15);
```
- replace랑 substr이 15자리까지만 id를 받는다고 적혀있으니까 우선 15번째는 (' )를 적어주면 된다는 사실을 발견했다.
- 빈칸~~~~~하고나서 `'`만 하면 솔브가 되지 않는다.
- 웹해킹 문제를 풀어보면 `admin`을 너무 좋아하길래 혹시나하고 `admin         '`를 적었더니 솔브가 된다(운이 좋았ㄷ...)

### 46번 문제

- 46번에 들어가면 level값에 1이 적혀있고 제출버튼이 보인다.
- 먼저 그냥 제출을 클릭하면 아래와 같이 출력된다.
	 - zzibong information
	 - money : 10000
- 소스코드를 보니 id를 admin으로 만들어 주면 풀릴 것 같았다.
- 0 or id=admin을 입력해준다. 안되는 것을 발견한다ㅎ
- 필터링 되는 스페이스바를 %0A를 넣어준다. 또 안되는 것을 발견한다ㅎ
- 그리고 admin을 직접 입력하면 안된다는 것을 깨닫는다.
- ascii코드로 admin 값을 구해서 char(--이곳에 그 값을 입력--) 하면 된다.

### 49번 문제
- level에 1을 입력하면 `zzibong`이 뜬다.
- http://webhacking.kr/challenge/web/web-24/index.phps 에서 소스코드를 확인한다.
- `id`를 `admin`으로 만들면 문제가 풀리는 것을 알 수 있다.
- 필터링 되는 문자들을 우회하여 `id`를 `admin`으로 만드는 값을 `lv`에 입력해준다.
- `0 or id=admin` 을 필터링을 우회하여 입력
- `0%0A||%0Aid=0x61646d696e` 이런식으로 입력해주면 문제가 풀린다.

### 58번 문제

- pw: 와 login이 있다. 소스부터 확인하자

```html
<center>
<script src="kk.js"><script>
<script src="kk2.js"><script>
<embed src="hackme.swf" width="500" height="400">
</center>
```

- 여기서 js는 Java Script 코드를 가지고 있는 text 파일이라는 것을 구글링을 통해 알 수 있었다.
- swf를 구글링하자 플래시 파일이라는 것을 알 수 있었다.
- 주소창 뒤에 파일 이름을 적는다.
- 그러면kk.js는 아래와 같이 나온다

```javascript
kk=document.URL;
kk=kk.substr(10,4);
```

- 이것은 `kk`에 `document.URL`을 저장시키고 저장된 값에서 10번쨰 다음 숫자부터 4개의 값을 뽑고 다시 kk에 저장한다는 소리이다.
- `kk2.js`를 넣으면 아래와 같이 나온다

```javascript
kk=kk+"me.swf";
document.write("<embed src="+kk+" width=500 height=400></embed>");
```

- `kk`에 `me.swf`를 더한 값을 `kk`에 저장시키고 그다음 `embed`태그(플래시를 재생하게 해주는 태그라고 합니다)와 `kk`를 적어 출력시킨다
- 동영상을 더해야 한다는 소리이다. (여기서부터 조금 어려움을 느낌)
- 동영상을 어떻게 추가해야할지 막막했다.
- 구글링을 하다보니 메모장에서 하이퍼링크를 통해서 추가한다는 것을 응용함

```html
<html>
<body>
<a href="http://webhacking.kr/challenge/web/web-35/hackme.swf">동영상</a>
</body>
</html>
```

- 이렇게 적고 동영상.html 저장을 해주었다.
- 이것을 실행하면 하이퍼 링크가 나온다.
- 동영상을 누르면 문제화면이 나온다(멘붕)
- 동영상 글자위에 커서를 두고 오른쪽 마우스로 다른이름으로 대상을 저장한다.
- 메모장으로 동영상을 메모장에다가 끌여놓으면
- 정말 이상한 문자들이 미친듯이 적혀있다.
- 마지막에 보면 http://webhacking.kr.challenge/web/web-35/g1v2n2passw0r라고 적혀있고 줄바꿈뒤에 d.php가 있다.
- 연결해서 주소창에 적으면 문제가 솔브된다.
- (필자는 문법부터 모르는것이 많아서 시간이 오래걸리긴 했지만 그닥 어려운 문제는 아니었고 조금 귀찮은 유형이었다.)

## 4주차 모임
- 2016.11.21
- 참석자 : 김지연, 박지선, 한나라, 한영빈, 송지은
- 푼 문제
 - 김지연 : 23
 - 박지선 : 
 - 한나라 : 
 - 한영빈 : 
 - 송지은 : 41

### 23번 문제
- `<script>alert(1);</script>`을 인젝션 하는 문제.
- 특수문자를 입력했을 때 필터링되지 않는다.
- "script", "alert", "sc" 등은 필터링된다. (no hack 표시)
- "s%00c"을 입력했을 때, 주소창 `code=s%2500c`로 바뀐다.
- 주소창에서 25를 지우고 `Enter` 누르면 "sc" 그대로 인젝션 된다.
- `<script>alert(1);</script>` 을 `URL인코딩`을 한다.
- 인코딩을 하면 `%3cscript%3ealert(1)%3b%3c%2fscript%3e` 값이 나온다.
- 이 값에 script와 alert 글자 사이에 `%00`을 써준다. (%00은 공백 Null의 표현)
- `%3cs%00c%00r%00i%00p%00t%3ea%00l%00e%00r%00t(1)%3b%3c%2fs%00c%00r%00i%00p%00t%3e`
- 이것을 주소창 `code=` 뒤에 입력해주면 문제해결.

### 41번 문제
- "~/index.phps" 에서 소스코드를 확인한다.
- `copy()` 함수는 `빈칸`이 값으로 들어왔을 때 취약점이 발생한다.
- `빈칸`이나 `.`을 파일명으로 입력해주면 `eregi()` 함수에서 필터링 되어 막힌다.
- 따라서 `eregi()` 함수 사용 이후에 적힌 `<`와 `>`를 이용한다.
- 파일명이 `<` 또는 `>`인 파일을 업로드하면 에러 메세지가 출력되면서 `$hidden_dir` 값이 노출된다.
- 제대로 된 파일을 업로드 한 후 "~/$hidden_dir/업로드한_파일명" 으로 접속하면 문제가 풀린다.

## 5주차 모임
- 2016.11.28
- 참석자 : 김지연, 박지선, 한나라, 한영빈, 송지은
- 푼 문제
 - 김지연 : 7
 - 박지선 : 
 - 한나라 : 
 - 한영빈 : 
 - 송지은 : 41
 
### 7번문제

- URL을 보면 `val=1` 확인할 수 있다.
- `auth`을 클릭하면 `Acess_Denied`라는 안내창이 나온다.
- 소스를 보면 주석이 있다.

```html
<!-- admin mode : val=2 --> 
<!--
index.phps
-->
```

- `admin mod`는 `val = 2`라는 것을 알수 있다.
- 그래서 주소창의 `val`값을 2로 변경하면
- `Access Denied!`라고 나온다.
- `index.phps` 이동해본다.
- 여기에도 주석이 있다. 주석을 통해 정보를 얻을 수 있다.

```html
<!--
db에는 val=2가 존재하지 않습니다.

union을 이용하세요
-->
```

- 주석 아래에 있는 소스를 해석해보면
- go에 val값을 저장.
- if: go값이 없으면 val=1.
- `go`값을 `ck`에 저장.
- `*`, `,`, `/`의 값을 지움.
- `--`, `2`, `substring` 등을 사용하지 못하도록 필터링.
- `Space` 사용할 수 없음.
- `rand`는 난수를 만드는 함수. (난수는 랜덤으로 이해하면 된다.)
- `rand`값에는 1~5 사이의 값을 랜덤하게 저장.

```php
$rand=rand(1,5);

if($rand==1)
{
$result=@mysql_query("select lv from lv1 where lv=($go)") or die("nice try!");
}

if($rand==2)
{
$result=@mysql_query("select lv from lv1 where lv=(($go))") or die("nice try!");
}

if($rand==3)
{
$result=@mysql_query("select lv from lv1 where lv=((($go)))") or die("nice try!");
}

if($rand==4)
{
$result=@mysql_query("select lv from lv1 where lv=(((($go))))") or die("nice try!");
}

if($rand==5)
{
$result=@mysql_query("select lv from lv1 where lv=((((($go)))))") or die("nice try!");
}

$data=mysql_fetch_array($result);
if(!$data[0]) { echo("query error"); exit(); }
if($data[0]!=1 && $data[0]!=2) { exit(); }

```

- `date[0]`가 2가 나오면 문제 해결.

```php
if($data[0]==1)
{
echo("<input type=button style=border:0;bgcolor='gray' value='auth' onclick=
alert('Access_Denied!')><p>");
echo("<!-- admin mode : val=2 -->");
}

if($data[0]==2)
{
echo("<input type=button style=border:0;bgcolor='gray' value='auth' onclick=
alert('Congratulation')><p>");
@solve();
} 
```

- 주석대로 val에 union을 사용한다.
- `val = 1` 뒤에 `union select 2`을 써야하는데 `2`는 필터링 되므로 우회해야한다.
- 따라서, `val=1` 뒤에 `union SELECT (2` 입력
- `Access Denied!`라고 나온다. (어쩌란건지...)
- `2` 필터링을 피하기 위해 여러가지(삽질)을 시도한 결과
- `)union select(3-1` 입력
- 이번엔 `cannot use space`가 나온다. (...)
- `Space`를 우회해야한다는 건데...
- URL인코딩표를 보면 (공백, space)`' '` = `%0A` 라는 것을 알 수 있다.
- 그래서 `var=1)%0Aunion%0Aselect%0A(3-1` 입력.
- `nice try`라고 잠깐 뜨고 초기화면이 나온다.(일단 좋은 시도라니깐 참고 진행)
- 이번엔 var=2로 변경해서 그대로 입력 `var=2)%0Aunion%0Aselect%0A(3-1`
- val=1과 같은 반응을 한다.
- 이번엔 val값을 0으로 해서 입력해보았다. (0이 제일 만만해서 넣은건 아님)
- `var=0)%0Aunion%0Aselect%0A(3-1` 입력
- 문제 해결
