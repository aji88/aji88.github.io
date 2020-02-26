---
title: GIT 远程仓库
date: 2020-02-26 14:57:24
categories:
- git
tags:
- git
---

git远程仓库[官方参考文档](https://git-scm.com/book/zh/v2/Git-%E5%9F%BA%E7%A1%80-%E8%BF%9C%E7%A8%8B%E4%BB%93%E5%BA%93%E7%9A%84%E4%BD%BF%E7%94%A8) 


## 查看远程仓库
````
git remote -v
````

## 添加远程仓库
````
#git remote add <shortname> <url> 
git remote add pb https://github.com/paulboone/ticgit
````
现在你可以在命令行中使用字符串 pb 来代替整个 URL。 例如，如果你想拉取 Paul 的仓库中有但你没有的信息，可以运行 git fetch pb

## 从远程仓库中抓取与拉取
````
#抓取
git fetch [remote-name]

````

## 推送到远程仓库
````
git push [remote-name] [branch-name]
````
当你想要将 master 分支推送到 origin 服务器时（再次说明，克隆时通常会自动帮你设置好那两个名字），那么运行这个命令就可以将你所做的备份到服务器：
````
git push origin master
````

## 查看某个远程仓库
````
git remote show [remote-name] 
````

## 远程仓库的移除与重命名
````
#重命名
git remote rename [remote-name]  [new-remote-name] 

#移除
git remote rm [remote-name]
````

