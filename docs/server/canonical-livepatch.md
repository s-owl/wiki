# 캐노니컬 라이브패치 서비스(Canonical Livepatch Service)

라이브패치 서비스를 사용하면, 우분투에서 중요한 커널 패치를 **재부팅 없이** 적용할 수 있습니다.
때문에, 우분투를 이용하여 서버를 운영하는 경우, 라이브패치 서비스를 이용하면, 재부팅으로 인해 서비스 중단이 생기는 경우가 없어지는 장점을 얻을 수 있습니다.

## 서비스 요금
 - 일반 사용자 : 우분투 원 계정이 있는 경우, 최대 3대의 서버/데스크탑/VM 에서 무료로 사용이 가능합니다. 그 이상의 장치에서 사용 하려는 경우, Ubuntu Avantage 프로그램에 구독해야 합니다.
 - Ubuntu Advantage 구독자 : 이미 구독중인 경우 추가적으로 비용을 지불하지 않아도 됩니다.
  - Ubuntu Advantage for Servers 의 Essential Server 요금은 노드(머신) 1개당 1년에 150USD 입니다.
  - Ubuntu Advantage 요금에 대한 상세 사항은 https://buy.ubuntu.com/ 을 참조하세요.

## 준비할 것
 - 우분투 원 계정
  - 없는 경우, https://login.ubuntu.com 에서 무료로 생성 가능합니다.
 - 인터넷 연결이 있는 Ubuntu 16.04 LTS x86 64bit 버전이 설치된 머신

## 설치 및 설정하기
 - 아래 링크로 이동한 다음, `Sign up` 을 눌러 시작합니다.
  - https://www.ubuntu.com/server/livepatch
 - 그럼 https://auth.livepatch.canonical.com/ 로 이동되는데, 이 페이지에서 `Ubuntu user` 를 선택하고, `Get Your Token` 을 눌러 계속합니다.
  - Ubuntu Advantage 구독자인 경우, `Ubuntu Advantage customer` 를 선택합니다.
 - 우분투 원 계정으로 로그인 하지 않은 경우, 로그인 화면이 나타납니다. 본인의 계정으로 로그인 합니다.
 - 로그인 후에, 캐노니컬 라이브패치 서비스 사용에 필요한 키값이 화면에 표시됩니다.
 - 라이브패치 서비스를 사용할 머신에 접속합니다.
 - 라이브패치 서비스에 필요한 패키지인 `canonical-livepatch` 는 `snap` 패키지로 제공됩니다. 아직 `snap` 패키지 관리자가 설치되어 있지 않은 경우, 아래와 같은 방법으로, `snapd` 패키지를 설치합니다.
 ```bash
 sudo apt install snapd
 ```
 - `canonical-livepatch` 패키지를 설치합니다.
 ```bash
 sudo snap install canonical-livepatch
 ```
 - 다음과 같은 방법으로 라이브패치 서비스를 켭니다.
 ```bash
 sudo canonical-livepatch enable (KEY)
 ```
  - `(KEY)` 에는 앞서 라이브패치 서비스에서 로그인 후 화면에 표시된 키값으로 넣어주면 됩니다. 예를 들어, 키값이 `45bf098767b84abcspt71d7aedc12345` 라면, 아래와 같은 명령을 실행합니다.
  ```bash
  sudo canonical-livepatch enable 45bf098767b84abcspt71d7aedc12345
  ```
 - 라이브패치 서비스가 켜졌습니다. 라이브패치 상태를 확인하려면, 아래와 같은 명령줄을 실행하여 확인할 수 있습니다.
```bash
canonical-livepatch status --verbose
```
 - 라이브패치 서비스를 끄려면, 아래와 같은 명령줄을 실행합니다.
 ```bash
 sudo canonical-livepatch disable
 ```

## 참고자료 및 유용한 링크
 - [UPDATE UBUNTU 16.04 LTS LINUX KERNEL WITHOUT REBOOTING WITH THE CANONICAL LIVEPATCH SERVICE | Web Up8](http://www.webupd8.org/2016/10/update-ubuntu-1604-lts-linux-kernel.html?m=1)
 - [Canonical enterprise kernel livepatch service, free to Ubuntu community!](https://lists.ubuntu.com/archives/ubuntu-announce/2016-October/000214.html)
 - [Canonical Livepatch Service | Server | Ubuntu](https://www.ubuntu.com/server/livepatch)
 - [Canonical Livepatch Service](https://auth.livepatch.canonical.com/)
 - [The Canonical Livepatch Service - Apply critical kernel patches without rebooting](https://pages.ubuntu.com/rs/066-EOV-335/images/20161017_LivePatching_DS_.pdf)
 - [Install the Canonical Livepatch service in less than a minute! | YouTube](https://www.youtube.com/watch?v=9hvqFfwE4u0)
