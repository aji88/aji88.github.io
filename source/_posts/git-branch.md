---
title: git分支基础操作
date: 2020-02-24 16:46:24
categories:
- git
tags:
- git
---
git分支的各种常用基础操作

## 查看分支
````
#所有分支的一个列表
git branch

* admin
  develop
  master

#列出所有分支，包括本地的，远程的
git branch -a

* hexo
  master
  remotes/origin/HEAD -> origin/master
  remotes/origin/hexo
  remotes/origin/master

#查看远程分支列表
git branch -r

origin/HEAD -> origin/master
  origin/hexo
  origin/master

#查看每一个分支的最后一次提交
git branch -v

  iss53   93b412c fix javascript issue
* master  7a98805 Merge branch 'iss53'
  testing 782fd34 add scott to the author list in the readmes

#查看哪些分支已经合并到当前分支，可以运行 git branch --merged
git branch --merged

  iss53
* master

#查看所有包含未合并工作的分支，可以运行 git branch --no-merged：
git branch --no-merged
  
  testing
````

## 切换分支
````
#切换到iss52分支
git checkout iss52
````

## 新建分支
````
#创建新的分支iss53 并切换到新的分支iss53
git branch iss53
git checkout iss53

#带上参数 -b,直接创建并切换
git checkout -b iss53


git clone git@github.com:account/repositories.git
````

## 合并分支
````
git checkout master
git merge iss53
````

## 删除分支
````
# 合并后的分支可能已经不需要了，下面删除掉iss53分支
git branch -d iss53
````

## 合并遇到冲突
此时 Git 做了合并，但是没有自动地创建一个新的合并提交。 Git 会暂停下来，等待你去解决合并产生的冲突。 你可以在合并冲突后的任意时刻使用 git status 命令来查看那些因包含合并冲突而处于未合并（unmerged）状态的文件

````
#解决冲突后需要保存变化到暂存区
git add .
git commit -m 'resove conflicts'

#或者取消合并(git merge 后没有add操作)
git merge --abort
````

## 远程分支
[参考](https://git-scm.com/book/zh/v2/Git-%E5%88%86%E6%94%AF-%E8%BF%9C%E7%A8%8B%E5%88%86%E6%94%AF)
远程引用是对远程仓库的引用（指针），包括分支、标签等等。 你可以通过 git ls-remote [remote] 来显式地获得远程引用的完整列表，或者通过 git remote show [remote] 获得远程分支的更多信息。 然而，一个更常见的做法是利用远程跟踪分支
