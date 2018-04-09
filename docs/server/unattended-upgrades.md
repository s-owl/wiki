# unattended-upgrades

패키지 관리자로 APT 를 사용하는 대부분의 Debian 개열 리눅스 배포판에서 사용 가능한 프로그램으로,
최신 버전의 패키지를 자동으로 받아 업그레이드 해 주는 프로그램이다.

## 준비할 것
 - Debian 개열 리눅스가 설치된 인터넷에 연결된 머신
 - ~~타이핑이 가능한 손~~

## 적용 방법
 - `unattended-upgrades` 패키지를 설치한다.
 ```bash
 sudo apt install unattended-upgrades
 ```
 - 다음을 실행하여, `unattended-upgrades` 설정을 시작한다.
 ```bash
 sudo dpkg-reconfigure unattended-upgrades
 ```
 - 다음과 같은 메시지가 나타난다, 기능을 켜겠냐는 소리이다. 당연히 `<Yes>` 를 선택한다.

 ~~~
 Applying updates on a frequent basis is an important part of keeping systems secure. By default, updates need to be applied manually using package management tools. Alternatively, you can choose to have this system automatically download and install important updates.

 Automatically download and install stable updates?

 <Yes> <No>                                                
 ~~~
 - 자동으로 업그레이드 할 패키지들의 `Origin-Pattern` 값을 작성하라는 화면이 나온다. 기본값으로도 적당하고, 추후에 설정 수정이 가능하므로. `<Ok>` 를 선택한다.
 - 기능이 켜졌다.
 - 설정을 수정하려면, `/etc/apt/apt.conf.d/50unattended-upgrades` 파일을 수정한다.
 - 기능을 끄려면, 다음을 실행 후, `<No>` 를 선택한다.
 ```bash
 sudo dpkg-reconfigure unattended-upgrades
 ```

## 참고자료
 - [Dirty COW was livepatched in Ubuntu within hours of publication - Ubuntu Insights](http://insights.ubuntu.com/2016/10/31/dirty-cow-was-livepatched-in-ubuntu-within-hours-of-publication/)
 - [Automatic Updates - Ubuntu Documention](https://help.ubuntu.com/lts/serverguide/automatic-updates.html)
 - [UnattendedUpgrades - Debian Wiki](https://wiki.debian.org/UnattendedUpgrades)
