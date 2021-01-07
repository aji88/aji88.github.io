---

title: git clone 所有版本
date: 2021-01-07 11:51:55
categories:
- git
tags:
- git
---

默认情况下，git clone只会clone指定的默认版本，一般是master,这个需要git管理员在后台设定（编辑HEAD文件）。

````
##clone默认版本
git clone https://xxx.github.com/xxx/xxx

##clone指定版本
git clone -b b1 https://xxx.github.com/xxx/xxx

##clone 所有版本
##查看远程分支情况
git branch -r

##checkout远程仓库origin的分支dev，在本地起名为dev分支，并切换到本地的dev分支 
git checkout -b dev origin/dev


````
