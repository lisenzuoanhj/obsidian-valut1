## 1. `Integer`  vs `int` - 基本区别


### `int`（基本数据类型）
```java
int num = 10;  // 基本数据类型，直接存储值
```
- 是基本数据类型
- 直接存储数值
- 性能高，占用空间小

### `Integer`（包装类）
```java
Integer num = 10;  // 包装类，是对象
```
- 是 `int` 的包装类
- 是一个对象，包含方法和属性
- 可以用于需要对象的场景

## 2. `Integer` 的主要用途

### 用途1：在集合中使用
```java
// List<int> list = new ArrayList<>();  // ❌ 错误！集合不能存储基本类型

List<Integer> list = new ArrayList<>();  // ✅ 正确！
list.add(10);
list.add(20);
```

### 用途2：提供有用的方法
```java
Integer num = 123;

// 常用方法
String str = num.toString();        // "123"
int value = num.intValue();         // 123
int compare = num.compareTo(100);   // 比较大小

// 静态方法
int parsed = Integer.parseInt("456");     // 字符串转int
String binary = Integer.toBinaryString(5); // "101"
String hex = Integer.toHexString(255);    // "ff"
```

### 用途3：空值处理
```java
Integer num = null;  // ✅ 可以赋值为null
// int num = null;   // ❌ 编译错误，基本类型不能为null
```

## 3. 自动装箱和拆箱（Auto-boxing/Unboxing）

Java 5+ 自动转换：
```java
// 自动装箱：int → Integer
Integer a = 10;        // 相当于 Integer.valueOf(10)

// 自动拆箱：Integer → int  
int b = a;             // 相当于 a.intValue()

// 在集合中自动使用
List<Integer> list = new ArrayList<>();
list.add(1);           // 自动装箱：int → Integer
int num = list.get(0); // 自动拆箱：Integer → int
```

## 4. 常用方法和常量

### 重要的静态方法
```java
// 类型转换
int x = Integer.parseInt("123");     // 字符串转int
String s = Integer.toString(456);    // int转字符串

// 进制转换
String binary = Integer.toBinaryString(10);  // "1010"
String hex = Integer.toHexString(255);       // "ff"
String octal = Integer.toOctalString(8);     // "10"

// 比较方法
int max = Integer.max(5, 10);        // 10
int min = Integer.min(5, 10);        // 5
int sum = Integer.sum(3, 7);         // 10
```

### 有用的常量
```java
System.out.println(Integer.MAX_VALUE);  // 2147483647
System.out.println(Integer.MIN_VALUE);  // -2147483648
System.out.println(Integer.SIZE);       // 32 (位数)
System.out.println(Integer.BYTES);      // 4 (字节数)
```

## 5. 在实际项目中的应用场景

### 场景1：Web开发中的参数解析
```java
// HTTP请求参数通常是字符串，需要转换
String pageParam = request.getParameter("page");
int page = Integer.parseInt(pageParam);  // 字符串转int
```

### 场景2：数据库操作
```java
// 数据库中的NULL值处理
Integer age = resultSet.getInt("age");  // 如果是NULL，返回0
if (resultSet.wasNull()) {
    age = null;  // 可以设置为null
}
```

### 场景3：配置读取
```java
String timeoutStr = config.getProperty("timeout");
Integer timeout = timeoutStr != null ? Integer.parseInt(timeoutStr) : null;
```

### 场景4：算法和工具类
```java
public static boolean isEven(Integer number) {
    return number != null && number % 2 == 0;
}

public static Integer safeAdd(Integer a, Integer b) {
    if (a == null || b == null) return null;
    return a + b;
}
```

## 6. 注意事项

### 缓存机制
```java
Integer a = 127;
Integer b = 127;
System.out.println(a == b);  // true (在缓存范围内)

Integer c = 128;
Integer d = 128;  
System.out.println(c == d);  // false (超出缓存范围)

// 应该使用equals比较
System.out.println(c.equals(d));  // true
```

### 空指针风险
```java
Integer num = null;
// int value = num;  // ❌ 运行时NullPointerException

// 安全做法
int value = num != null ? num : 0;  // ✅
```

## 7. 性能考虑

```java
// 不好的做法：频繁创建Integer对象
for (int i = 0; i < 10000; i++) {
    list.add(new Integer(i));  // 创建多余对象
}

// 好的做法：使用valueOf（利用缓存）
for (int i = 0; i < 10000; i++) {
    list.add(Integer.valueOf(i));  // 复用缓存对象
}
```

## 总结

`Integer` 的主要作用：

1. **让基本类型可以在集合中使用**
2. **提供丰富的工具方法**（类型转换、进制转换等）
3. **支持空值**，处理可选数据
4. **面向对象编程的兼容性**
5. **数据库和Web开发中的空值处理**

虽然 `Integer` 比 `int` 占用更多内存，但在现代Java开发中，由于自动装箱拆箱和优化，大多数情况下使用 `Integer` 更加方便和安全。