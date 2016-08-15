#[SKHU] 불여우와 함께 숲으로 들어가기
##1. 개요
학교에서 사용하는 [종합정보시스템](https://forest.skhu.ac.kr)은 기본적으로 익스플로러만 지원하기 때문에 타 브라우저나 모바일에서 접근하는데 많은 무리가 있다. 서버에서 클라이언트(그러니까 접속자)의 정보를 확인할 때 user-agent를 통해 확인한다. 종합정보 시스템의 경우에는 `CoreIECheck.js` 라는 자바스크립트에서 클라이언트의 user-agent가 MSIE가 아닌 경우 MS 홈페이지로 보내버린다.

##2. PC 파이어폭스에서 우회하기
파이어폭스 애드온중 [Adblock Plus](https://addons.mozilla.org/en-US/firefox/addon/adblock-plus/)라는 애드온이 있다. 원래는 여러 광고를 차단해주는 목적으로 만들어진 애드온이지만 특정 자바스크립트의 실행도 차단해줄 수 있다.
  
먼저 애드블록플러스를 파이어폭스에 추가하고 Fliter Preferences로 들어가 Custom filters탭에서 필터를 추가한다. 필터 규칙(rule)은 `||forest.skhu.ac.kr/Gate/Common/JavaScript/CoreIECheck.js`를 입력해서 활성화 시키고 다시 종합정보 시스템으로 접근하면 해당 자바스크립트가 실행되지 않는 것을 확인할 수 있다.

##3. 모바일 파이어폭스에서 우회하기
  
**16. 08. 15 현재 동작하지 않고 있기 때문에 확인이 필요합니다.**
  
*(안드로이드 기준으로 작성)*
모바일에서는 아직 특정 자바스크립트를 차단하는 항목은 확인할 수 없었다. 하지만 위에서 언급한 user-agent를 통해서 IE인척 접속 할 수 있었다. 먼저 모바일 파이어폭스를 키고 주소창에 `about:config`를 입력한다. 파이어폭스의 거의 모든 설정은 여기서 조작할 수 있다고 보면 된다. 왼쪽 상단에 있는 +표시를 눌러 사용자 정의 값을 입력할 수 있다. 이름 부분에 `general.useragent.override`를 입력하고 문자열로 바꿔 `Mozilla/5.0 (Windows NT 10.0; WOW64; Trident/7.0; rv:11.0) like Gecko`를 입력한다. 이는 Windows 10의 IE11로 접속시 나타나는 user-agent 값이다. 값을 설정했으면 다시 종합정보시스템에 접속해본다.
  
하지만 이 방법을 사용하면 모바일 파이어폭스에서 다른 애드온을 사용할 수 없게 된다고하니 참고하자. 다시 파이어폭스로 돌아가고 싶으면 해당 값을 지우면 된다.

##4. 참고문헌

- https://msdn.microsoft.com/en-us/library/hh869301(v=vs.85).aspx
- http://superuser.com/questions/98798/how-do-i-change-firefoxs-user-agent-via-aboutconfig
- https://forest.skhu.ac.kr/Gate/Common/JavaScript/CoreIECheck.js
- https://en.wikipedia.org/wiki/User_agent
- http://www.whoishostingthis.com/tools/user-agent/
