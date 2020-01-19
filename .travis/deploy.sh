#!/bin/bash
# deploy
- openssl aes-256-cbc -K $encrypted_f07b2428cec6_key -iv $encrypted_f07b2428cec6_iv -in ./deploy_rsa.enc -out ~/.ssh/deploy_rsa -d
chmod 600 ~/.ssh/deploy_rsa
eval $(ssh-agent)
ssh-add ~/.ssh/deploy_rsa
cp ./ssh_config ~/.ssh/config
git config --global user.name "aji88"
git config --global user.email "y_m_z@126.com"
cd ../public
git init
git config user.name "aji88"
git config user.email "y_m_z@126.com"
git add .
git commit -m "add/edit"
git push --force git@github.com:aji88/blog.git master:master