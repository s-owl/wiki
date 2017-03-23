# Chocolatey

> Windows 를 위한 패키지 관리자.

## 설치

PowerShell V3 이상의 환경에서 설치하는 경우, PowerShell 에서 아래와 같은 명령줄을 실행합니다.

```ps
iwr https://chocolatey.org/install.ps1 -UseBasicParsing | iex
```

명령 프로포트를 이용하여 설치하고자 하는 경우, 아래와 같은 명령어를 명령 프롬포트에서 실행합니다.

```cmd
@powershell -NoProfile -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"
```

설치가 잘 되었는지 확인하려면, 명령 프롬포트나 PowerShell 에서 다음을 실행해 봅니다.

```cmd
choco
```

좀 더 자세한 설치 방법은 [여기](https://chocolatey.org/install) 를 참고하세요.

### 사용법

먼저 설치할 패키지를 검색해 봅시다. 아래와 같은 명령줄을 실행하여 검색합니다.

```ps
choco search <keyword>
```

>예제 : git 이라는 키워드로 패키지 검색.
```ps
choco search git
```

설치하려면, `install` 명령을 사용합니다.

> 예제 : git 설치
```ps
choco install git
```

설치한 패키지를 업그레이드 하려면, `upgrade` 명령을 사용합니다.

> 예제 : git 패키지 업그레이드
```ps
choco upgrade git
```

> 예제 : 설치된 모든 패키지 업그레이드
```ps
choco upgrade all
```

`uninstall` 명령으로 패키지를 제거합니다.

> 예제 : git 패키지 제거
```ps
choco uninstall git
```

> 모든 Chocolatey 패키지 제거
```ps
choco uninstall all
```
