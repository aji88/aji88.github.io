---

title: redis 数据数据类型
date: 2019-01-19 11:33:55
categories:
- redis
tags:
- redis
---

# Redis的数据类型
redis有9大数据类型，包括
* string  字符串
* list  哈希
* hash  列表
* set   集合
* zset  有序集合
* bitmap    位集合
* hyperLog  
* Geospatial Indexes 地理空间索引
* stream    流

## string
Redis key值是二进制安全的。(二进制安全 是指,在传输数据时,保证二进制数据的信息安全,也就是不被篡改、破译等,如果被攻击,能够及时检测出来。)，可以是空值，也可以是任何二进制序列。

string是 redis 最基本的类型,最大能存储 512MB

string是二进制安全的。意思是 redis 的 string 可以包含任何数据。比如jpg图片或者序列化的对象
## hash
Redis hash 是一个 string 类型的 field 和 value 的映射表，hash 特别适合用于存储对象。
每个 hash 可以存储 2^32 -1 键值对（40多亿）

## list
Redis 列表是简单的字符串列表，按照插入顺序排序。你可以添加一个元素到列表的头部（左边）或者尾部（右边）。

列表最多可存储 2^32 - 1 元素 (4294967295, 每个列表可存储40多亿)。
## set
Redis 的 Set 是 string 类型的无序集合。

集合是通过哈希表实现的，所以添加，删除，查找的复杂度都是 O(1)。
## zset
Redis zset 和 set 一样也是string类型元素的集合,且不允许重复的成员。

不同的是每个元素都会关联一个double类型的分数。redis正是通过分数来为集合中的成员进行从小到大的排序。

zset的成员是唯一的,但分数(score)却可以重复。

## bitmap
位图不是实际的数据类型，而是在String类型上定义的一组面向位的操作。

由于字符串是二进制安全的，最大长度是512MB,转换成位可以设置 2^32不同的位。

512MB = 2^9 * 2^3（byte） * 2^10（kb） * 2^10(mb) = 2^32（bit）

位图的最大优点之一，存储信息时可以节省大量空间

[相关使用场景：点击这里](https://www.cnblogs.com/wuhaidong/articles/10389484.html)

[Redis之位图和HyperLogLog实战详解](https://blog.csdn.net/monokai/article/details/106757822?utm_medium=distribute.pc_relevant_t0.none-task-blog-BlogCommendFromBaidu-1.not_use_machine_learn_pai&depth_1-utm_source=distribute.pc_relevant_t0.none-task-blog-BlogCommendFromBaidu-1.not_use_machine_learn_pai)
## hyperLog
属于一种概率算法，(LC,LLC,HLL)三种越来越节省内存，降低误差率
## Geospatial Indexes
将制定的地理空间位置(经度、纬度、名称)添加到指定的key中。这些数据将会存储到Sorted set中。目的是为了方便GEORADIUS或者GEORADIUSBYMEMBER命令对数据进行半径查询等操作。
## stream
Stream是Redis 5.0引入的一种新数据类型,是一个新的强大的支持多播的可持久化的消息队列。




<img src="https://gitio-1253604119.cos.ap-shenzhen-fsi.myqcloud.com/redis20210108.jpg" width="90%">
