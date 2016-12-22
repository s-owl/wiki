# 파이썬 기초 스터디

## 스터디 개요
- 기간 : 2016.12.27일 부터 약 5~6주
- 스터디 리더 : 한영빈(소프16)
- 스터디 방식 : 미정, 별다른 의견 없으면 각자 공부해와서 질의응답 방식 고려중
- 교재 : [점프 투 파이썬](https://wikidocs.net/book/1) + 추가적인 서적이나 인터넷 자료
- 구성원 : 한영빈(소프16), 김지연(소프16), 송지은(소프15), 배다슬(소프12), 김재경(소프12)
- 스터디 모임 시각 : 매주 화요일 오후 2시~4시 - 3주차 모임은 목요일
- 모임 장소 : SSS 랩실

## 계획중인 스터디 커리큘럼
- 시작 전 : 스터디 방식 등 수립
- 1주차 : 0~3장
- 2주차 : 4장
- 3주차 : 5장
- 4주차 : 6장
- 5주차 : 7장

## 1주차 모임
- 2016.12.27
- 참석자 :
- 결석 :

### Python 설치
- 이 스터디에서는 Python 3 를 사용합니다. 그러므로, Python 3 를 설치합시다. Python 2 는 오래 된 것도 있고, 새로 나오는 라이브러리나 프레임워크, 자료 등이 Python 3 을 기반으로 하기 때문입니다.

#### Windows
[Python 홈페이지](https://www.python.org) 에서 설치 마법사를 내려받아, 설치 마법사의 안내에 따라 설치합니다.
[여기](https://www.python.org/downloads/windows/) 를 눌러 설치 마법사 다운로드 페이지로 이동합니다.

`chocolatey` 패키지 관리자를 사용하시는 경우, 명령 프롬포트나 Windows PowerShell 를 관리자 권한으로 켜고, 다음을 실행하여 설치할 수도 있습니다.

```posh
choco install python
```

#### Linux
보통 리눅스에는 Python 이 설치되어 있습니다. 그러나 설치되지 않는 경우도 있고, Python 2 가 설치된 경우도 있습니다.

Arch Linux 의 경우, `pacman`을 사용하여 `python` 패키지를 설치하면, 최신 버전의 Python 3 가 설치됩니다.

```bash
sudo pacman -S python
```

Ubuntu 의 경우 배포판 버전에 따라 제공되는 패키지 이름에 차이가 있습니다. Ubuntu 16.04 에서는 `python3` 패키지를 `apt` 로 설치합니다.

```bash
sudo apt install python3
```

#### macOS
Windows 와 마찬가지로 설치마법사를 이용하여 설치할 수 있습니다. [여기를 클릭하여 설치마법사 다운로드 페이지로 이동합니다.](https://www.python.org/downloads/mac-osx/)

또는, [Homebrew](http://brew.sh/) 를 사용 하시는 경우, 다음을 실행하여 설치하실 수 있습니다.

```bash
brew install python3
```
