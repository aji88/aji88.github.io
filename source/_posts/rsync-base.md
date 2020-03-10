---
title: rsync入门
date: 2020-03-10 11:20:24
categories:
- linux
tags:
- linux,rsync
---

## rsync简介
rsync官方网站: [https://www.samba.org/ftp/rsync/rsync.html](https://www.samba.org/ftp/rsync/rsync.html)


rsync是可以实现增量备份的工具。配合任务计划，rsync能实现定时或间隔同步，配合inotify或sersync，可以实现触发式的实时同步。

rsync可以实现scp的远程拷贝(rsync不支持远程到远程的拷贝，但scp支持)、cp的本地拷贝、rm删除和"ls -l"显示文件列表等功能。但需要注意的是，rsync的最终目的或者说其原始目的是实现两端主机的文件同步，因此实现的scp/cp/rm等功能仅仅只是同步的辅助手段，且rsync实现这些功能的方式和这些命令是不一样的。事实上，rsync有一套自己的算法，其算法原理以及rsync对算法实现的机制可能比想象中要复杂一些。平时使用rsync实现简单的备份、同步等功能足以，没有多大必要去深究这些原理性的内容。但是想要看懂rsync命令的man文档、使用"-vvvv"分析rsync执行过程，以及实现rsync更强大更完整的功能，没有这些理论知识的支持是绝对不可能实现的。本篇文章将简单介绍rsync的使用方法和它常用的功能

<!--more-->

## centos 7上rsync的安装
````bash
# yum安装
yum install -y rsync

#编译安装
wget https://download.samba.org/pub/rsync/rsync-3.1.3.tar.gz
tar -xvf rsync-3.1.3.tar.gz
cd rsync-3.1.3
./configure --prefix=/usr/local/rsync/
make && make install
````
## rsync的基本语法
````
# 详细语法可以 man rsync
Local:  rsync [OPTION...] SRC... [DEST]

Access via remote shell:
    Pull: rsync [OPTION...] [USER@]HOST:SRC... [DEST]
    Push: rsync [OPTION...] SRC... [USER@]HOST:DEST

Access via rsync daemon:
    Pull: rsync [OPTION...] [USER@]HOST::SRC... [DEST]
        rsync [OPTION...] rsync://[USER@]HOST[:PORT]/SRC... [DEST]
    Push: rsync [OPTION...] SRC... [USER@]HOST::DEST
        rsync [OPTION...] SRC... rsync://[USER@]HOST[:PORT]/DEST

````

## rsync 本地文件同步
````bash
# 同步dir1下的所有文件和文件夹到dir2目录
rsync -axv dir1 dir2

# 同步dir1下的所有文件和文件夹到dir2目录，但不包括dir1目录
rsync -axv dir1/ dir2

````

## rsync 通过ssh同步到远程机器
````bash
# 本地dir1同步到192.168.10.2的/dir2
rsync -axv dir1 root@192.168.10.2::/dir2

# 192.168.10.2的/dir2同步到本地dir1
rsync -axv root@192.168.10.2::/dir2 dir1

rsync -av -e "ssh -l ssh-user" rsync-user@host::module /dest

````

## 服务器端/客户端 daemon守护进程
````bash
#服务器端
rsync --daemon --config=/etc/rsyncd.conf

#客户端
sync -av /home/vagrant/download jim@192.168.10.3::ftp --password-file=/etc/rsyncd.pwd
````

## 服务器端配置文件
1.服务器端的配置文件默认为 /etc/rsyncd.conf,此文件的权限必须是600,可以man rsyncd.conf查看配置说明
如果文件不存在，可以新增如下文件:
````bash
# /etc/rsyncd: configuration file for rsync daemon mode

# See rsyncd.conf man page for more options.

# configuration example:

uid = rsync
gid = rsync
use chroot = yes
max connections = 20

pid file = /var/run/rsyncd.pid
lock file=/var/rsynclog/rsync.lock
log file=/var/rsynclog/rsyncd.log

# 全局设置
# exclude = lost+found/
# transfer logging = yes
# timeout = 900
# ignore nonreadable = yes
# dont compress   = *.gz *.tgz *.zip *.z *.Z *.rpm *.deb *.bz2
# read only = false
# hosts allow = 192.168.253.0/24
# hosts deny = 0.0.0.0/32 
# auth users = rsync_backup 
# secrets file = /etc/rsync.password 

# 模块
# 同步语法: rsync -axv dir1 rsync@remote::/ftp
[ftp]
    path = /home/ftp                    # 需要同步的路径
    comment = ftp export area           # 注解说明
    secrets file=/etc/rsyncd.secrets    # 授权用户密码文件
    read only = false                   # 可写
    auth users = kob                    # 授权用户
````

2.生成用户账号配置文件，/etc/rsyncd.secrets,每一行标识一个用户，格式为 用户名:密码
````
kob:rsyncpwd
````

## 配置客户端用户密码文件
只需要填写访问用户的密码即可
````
rsyncpwd
````
客户端推送同步(push)：
````bash
sync -av /home/vagrant/download kob@192.168.10.3::ftp --password-file=/etc/rsyncd.pwd
````

客户端拉取同步(pull)：
````bash
sync -av kob@192.168.10.3::ftp --password-file=/etc/rsyncd.pwd /home/vagrant/download
````



