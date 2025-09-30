
## 基本语法结构

```java
for (元素类型 变量名 : 集合或数组) {
    // 循环体
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

## 两种写法的对比

| 特性        | 传统for循环         | 增强型for循环  |
| --------- | --------------- | --------- |
| **索引访问**  | 可以使用索引i         | 不能使用索引    |
| **元素访问**  | `nums[i]`       | 直接使用`num` |
| **提前返回**  | 支持              | 支持        |
| **修改元素**  | 可以直接修改`nums[i]` | 不能修改原数组   |
| **代码简洁性** | 一般              | 更简洁       |

## 使用场景分析

### 适合增强型for循环的情况：


```java
// 只读取元素值，不关心索引
int sum = 0;
for(int num : nums) {
    sum += num;
}

// 统计满足条件的元素个数
int count = 0;
for(int num : nums) {
    if(num > 0) count++;
}
```
### 不适合增强型for循环的情况：


```java
// 需要索引的情况
for(int i=0; i<nums.length; i++) {
    if(i % 2 == 0) {  // 需要知道当前位置
        // 处理逻辑
    }
}

// 需要修改原数组的情况
for(int i=0; i<nums.length; i++) {
    nums[i] = nums[i] * 2;  // 修改原数组
}

// 需要同时访问多个位置的情况
for(int i=1; i<nums.length; i++) {
    if(nums[i] == nums[i-1]) {  // 需要访问相邻元素
        // 处理逻辑
    }
}```

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

