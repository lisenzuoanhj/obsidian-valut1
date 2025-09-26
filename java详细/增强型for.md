
## 基本语法结构

```java
for (元素类型 变量名 : 集合或数组) {
    // 循环体
}
```



### 第一个循环：
```java
for (char c: s.toCharArray()) {
    counter[c - 'a']++;
}
```

**分解说明：**
- `char c`：定义循环变量，类型为 `char`，变量名为 `c`
- `s.toCharArray()`：返回一个 `char[]` 数组
- **执行过程**：依次将数组中的每个字符赋值给变量 `c`，然后执行循环体

### 等价于普通 for 循环：
```java
char[] charArray = s.toCharArray();
for (int i = 0; i < charArray.length; i++) {
    char c = charArray[i];  // 自动赋值
    counter[c - 'a']++;
}
```

## 增强型 for 循环的特点

### 优点：
1. **语法简洁**：不需要索引变量
2. **避免越界**：不会出现数组下标越界错误
3. **可读性好**：直接表达"遍历每个元素"的意图

### 限制：
1. **只能顺序访问**：不能反向遍历或跳着访问
2. **不能修改集合**：遍历过程中不能添加/删除元素
3. **无法获取索引**：如果需要索引信息，要用普通 for 循环

## 更多示例

### 遍历整数数组：
```java
int[] numbers = {1, 2, 3, 4, 5};
for (int num : numbers) {
    System.out.println(num);  // 依次输出 1,2,3,4,5
}
```

### 遍历字符串（直接）：
```java
String str = "hello";
for (char ch : str.toCharArray()) {
    System.out.println(ch);  // 依次输出 h,e,l,l,o
}
```

### 遍历 List 集合：
```java
List<String> list = Arrays.asList("a", "b", "c");
for (String item : list) {
    System.out.println(item);  // 依次输出 a,b,c
}
```

## 与传统 for 循环对比

### 增强型 for 循环：
```java
for (char c : s.toCharArray()) {
    // 处理每个字符 c
}
```

### 传统 for 循环：
```java
for (int i = 0; i < s.length(); i++) {
    char c = s.charAt(i);  // 需要手动获取字符
    // 处理每个字符 c
}
```


**总结**：`for (char c: s.toCharArray())` 就是"依次取出字符串 s 中的每个字符，暂时命名为 c，然后执行循环体内的操作"。