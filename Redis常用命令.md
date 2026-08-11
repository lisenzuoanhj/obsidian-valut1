存储key-value结构数据的数据库。其中key是string类型，value有5种常用数据类型：**字符串 string**，**哈希 hash**，**列表 list**，**集合 set**，**有序集合 sorted set/zset** 。
![[Pasted image 20260810135223.png|333]]

- **字符串 string**：普通字符串，Redis中最简单的数据类型。
- **哈希 hash**：也叫散列，类似于Java中的HashMap结构。
- **列表 list**：按照插入顺序排序，可以有重复元素，类似于Java的 中的LinkedList。
- **集合 set**：无序集合，没有重复元素，类似于Java中的HashSet。
- **有序集合 sorted set/zset**：集合中每个元素关联一个分数（score），根据分数升序排序，没有重复元素。


## 常用命令（不区分大小写）

#### 字符串类型常用命令

1.`SET key value`                      设置指定key的值
2.`GET key`                                 获取指定key的值
3.`SETEX key seconds value`      设置指定key的值，并将key的过期时间设为seconds秒（验证码）
4.`SETNX key value`                   只有key不存在时设置key的值（分布式锁）



#### 哈希操作命令

1.`HSET key field value`      将哈希表key的字段field的值设为value  
2.`HGET key field`                获取存储在哈希表中指定字段的值
3.`HDEL key field`                删除存储在哈希表中的指定字段
4.`HKEYS key`                         获取哈希表中所有字段
5.`HVALS key`                         获取哈希表中所有值




#### 列表操作命令

1.`LPUSH key value1 [value2]`      将一个或多个值插入到列表头部
2.`LRANGE key start stop`             获取列表指定范围内的元素
3.`RPOP key`                                    移除并获取列表最后一个元素
4.`LLEN key`                                    获取列表长度



#### 集合操作命令

1.`SADkey member1 [member2]`      向集合添加一个或多个成员
2.`SMEMBERS key`                           返回集合中的所有成员
3.`SCARD key`                                获取集合的成员数
4.`SINTER key1 [key2]`                 返回给定所有集合的交集
5.`SUNION key1 [key2]`                 返回所有给定集合的并集
6.`SREM key member1 [member2]`   删除集合中一个或多个成员



#### 有序集合操作命令

1.`ZADD key score1 member1 [score2 member2]`向有序集合添加一个或多个成员
2.`ZRANGE key start stop [WITHSCORES]`           通过索引区间返回有序集合中指定区间内的成员
3.`ZINCRBY key increment member`                     有序集合中对指定成员的分数加上增量increment
4.`ZREM key member [member ...]`                     移除有序集合中的一个或多个成员



#### 通用命令（不分数据类型，都可以使用的命令）

1.`KEYS pattern`                     查找所有符合给定模式（pattern）的key
2.`EXISTS key`                         检查给定key是否存在
3.`TYPE key`                            返回key所储存的值的类型
4.`DEL key`                              该命令用于在key存在时删除key