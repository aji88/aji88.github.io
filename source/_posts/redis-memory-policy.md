---

title: redis 内存淘汰机制
date: 2019-03-02 22:10:01
categories:
- redis
tags:
- redis
---

# Redis的内存淘汰机制策略
Redis的内存淘汰机制策略有8种
* noeviction  默认
* allkeys-lru  
* allkeys-random  
* volatile-lru   
* volatile-random  
* volatile-ttl    


## noeviction
对于写请求不再提供服务，直接返回错误（DEL请求和部分特殊请求除外）

## allkeys-lru
从所有key中使用LRU算法进行淘汰，在键空间中，移除最近最少使用的key

## allkeys-random
从所有key中随机淘汰数据，在键空间中，随机移除某个key

## volatile-lru
从设置了过期时间的key中使用LRU算法进行淘汰，在键空间中，移除最近最少使用的key

## volatile-random
从设置了过期时间的key中随机淘汰，随机移除某个key

## volatile-ttl
在设置了过期时间的key中，根据key的过期时间进行淘汰，越早过期的越优先被淘汰

<img src="https://gitio-1253604119.cos.ap-shenzhen-fsi.myqcloud.com/20748911-43565b0005252556.webp" width="90%">


##Redis占用内存大小
````
//设置Redis最大占用内存大小为100M（修改redis.conf文件）
maxmemory 100mb

//命令行 设置Redis最大占用内存大小为100M
127.0.0.1:6379> config set maxmemory 100mb

//获取redis最大内存配置
127.0.0.1:6379> config get maxmemory
````
>如果不设置最大内存大小或者设置最大内存大小为0，在64位操作系统下不限制内存大小，在32位操作系统下最多使用3GB内存

##配置设置

````
#获取当前内存淘汰策略
127.0.0.1:6379> config get maxmemory-policy
````

````
#通过配置文件设置淘汰策略（修改redis.conf文件）：
maxmemory-policy allkeys-lru

#通过命令修改淘汰策略
127.0.0.1:6379> config set maxmemory-policy allkeys-lru
````
