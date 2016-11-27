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
 - 한영빈 :
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
