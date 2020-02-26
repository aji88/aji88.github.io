---
title: git基础操作
date: 2020-02-24 16:46:24
categories:
- git
tags:
- git
---
git的[官方网站](https://git-scm.com/) 
git的[官方文档](https://git-scm.com/docs/) 
git的各种常用基础操作

## 初始化(init)
详见[官方文档](https://git-scm.com/docs/git-init)
````
#使用当前目录作为仓库
git init

#使用指定目录作为仓库
git init newrepro
````

## 克隆远程仓库(clone)
详见[官方文档](https://git-scm.com/docs/git-clone)
````
#格式
git clone <repo>
#克隆到指定目录
git clone <repo> <directory>

git clone git@github.com:account/repositories.git
````
<!--more-->
## 查看当前仓库状态(status)
详见[官方文档](https://git-scm.com/docs/git-status)
````
git status
````

## 提交变化到暂存区(add)
详见[官方文档](https://git-scm.com/docs/git-add)
````
#提交指定文件
git add filename
#提交所有修改和新增的文件，不包括删除的
git add .
#提交所有的文件，包括：新增、修改、删除
git add -A
git add -all
````
## 撤回暂存区的提交
````
#撤销所有
git reset HEAD -- .

#撤销特定目标
git reset HEAD -- filename 

#将文件从缓存中删除
git rm -cached filepath

````

## 查看改动
````
#尚未缓存(暂存)的改动
git diff

#查看已缓存的改动
git diff --cached

#查看已缓存的与未缓存的所有改动
git diff HEAD

#显示摘要而非整个
diff：git diff --stat

````

## 提交暂存区文件到仓库
````
git commit -m 'message'
````