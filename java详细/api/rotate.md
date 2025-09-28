可以把元素按特定方向旋转。
## 1. 数组旋转 (Array Rotation)

将数组元素向左或向右循环移动：

### 左旋转 (Left Rotation)

```java
// 原始数组: [1, 2, 3, 4, 5]
// 左旋转2位: [3, 4, 5, 1, 2]
public class ArrayRotation {
    // 方法1: 使用额外空间
    public static int[] rotateLeft(int[] arr, int k) {
        int n = arr.length;
        k = k % n; // 处理k大于数组长度的情况
        int[] result = new int[n];
        
        for (int i = 0; i < n; i++) {
            result[i] = arr[(i + k) % n];
        }
        return result;
    }
    
    // 方法2: 原地旋转（三次反转法）
    public static void rotateLeftInPlace(int[] arr, int k) {
        int n = arr.length;
        k = k % n;
        
        // 三步反转法
        reverse(arr, 0, k - 1);    // 反转前k个元素
        reverse(arr, k, n - 1);    // 反转剩余元素
        reverse(arr, 0, n - 1);    // 反转整个数组
    }
    
    private static void reverse(int[] arr, int start, int end) {
        while (start < end) {
            int temp = arr[start];
            arr[start] = arr[end];
            arr[end] = temp;
            start++;
            end--;
        }
    }
}
```

### 右旋转 (Right Rotation)

```


// 原始数组: [1, 2, 3, 4, 5]
// 右旋转2位: [4, 5, 1, 2, 3]

public class RightRotation {
    public static int[] rotateRight(int[] arr, int k) {
        int n = arr.length;
        k = k % n;
        int[] result = new int[n];
        
        for (int i = 0; i < n; i++) {
            result[(i + k) % n] = arr[i];
        }
        return result;
    }
    
    public static void rotateRightInPlace(int[] arr, int k) {
        int n = arr.length;
        k = k % n;
        
        reverse(arr, 0, n - 1);    // 反转整个数组
        reverse(arr, 0, k - 1);    // 反转前k个元素
        reverse(arr, k, n - 1);    // 反转剩余元素
    }
}
```
## 2. 字符串旋转 (String Rotation)

检查一个字符串是否是另一个字符串的旋转：


```java

public class StringRotation {
    // 检查s2是否是s1的旋转
    public static boolean isRotation(String s1, String s2) {
        if (s1.length() != s2.length()) return false;
        
        // 技巧: s1+s1包含所有可能的旋转
        String doubled = s1 + s1;
        return doubled.contains(s2);
    }
    
    public static void main(String[] args) {
        String s1 = "waterbottle";
        String s2 = "erbottlewat";
        
        System.out.println(isRotation(s1, s2)); // 输出: true
        
        // 示例:
        // "waterbottle" 旋转后可以是:
        // "waterbottle" (旋转0位)
        // "aterbottlew" (旋转1位)
        // "terbottlewa" (旋转2位)
        // "erbottlewat" (旋转3位) ← 这就是我们要检查的
    }
}
```
## 3. 矩阵旋转 (Matrix Rotation)

通常指90度旋转图像或矩阵：


```java

public class MatrixRotation {
    // 顺时针旋转90度
    public static void rotate90Clockwise(int[][] matrix) {
        int n = matrix.length;
        
        // 转置矩阵
        for (int i = 0; i < n; i++) {
            for (int j = i; j < n; j++) {
                int temp = matrix[i][j];
                matrix[i][j] = matrix[j][i];
                matrix[j][i] = temp;
            }
        }
        
        // 反转每一行
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n / 2; j++) {
                int temp = matrix[i][j];
                matrix[i][j] = matrix[i][n - 1 - j];
                matrix[i][n - 1 - j] = temp;
            }
        }
    }
    
    // 打印矩阵
    public static void printMatrix(int[][] matrix) {
        for (int[] row : matrix) {
            for (int val : row) {
                System.out.print(val + " ");
            }
            System.out.println();
        }
    }
    
    public static void main(String[] args) {
        int[][] matrix = {
            {1, 2, 3},
            {4, 5, 6},
            {7, 8, 9}
        };
        
        System.out.println("原始矩阵:");
        printMatrix(matrix);
        
        rotate90Clockwise(matrix);
        
        System.out.println("旋转90度后:");
        printMatrix(matrix);
        // 输出:
        // 7 4 1
        // 8 5 2
        // 9 6 3
    }
}
```
## 4. 链表旋转 (Linked List Rotation)


```java

class ListNode {
    int val;
    ListNode next;
    ListNode(int x) { val = x; }
}

public class LinkedListRotation {
    // 旋转链表k个位置
    public static ListNode rotateRight(ListNode head, int k) {
        if (head == null || head.next == null || k == 0) return head;
        
        // 计算链表长度并找到尾节点
        int length = 1;
        ListNode tail = head;
        while (tail.next != null) {
            tail = tail.next;
            length++;
        }
        
        k = k % length;
        if (k == 0) return head;
        
        // 找到新的尾节点（第length-k个节点）
        ListNode newTail = head;
        for (int i = 1; i < length - k; i++) {
            newTail = newTail.next;
        }
        
        // 执行旋转
        ListNode newHead = newTail.next;
        newTail.next = null;
        tail.next = head;
        
        return newHead;
    }
}
```
## 5. 二叉树旋转 (Tree Rotation)

在平衡二叉树（如AVL树、红黑树）中用于保持平衡：


```java

class TreeNode {
    int val;
    TreeNode left, right;
    TreeNode(int x) { val = x; }
}

public class TreeRotation {
    // 右旋转（LL情况）
    public static TreeNode rightRotate(TreeNode y) {
        TreeNode x = y.left;
        TreeNode T2 = x.right;
        
        // 执行旋转
        x.right = y;
        y.left = T2;
        
        return x;
    }
    
    // 左旋转（RR情况）
    public static TreeNode leftRotate(TreeNode x) {
        TreeNode y = x.right;
        TreeNode T2 = y.left;
        
        // 执行旋转
        y.left = x;
        x.right = T2;
        
        return y;
    }
}
```
## 6. 实际应用场景


```java

public class RotationApplications {
    public static void main(String[] args) {
        // 应用1: 轮转调度算法
        int[] processes = {1, 2, 3, 4, 5};
        System.out.println("原始进程队列: " + Arrays.toString(processes));
        
        // 模拟时间片轮转（左旋转1位）
        rotateLeftInPlace(processes, 1);
        System.out.println("一次轮转后: " + Arrays.toString(processes));
        
        // 应用2: 密码学中的凯撒密码（字符旋转）
        String message = "HELLO";
        String encrypted = caesarCipher(message, 3);
        System.out.println("加密: " + encrypted);
        System.out.println("解密: " + caesarCipher(encrypted, -3));
        
        // 应用3: 图像处理
        int[][] image = {{1,2,3}, {4,5,6}, {7,8,9}};
        rotate90Clockwise(image);
        System.out.println("旋转后的图像矩阵:");
        printMatrix(image);
    }
    
    // 凯撒密码（字符旋转）
    public static String caesarCipher(String text, int shift) {
        StringBuilder result = new StringBuilder();
        for (char c : text.toCharArray()) {
            if (Character.isLetter(c)) {
                char base = Character.isLowerCase(c) ? 'a' : 'A';
                c = (char)(((c - base + shift) % 26 + 26) % 26 + base);
            }
            result.append(c);
        }
        return result.toString();
    }
}
```

## 总结

**Rotate（旋转）** 的核心特点是：

- **循环移动**: 元素从一端移出，从另一端进入
    
- **保持顺序**: 相对顺序通常保持不变
    
- **多种实现**: 可以使用额外空间或原地算法
    
- **广泛应用**: 在算法、数据结构、系统调度、密码学等领域都有重要应用
    

最常见的旋转问题是**数组旋转**，面试中经常出现，需要掌握高效的原地旋转算法。