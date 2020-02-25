---
title: git基础操作
date: 2020-02-24 16:46:24
categories:
- git
tags:
- git
---
git的各种常用基础操作

## 初始化
````
mkdir mycode
cd mycode
git init
````

## 克隆远程仓库
````
git clone git@github.com:account/repositories.git
````

## 查看当前仓库状态
````
git status
````

## 提交变化到暂存区
````
git add filename
git add .
git add -all
````

## 提交暂存区文件到仓库
````
git commit -m 'message'
````