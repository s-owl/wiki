# 위키 수정 가이드

위키의 컨텐츠를 수정하려면, 위키 컨텐츠를 보관하는 [저장소](https://github.com/skhu-sss/skhu-sss.github.io) 에 대한 쓰기 권한이 먼저 필요합니다. 저장소 관리자에게 문의하여 쓰기 권한을 먼저 얻으세요.

## 기본적인 컨텐츠 수정 방법

 - 저장소를 로컬로 복제 하고, `src` 가지로 변경합니다. 모든 위키 컨텐츠 수정은 `src` 가지에서 이뤄집니다. 컨텐츠가 수정 될 때 마다, `master` 가지에 온라인에 보일 웹페이지 파일이 자동으로 생성되어 올라가므로 건들지 않도록 합니다.

``` bash
git clone src https://github.com/skhu-sss/skhu-sss.github.io
```

 - 원하는 문서를 수정합니다. 단, `.travis.yml`, `deploy_rsa.enc` 파일은 웹페이지 생성 및 배포 설정을 수정해야 하는 경우가 아니면 수정하지 않습니다.
 - 문서는 마크다운 문법으로 작업 하시면 됩니다.
 - 새로운 문서를 추가한 경우 사이드바에 보이도록 `SUMMARY.md` 파일을 수정합니다.

 ```md
 # Summary

 * [홈 화면](README.md)
 * [위키 수정 가이드](HowToEdit.md)
 * [<사이드바에 표시할 제목>](문서_파일_경로<상대경로>.md)
```

 - 커밋하고 `src` 가지에 푸시 합니다. `master` 가지에는 푸시 하시면 안 됩니다. 웹 사이트 갱신중 오류가 발생 할 수 있습니다.

 ```bash
 git add .
 git commit -m "변경 사항에 대한 설명"
 git push origin src
 ```

  - [위키 사이트](에 접속하여, 변경 사항이 적용 되었는지 확인합니다.)
  - [여기](https://travis-ci.org/skhu-sss/skhu-sss.github.io)에서 사이트 업데이트 현황을 확인 하실 수 있습니다.
  
