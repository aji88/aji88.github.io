---
title: Travis CI 部署hexo到github
---
GitHub版本管理hexo写的博客源代码，Travis CI自动生成并部署到github的另外分支。完成自动部属。
以下所有的操作都在Linux下完成，window下不保证能成功。

<!--more-->

## Travis CI 客户端的安装
````ruby

gem install travis

````

## 生成SSH公私钥匙文件
````sh

ssh-keygen -t rsa -C 'youremail' -b 4096 -f ./deploy_rsa

````
## Travis CI 加密ssh密钥
````
travis login --pro
travis encrypt-file deploy_rsa --add -r 'owener/reposity' --pro
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