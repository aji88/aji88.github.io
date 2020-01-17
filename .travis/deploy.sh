#!/bin/bash
# deploy
openssl aes-256-cbc -K $encrypted_b7e9f3138b36_key -iv $encrypted_b7e9f3138b36_iv -in ./deploy_rsa.enc -out ~/.ssh/deploy_rsa -d
chmod 600 ~/.ssh/deploy_rsa
eval $(ssh-agent)
ssh-add ~/.ssh/
cp ./ssh_config ~/.ssh/config
git config --global user.name "aji88"
git config --global user.email "y_m_z@126.com"
cd ../public
git init
git config user.name "aji88"
git config user.email "y_m_z@126.com"
git add .
git commit -m "add/edit"
git push --force git@github.com:aji88/blog.git master:gh-pages