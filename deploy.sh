# Get the deploy key by using Travis's stored variables to decrypt deploy_key.enc
ENCRYPTED_KEY_VAR="encrypted_${ENCRYPTION_LABEL}_key"
ENCRYPTED_IV_VAR="encrypted_${ENCRYPTION_LABEL}_iv"
ENCRYPTED_KEY=${!ENCRYPTED_KEY_VAR}
ENCRYPTED_IV=${!ENCRYPTED_IV_VAR}
openssl aes-256-cbc -K $ENCRYPTED_KEY -iv $ENCRYPTED_IV -in deploy_rsa.enc -out deploy_rsa -d
chmod 600 deploy_rsa
eval `ssh-agent -s`
ssh-add deploy_rsa

git config --global user.name "WikiUpdater"
git config --global user.email "we.sss.you@gmail.com"

git clone git@github.com:skhu-sss/skhu-sss.github.io.git deploy && ls
cd deploy && ls
git checkout master
ls
rm -rf *
ls
cd ..
ls
npm install -g gitbook-cli
ls
gitbook build
ls
cp -a _book/. deploy/
cd deploy
ls
rm .travis.yml
ls
rm deploy.sh
ls
rm deploy_rsa.enc
ls
rm deploy_rsa
ls
git add .
git commit -m "Updated Contents (via Travis CI)"
git push origin master
