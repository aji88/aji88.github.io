---
title: inotify简介
date: 2020-03-10 16:40:24
categories:
- linux
tags:
- linux,inotify
---

## inotify简介
Inotify是Linux内核自带（2.6.13）的系统事件监控机制。Inotify优点之一是基于内核事件通知机制，无需定时主动探测文件状态，简单可靠。另一个好处是有文件变化时通知时候，可以记录当时的用户和事件进程。基于Inotify的工具有inotify-tools、sersync和lsyncd等。

inotify提供了一种监控文件系统事件的机制，可以用来监控单个的文件以及目录。当一个目录被监控，inotify会返回该目录以及该目录下面文件的事件。

<!--more-->

## 查看Linux系统内核,必须是2.6.13以上的内核。
````bash
[root@localhost download]# uname -r
3.10.0-1062.el7.x86_64

# 必须有这3个文件
[root@localhost download]# ls /proc/sys/fs/inotify
max_queued_events  max_user_instances  max_user_watches
````


## 安装inotify-tools
从[https://pkgs.org/download](https://pkgs.org/download) 下载并安装inotify-tools
````bash
wget https://download-ib01.fedoraproject.org/pub/epel/7/x86_64/Packages/i/inotify-tools-3.14-9.el7.x86_64.rpm

rpm -ivh inotify-tools-3.14-9.el7.x86_64.rpm
````


## inotifywait使用
````bash
inotifywait -mrq -e 'create,delete,close_write,attrib,moved_to' --timefmt '%Y-%m-%d %H:%M' --format '%T %w%f %e' /home/ftp
````
1、参数说明：
````bash
-m,–monitor：始终保持事件监听状态   # 重要参数
-r,–recursive：递归查询目录     # 重要参数
-q,–quiet：只打印监控事件的信息     # 重要参数
–excludei：排除文件或目录时，不区分大小写
-t,–timeout：超时时间
–timefmt：指定时间输出格式  # 重要参数
–format：指定信息输出格式       # 重要参数
-e,–event：后面指定删、增、改等事件 # 重要参数

--format 参数：
%w     This will be replaced with the name of the Watched file on which an event occurred.

%f     When an event occurs within a directory, this will be replaced with the  name  of  the
        File  which caused the event to occur.  Otherwise, this will be replaced with an empty
        string.

%e     Replaced with the Event(s) which occurred, comma-separated.

%Xe    Replaced with the Event(s) which occurred, separated by whichever character is in  the
        place of `X'.

%T     Replaced  with the current Time in the format specified by the --timefmt option, which
        should be a format string suitable for passing to strftime(3).

````
2、inotifywait events 事件说明：
````bash
access：读取文件或目录内容
modify：修改文件或目录内容
attrib：文件或目录的属性改变
close_write：修改真实文件内容   # 重要参数
close_nowrite：文件或目录关闭，在只读模式打开之后关闭的
close：文件或目录关闭，不管读或是写模式
open：文件或目录被打开
moved_to：文件或目录移动到
moved_from：文件或目录从移动
move：移动文件或目录移动到监视目录  # 重要参数
create：在监视目录下创建文件或目录  # 重要参数
delete：删除监视目录下的文件或目录  # 重要参数
delete_self：文件或目录被删除，目录本身被删除
unmount：卸载文件系统
````
3、脚本监控
````bash
#!/bin/bash

Path=/home/test
Server=192.168.0.2
User=sync
module=sync_file

monitor() {
  /usr/bin/inotifywait -mrq --format '%w%f' -e create,close_write,delete $1 | while read line; do
    if [ -f $line ]; then
      rsync -avz $line --delete ${User}@${Server}::${module} --password-file=/etc/rsyncd.pass
    else
      cd $1 &&
        rsync -avz ./ --delete ${User}@${Server}::${module} --password-file=/etc/rsyncd.pass
    fi
  done
}

monitor $Path;


````