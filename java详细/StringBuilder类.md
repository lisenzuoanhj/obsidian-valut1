#一个可变字符序列的类，可以高效修改，拼接字符串。

`StringBuilder s = new StringBuilder();`
#### 常用api(全部返回this，可链式)
| 动作      | 示例                        |
| ------- | ------------------------- |
| 追加      | append（any）               |
| 插入      | insert（int offset，any）    |
| 删除      | delete（int start，int end） |
| 反转      | reverse（）                 |
| 查长度     | length（）                  |
| 查容量     | capacity（）                |
| 改长度     | setLenth（newLen）          |
| 转string | toString（）                |
