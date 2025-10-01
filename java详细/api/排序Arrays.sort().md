`Arrays.sort(arr)` 是 Java 中 `java.util.Arrays` 类提供的一个非常常用的静态方法，用于对数组进行排序。它将数组本身作为参数传入，并在原地进行排序，也就是说，**它会直接修改原始数组，而不是返回一个新的排序后的数组**。

---

### 1. 方法签名和基本用法

**方法签名：**
```java
public static void sort(int[] arr)
```
（这里以 `int[]` 为例，实际上它对所有基本数据类型（byte, char, short, int, long, float, double）和引用类型（Object）都提供了重载方法。）

**基本示例：**
```java
import java.util.Arrays;

public class SortExample {
    public static void main(String[] args) {
        int[] arr = {5, 2, 8, 1, 9};
        
        System.out.println("排序前: " + Arrays.toString(arr)); 
        // 输出: 排序前: [5, 2, 8, 1, 9]

        Arrays.sort(arr); // 核心排序调用

        System.out.println("排序后: " + Arrays.toString(arr)); 
        // 输出: 排序后: [1, 2, 5, 8, 9]
    }
}
```

### 2. 排序规则

*   **数值类型数组（int, double等）：** 默认按**升序**（从小到大）排序。
*   **字符串数组（String[]）：** 默认按**字典序**（lexicographical order）升序排序，这类似于在字典中查词的顺序。
    ```java
    String[] words = {"banana", "apple", "cherry"};
    Arrays.sort(words);
    System.out.println(Arrays.toString(words)); 
    // 输出: [apple, banana, cherry]
    ```
*   **自定义对象数组：** 如果数组元素是自定义类的对象（例如 `Student`, `Person`），则该自定义类**必须实现 `Comparable` 接口**，并重写 `compareTo` 方法，以定义对象之间的比较规则。否则，调用 `Arrays.sort` 会抛出 `ClassCastException`。

### 3. 对自定义对象排序

有两种主要方式可以对自定义对象数组进行排序。
#### 方法一：让自定义类实现 `Comparable` 接口

这种方式定义了对象的“自然排序”规则。

```java
class Student implements Comparable<Student> {
    String name;
    int score;

    public Student(String name, int score) {
        this.name = name;
        this.score = score;
    }

    // 重写 compareTo 方法，定义按分数升序排序
    @Override
    public int compareTo(Student other) {
        // 当前对象（this）与另一个对象（other）比较
        // 返回负数：this < other
        // 返回 0：   this == other
        // 返回正数： this > other
        return this.score - other.score;
    }

    @Override
    public String toString() {
        return name + ":" + score;
    }
}

public class Test {
    public static void main(String[] args) {
        Student[] students = {
            new Student("Alice", 90),
            new Student("Bob", 85),
            new Student("Charlie", 95)
        };

        Arrays.sort(students); // 这里会使用 Student 中定义的 compareTo 规则

        System.out.println(Arrays.toString(students));
        // 输出: [Bob:85, Alice:90, Charlie:95]
    }
}
```

#### 方法二：使用 `Comparator` 比较器

这种方式更加灵活，你可以在不修改原始类的情况下，定义多种不同的排序规则。`Arrays.sort` 有一个重载方法接受一个 `Comparator` 作为第二个参数。

```java
import java.util.Arrays;
import java.util.Comparator;

class Student { // 注意：这个 Student 类没有实现 Comparable
    String name;
    int score;

    public Student(String name, int score) {
        this.name = name;
        this.score = score;
    }

    @Override
    public String toString() {
        return name + ":" + score;
    }
}

public class Test {
    public static void main(String[] args) {
        Student[] students = {
            new Student("Alice", 90),
            new Student("Bob", 85),
            new Student("Charlie", 95)
        };

        // 1. 按分数降序排序
        Arrays.sort(students, new Comparator<Student>() {
            @Override
            public int compare(Student s1, Student s2) {
                // 从大到小排序，所以用 s2 的分数减 s1 的分数
                return s2.score - s1.score;
            }
        });
        System.out.println("按分数降序: " + Arrays.toString(students));
        // 输出: 按分数降序: [Charlie:95, Alice:90, Bob:85]

        // 2. 按姓名升序排序
        Arrays.sort(students, new Comparator<Student>() {
            @Override
            public int compare(Student s1, Student s2) {
                return s1.name.compareTo(s2.name);
            }
        });
        System.out.println("按姓名升序: " + Arrays.toString(students));
        // 输出: 按姓名升序: [Alice:90, Bob:85, Charlie:95]

        // 使用 Lambda 表达式（Java 8+）让代码更简洁
        Arrays.sort(students, (s1, s2) -> s1.score - s2.score); // 分数升序
        System.out.println("使用Lambda分数升序: " + Arrays.toString(students));

        // 使用 Comparator 的辅助方法
        Arrays.sort(students, Comparator.comparingInt(s -> s.score)); // 分数升序
        Arrays.sort(students, Comparator.comparing(s -> s.name)); // 姓名升序
    }
}
```


### 4. 排序范围

`Arrays.sort` 还提供了对数组的**指定范围**进行排序的重载方法。

```java
public static void sort(int[] arr, int fromIndex, int toIndex)
```
*   `fromIndex`：排序起始索引（包含）
*   `toIndex`：排序结束索引（不包含）

**示例：**
```java
int[] arr = {5, 2, 8, 1, 9, 3, 7};
// 只排序索引 1 到 4 的元素 (即 [2, 8, 1, 9])
Arrays.sort(arr, 1, 5);
System.out.println(Arrays.toString(arr));
// 输出: [5, 1, 2, 8, 9, 3, 7]
//       索引0 |-----排序范围-----| 索引6
//              索引1到4变为 [1, 2, 8, 9]
```


### 5. 底层实现（算法）

了解底层实现有助于你理解其性能，这在面试和优化代码时很重要。

*   **对于基本数据类型数组：**
    *   使用一种经过高度优化的 **双轴快速排序** 变体。它的平均时间复杂度为 **O(n log n)**，在最坏情况下是 **O(n²)**，但通过精心选择枢轴元素，几乎可以避免最坏情况的发生。

*   **对于对象数组：**
    *   使用 **TimSort**（一种归并排序和插入排序的混合体）。
    *   TimSort 是**稳定**的排序算法，这意味着**相等元素的相对顺序在排序后会被保留**。
    *   时间复杂度为 **O(n log n)**。
    *   为什么对象和基本类型使用不同算法？因为稳定性对对象排序很重要（例如，先按姓名排，再按年龄排，希望同名者年龄顺序不变），而基本类型不存在“相等但不同”的概念，所以可以使用更快的非稳定算法。

### 总结

| 特性 | 说明 |
| :--- | :--- |
| **所属类** | `java.util.Arrays` |
| **功能** | 对数组进行原地排序 |
| **排序顺序** | 默认升序（数值、字典序） |
| **自定义对象** | 需实现 `Comparable` 或传入 `Comparator` |
| **排序范围** | 支持指定 `[fromIndex, toIndex)` 范围 |
| **算法** | 基本类型：双轴快排；对象类型：TimSort（稳定） |
| **时间复杂度** | 平均 O(n log n) |
