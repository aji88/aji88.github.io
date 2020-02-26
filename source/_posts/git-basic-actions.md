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

## 取消工作区的修改(没有暂存的内容)
````
git checkout -- filename
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
使用 git add 命令将想要快照的内容写入缓存区， 而执行 git commit 将缓存区内容添加到仓库中。
Git 为你的每一个提交都记录你的名字与电子邮箱地址，所以第一步需要配置用户名和邮箱地址。
````
git config --global user.name 'runoob'
git config --global user.email test@runoob.com
````
提交到本地仓库
````
git commit -m 'message'
````

如果你觉得 git add 提交缓存的流程太过繁琐，Git 也允许你用 -a 选项跳过这一步。
````
git commit -am 'message'
````

这个命令会将暂存区中的文件提交。 如果自上次提交以来你还未做任何修改（例如，在上次提交后马上执行了此命令），那么快照会保持不变，而你所修改的只是提交信息。
````
git commit -amend
````

## 查看提交历史
### git log [的常用选项](https://git-scm.com/book/zh/v2/ch00/rlog_options)
````
#不带参数显示
git log

#显示每次提交所引入的差异,使用 -2 选项来仅显示最近的两次提交
git log -p -2

#当进行代码审查，或者快速浏览某个搭档提交的 commit 所带来的变化的时候，这个参数就非常有用了。 
#你也可以为 git log 附带一系列的总结性选项。 比如你想看到每次提交的简略统计信息，可以使用 --stat 选项
git log --stat

#不同格式的展示方式,oneline,short,full,fuller
git log --pretty=oneline

#还可以定制自己的format
git log --pretty=format:"%h - %an, %ar : %s"
````
git log --pretty=format [常用的选项](https://git-scm.com/book/zh/v2/ch00/rpretty_format) 列出了常用的格式占位符写法及其代表的意义

| 选项 | 说明 |
| ---- | ---- |
|  --p | 按补丁格式显示每个提交引入的差异。|
|  --stat | 显示每次提交的文件修改统计信息。|
|  --shortstat | 只显示 --stat 中最后的行数修改添加移除统计。|
|  --name-only | 仅在提交信息后显示已修改的文件清单。|
|  --name-status | 显示新增、修改、删除的文件清单。|
|  --abbrev-commit | 仅显示 SHA-1 校验和所有 40 个字符中的前几个字符。|
|  --relative-date | 使用较短的相对时间而不是完整格式显示日期（比如，“2 weeks ago”）。|
|  --graph | 在日志旁以 ASCII 图形显示分支与合并历史。|
|  --pretty | 使用其他格式显示历史提交信息。可用的选项包括 oneline，short，full，fuller 和 format（用来定义自己的格式）。|

### 限制输出长度
除了定制输出格式的选项之外，git log 还有许多非常实用的限制输出长度的选项，也就是只输出一部分的提交.

列出最近两周的所有提交
````
git log --since=2.weeks
````
该命令可用的格式十分丰富——可以是类似 "2008-01-15" 的具体的某一天，也可以是类似 "2 years 1 day 3 minutes ago" 的相对日期。

在 限制 git log [输出的选项](https://git-scm.com/book/zh/v2/ch00/rlimit_options) 中列出了常用的选项
| 选项 | 说明 |
| ---- | ---- |
|  -(n) | 仅显示最近的 n 条提交。|
|  --since, --after | 仅显示指定时间之后的提交。|
|  --until, --before | 仅显示指定时间之前的提交。|
|  --author | 仅显示作者匹配指定字符串的提交。|
|  --committer | 仅显示提交者匹配指定字符串的提交。|
|  --grep | 仅显示提交说明中包含指定字符串的提交。|
|  -S | 仅显示添加或删除内容匹配指定字符串的提交。|

