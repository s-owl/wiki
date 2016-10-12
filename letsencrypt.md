# Let's Encrypt

무료로 SSL/TLS 인증서를 제공하는 인증 기관입니다. 서비스는 Internet Security Research Group (ISRG) 에서 제공합니다.
인증서를 발급하려면, Let's Encrypt 에서 제공하는 발급 도구인 `Certbot` 을 이용하거나, 다른 개발자가 개발한 인증서 발급 도구를 사용할 수 있습니다.

## 인증서 발급하기
(작성중...)

## 인증기관(CA, Certificate Authority) URL
- Staging : 테스트 전용 - 여기서 발급된 인증서는 대다수의 클라이언트가 신뢰하지 않음
  - https://acme-staging.api.letsencrypt.org/directory

 - Production : 실제 서비스에 사용할 인증서 발급용
  - https://acme-v01.api.letsencrypt.org/director
