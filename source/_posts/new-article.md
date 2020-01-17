---
title: Travis CI 部署hexo到github
---
GitHub版本管理hexo写的博客源代码，Travis CI自动生成并部署到github的另外分支。完成自动部署。 

以下所有的操作都在Linux下完成，window下不保证能成功。


<!--more-->

## Travis CI 客户端的安装
````
gem install travis
````

## 生成SSH公私钥匙文件
````sh
ssh-keygen -t rsa -C 'youremail' -b 4096 -f ./deploy_rsa
````
把生成的公钥文件上传到GitHub指定仓库的Deploy Keys下面

## Travis CI 加密ssh密钥
````
travis login --pro
travis encrypt-file deploy_rsa --add -r 'owener/reposity' --pro
````
把生成的deploy_rsa.enc文件复制到同目录的.travis目录下，如果目录不存在，则新建一个目录。 

这个deploy_rsa.enc文件是travis加密的私钥文件，只能travis解密。

这里的--pro不能少，否则会显示repository not known to https://api.travis-ci.org/:

## SSH配置文件ssh_config
````
Host github.com
User git
StrictHostKeyChecking no
IdentityFile ~/.ssh/deploy_rsa
IdentitiesOnly yes
````
## 把部署文件写成deploy.sh脚本
````sh
#!/bin/bash
# deploy
# Decrypt the private key
openssl aes-256-cbc -K $encrypted_b7e9f3138b36_key -iv $encrypted_b7e9f3138b36_iv -in ./deploy_rsa.enc -out ~/.ssh/deploy_rsa -d
# Set the permission of the key
chmod 600 ~/.ssh/deploy_rsa
# Start SSH agent
eval $(ssh-agent)
# Add the private key to the system
ssh-add ~/.ssh/
# Copy SSH config
cp ./ssh_config ~/.ssh/config
cd ../public
git init
# Set Git config
git config --global user.name "github user name"
git config --global user.email "github email account"
git add .
git commit -m "add/edit"
# push to github reposotory
git push --force 仓库地址 master:gh-pages
````

## 修改 .travis.yml文件
````ruby
sudo: false
language: node_js
node_js:
- 10
cache: npm
branches:
  only:
  - master
before_install:
- export TZ='Asia/Shanghai'
install:
- npm install
script:
- hexo clean
- hexo g
after_script:
- cd ./.travis
- sh ./deploy.sh

````