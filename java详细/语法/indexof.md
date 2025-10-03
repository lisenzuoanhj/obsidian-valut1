
`indexOf` 是一个用于**搜索元素在数据结构中首次出现位置**的方法，在 Java 中广泛应用于字符串和各类集合中。它返回的是元素的**索引（下标）**。

## 1. String 类的 indexOf

在字符串中，`indexOf` 用于查找**字符或子字符串**首次出现的位置。

### 方法签名：

```java
// 查找字符 ch 第一次出现的索引
int indexOf(int ch)
// 从 fromIndex 位置开始查找字符 ch
int indexOf(int ch, int fromIndex)
// 查找字符串 str 第一次出现的索引
int indexOf(String str)
// 从 fromIndex 位置开始查找字符串 str
int indexOf(String str, int fromIndex)
```

### 示例：

```java
String text = "Hello, World! Hello, Java!";

// 查找字符
System.out.println(text.indexOf('H'));        // 输出: 0
System.out.println(text.indexOf('o'));        // 输出: 4
System.out.println(text.indexOf('o', 5));     // 输出: 18 (从索引5开始找)

// 查找字符串
System.out.println(text.indexOf("Hello"));    // 输出: 0
System.out.println(text.indexOf("World"));    // 输出: 7
System.out.println(text.indexOf("Java"));     // 输出: 21
System.out.println(text.indexOf("Python"));   // 输出: -1 (未找到)

// 实际应用：检查是否包含某个子串
if (text.indexOf("Java") != -1) {
    System.out.println("文本中包含 Java");
}
```

## 2. 数组的 indexOf

**注意：** Java 原生数组**没有**直接的 `indexOf` 方法。需要自己实现或使用其他方式。

### 实现方式：

#### 方式一：手动循环查找

```java
public static int indexOf(int[] arr, int target) {
    for (int i = 0; i < arr.length; i++) {
        if (arr[i] == target) {
            return i;
        }
    }
    return -1; // 未找到
}

// 使用示例
int[] numbers = {10, 20, 30, 40, 50};
System.out.println(indexOf(numbers, 30)); // 输出: 2
System.out.println(indexOf(numbers, 60)); // 输出: -1
```

#### 方式二：使用 Arrays 类 + 循环

```java
import java.util.Arrays;

int[] numbers = {10, 20, 30, 40, 50};

// 对于已排序数组，可以用二分查找（但要求数组有序）
Arrays.sort(numbers); // 如果需要的话
int index = Arrays.binarySearch(numbers, 30);
System.out.println(index); // 输出: 2 (找到的位置)

// 对于未排序数组，还是要用循环
int target = 30;
for (int i = 0; i < numbers.length; i++) {
    if (numbers[i] == target) {
        System.out.println("找到在索引: " + i);
        break;
    }
}
```

## 3. 集合（List）的 indexOf

List 接口及其实现类（如 ArrayList, LinkedList）都提供了 `indexOf` 方法。

### 方法签名：
```java
int indexOf(Object o)
```

### 示例：

```java
import java.util.ArrayList;
import java.util.List;

List<String> list = new ArrayList<>();
list.add("Apple");
list.add("Banana");
list.add("Orange");
list.add("Apple"); // 重复元素

System.out.println(list.indexOf("Banana"));    // 输出: 1
System.out.println(list.indexOf("Apple"));     // 输出: 0 (返回第一个)
System.out.println(list.indexOf("Grape"));     // 输出: -1 (未找到)

List<Integer> numbers = Arrays.asList(5, 3, 8, 3, 1);
System.out.println(numbers.indexOf(3));        // 输出: 1 (返回第一个3)
```

## 4. 相关方法

### lastIndexOf - 查找最后一次出现的位置

```java
// String 的 lastIndexOf
String text = "Hello, World! Hello, Java!";
System.out.println(text.lastIndexOf('o'));     // 输出: 18
System.out.println(text.lastIndexOf("Hello")); // 输出: 14

// List 的 lastIndexOf
List<String> list = Arrays.asList("A", "B", "A", "C");
System.out.println(list.lastIndexOf("A"));     // 输出: 2
```

### contains - 检查是否包含（基于 indexOf）

```java
// String 的 contains
String text = "Hello World";
System.out.println(text.contains("World"));    // 输出: true

// List 的 contains
List<String> list = Arrays.asList("A", "B", "C");
System.out.println(list.contains("B"));        // 输出: true
```

## 5. 重要特性总结

| 特性 | 说明 |
|------|------|
| **返回值** | 找到返回索引（从0开始），未找到返回 **-1** |
| **搜索方向** | `indexOf` 从前往后找，`lastIndexOf` 从后往前找 |
| **找到第一个就停止** | 找到第一个匹配项后就立即返回 |
| **区分大小写** | 字符串搜索区分大小写 |
| **null 处理** | 在 List 中，`list.indexOf(null)` 会查找第一个 null 元素 |

## 6. 实际应用场景

### 场景一：检查并处理子串
```java
String email = "user@example.com";
if (email.indexOf("@") != -1) {
    System.out.println("是有效的邮箱格式");
} else {
    System.out.println("邮箱格式错误");
}
```

### 场景二：提取子串
```java
String url = "https://www.example.com/page";
int protocolEnd = url.indexOf("://");
if (protocolEnd != -1) {
    String protocol = url.substring(0, protocolEnd);
    System.out.println("协议: " + protocol); // 输出: 协议: https
}
```

### 场景三：查找所有出现位置
```java
String text = "apple, banana, apple, cherry, apple";
String target = "apple";
int index = -1;
int count = 0;

while ((index = text.indexOf(target, index + 1)) != -1) {
    System.out.println("在第 " + index + " 位置找到");
    count++;
}
System.out.println("总共找到 " + count + " 次");
```

---

## 总结

- `indexOf` 是**搜索首次出现位置**的核心方法
- **字符串**和**List集合**都有内置的 `indexOf` 方法
- **数组**需要手动实现或转换为 List 使用
- 返回值 **-1** 表示未找到，这是重要的判断条件
- 配合 `lastIndexOf` 可以完成更复杂的搜索需求
