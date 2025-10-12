Java 的 `Math` 类位于 `java.lang` 包中，提供了丰富的数学运算方法。所有方法都是 `static` 的，可以直接通过类名调用。

## 1. 基本介绍

```java
// 不需要导入，java.lang包自动导入
public class MathDemo {
    public static void main(String[] args) {
        // 所有方法都是静态的，直接通过类名调用
        double result = Math.sqrt(25); // 5.0
    }
}
```

## 2. 常用数学常数

```java
public class MathConstants {
    public static void main(String[] args) {
        // 自然对数的底数 e
        System.out.println("E = " + Math.E); // 2.718281828459045
        
        // 圆周率 π
        System.out.println("PI = " + Math.PI); // 3.141592653589793
        
        // 使用示例
        double circleArea = Math.PI * Math.pow(5, 2); // 计算半径为5的圆面积
    }
}
```

## 3. 基本数学运算

### 绝对值
```java
public class BasicOperations {
    public static void main(String[] args) {
        // 绝对值
        int abs1 = Math.abs(-10);     // 10
        double abs2 = Math.abs(-3.14); // 3.14
        long abs3 = Math.abs(-100L);   // 100
        
        // 绝对值在处理差值时特别有用
        int a = 15, b = 20;
        int difference = Math.abs(a - b); // 5
    }
}
```

### 最大值和最小值
```java
public class MinMaxDemo {
    public static void main(String[] args) {
        // 最大值
        int max1 = Math.max(10, 20);        // 20
        double max2 = Math.max(3.14, 2.71); // 3.14
        
        // 最小值
        int min1 = Math.min(10, 20);        // 10
        double min2 = Math.min(3.14, 2.71); // 2.71
        
        // 多个数的比较（嵌套使用）
        int maxOfThree = Math.max(10, Math.max(20, 15)); // 20
        
        // 实际应用：限制数值范围
        int value = 150;
        int clamped = Math.min(100, Math.max(0, value)); // 限制在0-100之间
    }
}
```

## 4. 幂运算和对数

### 幂和平方根
```java
public class PowerAndRoot {
    public static void main(String[] args) {
        // 平方根
        double sqrt = Math.sqrt(25); // 5.0
        double sqrt2 = Math.sqrt(2); // 1.4142135623730951
        
        // 立方根
        double cbrt = Math.cbrt(27); // 3.0
        
        // 幂运算
        double power = Math.pow(2, 3);  // 8.0 (2的3次方)
        double power2 = Math.pow(10, 2); // 100.0
        
        // 欧几里得距离计算
        double distance = Math.sqrt(Math.pow(3, 2) + Math.pow(4, 2)); // 5.0
    }
}
```

### 对数和指数
```java
public class LogarithmDemo {
    public static void main(String[] args) {
        // 自然对数 (以e为底)
        double ln = Math.log(Math.E); // 1.0
        
        // 以10为底的对数
        double log10 = Math.log10(100); // 2.0
        
        // 指数函数
        double exp = Math.exp(1); // 2.718281828459045 (e^1)
        double exp2 = Math.exp(2); // 7.38905609893065 (e^2)
        
        // 应用：计算复利
        double principal = 1000;
        double rate = 0.05;
        double time = 10;
        double amount = principal * Math.exp(rate * time);
    }
}
```

## 5. 三角函数

```java
public class TrigonometricDemo {
    public static void main(String[] args) {
        double angle = 45.0;
        double radians = Math.toRadians(angle); // 角度转弧度
        
        // 基本三角函数
        double sin = Math.sin(radians);   // 正弦
        double cos = Math.cos(radians);   // 余弦
        double tan = Math.tan(radians);   // 正切
        
        // 反三角函数
        double asin = Math.asin(sin);     // 反正弦
        double acos = Math.acos(cos);     // 反余弦
        double atan = Math.atan(tan);     // 反正切
        
        // 弧度角度转换
        double degrees = Math.toDegrees(radians); // 弧度转角度
        
        System.out.println("45度的正弦值: " + sin); // 约0.7071
        System.out.println("转换回角度: " + degrees); // 45.0
    }
}
```

## 6. 舍入运算

### 四舍五入
```java
public class RoundingDemo {
    public static void main(String[] args) {
        double num1 = 3.4;
        double num2 = 3.6;
        double num3 = -2.5;
        
        // 四舍五入
        long round1 = Math.round(num1); // 3
        long round2 = Math.round(num2); // 4
        long round3 = Math.round(num3); // -2
        
        // 向上取整
        double ceil1 = Math.ceil(3.1);  // 4.0
        double ceil2 = Math.ceil(-3.1); // -3.0
        
        // 向下取整
        double floor1 = Math.floor(3.9);  // 3.0
        double floor2 = Math.floor(-3.9); // -4.0
        
        // 应用：分页计算
        int totalItems = 25;
        int itemsPerPage = 10;
        int totalPages = (int) Math.ceil((double) totalItems / itemsPerPage); // 3
    }
}
```

## 7. 随机数生成

```java
public class RandomDemo {
    public static void main(String[] args) {
        // 生成0.0到1.0之间的随机小数
        double random1 = Math.random(); 
        
        // 生成指定范围的随机整数
        int min = 1, max = 100;
        int randomInt = (int) (Math.random() * (max - min + 1)) + min;
        
        // 生成多个随机数
        System.out.println("5个随机数:");
        for (int i = 0; i < 5; i++) {
            System.out.println((int) (Math.random() * 100));
        }
        
        // 应用：随机选择
        String[] colors = {"红", "绿", "蓝", "黄"};
        String randomColor = colors[(int) (Math.random() * colors.length)];
        System.out.println("随机颜色: " + randomColor);
    }
}
```

## 8. 符号和差值运算

```java
public class SignAndDifference {
    public static void main(String[] args) {
        // 符号函数
        int sign1 = Math.signum(10.5);   // 1 (正数)
        int sign2 = Math.signum(-5.2);   // -1 (负数)
        int sign3 = Math.signum(0.0);    // 0 (零)
        
        // 差值运算
        int diff1 = Math.subtractExact(10, 3);   // 7
        long diff2 = Math.subtractExact(100L, 50L); // 50
        
        // 安全运算（避免溢出）
        try {
            int overflow = Math.addExact(Integer.MAX_VALUE, 1); // 抛出ArithmeticException
        } catch (ArithmeticException e) {
            System.out.println("整数溢出!");
        }
    }
}
```

## 9. 实际应用案例

### 案例1：几何计算
```java
public class GeometryCalculator {
    // 计算两点之间的距离
    public static double distance(double x1, double y1, double x2, double y2) {
        return Math.sqrt(Math.pow(x2 - x1, 2) + Math.pow(y2 - y1, 2));
    }
    
    // 计算圆的面积
    public static double circleArea(double radius) {
        return Math.PI * Math.pow(radius, 2);
    }
    
    // 计算球体体积
    public static double sphereVolume(double radius) {
        return (4.0 / 3.0) * Math.PI * Math.pow(radius, 3);
    }
}
```

### 案例2：金融计算
```java
public class FinancialCalculator {
    // 计算复利
    public static double compoundInterest(double principal, double rate, int years) {
        return principal * Math.pow(1 + rate, years);
    }
    
    // 计算月供
    public static double monthlyPayment(double loanAmount, double annualRate, int years) {
        double monthlyRate = annualRate / 12 / 100;
        int numberOfPayments = years * 12;
        return loanAmount * monthlyRate * Math.pow(1 + monthlyRate, numberOfPayments) 
               / (Math.pow(1 + monthlyRate, numberOfPayments) - 1);
    }
}
```

### 案例3：游戏开发
```java
public class GameUtils {
    // 计算两点之间的角度（用于瞄准系统）
    public static double calculateAngle(double x1, double y1, double x2, double y2) {
        double deltaX = x2 - x1;
        double deltaY = y2 - y1;
        return Math.toDegrees(Math.atan2(deltaY, deltaX));
    }
    
    // 生成随机敌人属性
    public static int generateEnemyHealth(int min, int max) {
        return (int) (Math.random() * (max - min + 1)) + min;
    }
    
    // 计算伤害（带随机波动）
    public static int calculateDamage(int baseDamage, double variance) {
        double randomFactor = 1 + (Math.random() - 0.5) * variance;
        return (int) (baseDamage * randomFactor);
    }
}
```

## 10. 注意事项

1. **精度问题**：浮点数运算可能存在精度损失
2. **异常处理**：某些方法可能抛出 `ArithmeticException`
3. **性能考虑**：三角函数等复杂运算比较耗时
4. **数值范围**：注意整数溢出问题

```java
public class MathPrecautions {
    public static void main(String[] args) {
        // 精度问题示例
        System.out.println(0.1 + 0.2); // 0.30000000000000004
        
        // 使用BigDecimal进行精确计算
        java.math.BigDecimal bd1 = new java.math.BigDecimal("0.1");
        java.math.BigDecimal bd2 = new java.math.BigDecimal("0.2");
        System.out.println(bd1.add(bd2)); // 0.3
    }
}
```

