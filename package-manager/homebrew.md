# Homebrew

> [Homebrew](https://brew.sh/) - macOS 를 위한 패키지 관리자.

## 설치

아래와 같은 명령줄을 터미널에서 실행합니다.

```bash
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

다음을 실행하여 잘 설치 되었는지 확인합니다.

```bash
brew -v
```

## 사용법

패키지를 검색하려면, `search` 를 사용합니다.

```bash
brew search <keyword>

# Example : Search for Wget
brew search wget
```

설치하려면, `install` 을 사용합니다.

```bash
brew install <package>

# Example : Install Wget
brew install wget
```

설치 중, 문제가 생겨 다시 설치 해야 하는 경우, `reinstall` 을 사용하여 재설치 할 수 있습니다.

```bash
brew reinstall <package>

# Example : Reinstall Wget
brew reinstall wget
```

Homebrew 와 Homebrew 저장소 정보를 최신 버전으로 업데이트 하려면, `update` 를 사용합니다.

```bash
brew update
```

패키지를 업그레이드 하려면, `upgrade` 를 사용합니다.

```bash
# Upgrade All Installed Packages
brew upgrade

# Upgrade wget
brew upgrade wget
```

# Homebrew Cask

[Homebrew Cask](https://caskroom.github.io/) 는 Homebrew 패키지 관리자를 위한 제3자 패키지 저장소 입니다. 이 저장소를 이용하면, Homebrew 를 이용하여 개발 툴 등의 명령줄 기반 소프트웨어 뿐만 아니아, 구글 크롬 등의 GUI기반 응용 소프트웨어도 설치할 수 있습니다.

Homebrew Cask 저장소를 추가하고 활성화 하려면, 아래와 같은 명령줄을 실행합니다.

```bash
brew tap caskroom/cask
```

Homebrew Cask 에서 패키지를 설치하려면, 아래와 같은 방식으로 명령줄을 실행합니다.

```bash
brew cask install <package>
```

예를 들어, 구글 크롬을 설치하려면, 아래와 같은 명령줄을 실행합니다.

```bash
brew cask install google-chrome
```

패키지 업그레이드, 제거 등은 다른 Homebrew 패키지를 관리하는 데 사용하는 명령과 동일합니다. 설치할 때 사용하는 명령에만 차이가 있습니다.
