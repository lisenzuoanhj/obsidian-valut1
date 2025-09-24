**string类的一个实例方法，用来获取字符串中指定位置的单个字符。** 

**参数**：`index` 从 0 开始计数。
**返回值**：对应位置上的 `char` 值。
**异常**：如果 `index < 0` 或 `>= length()`，会抛出 `StringIndexOutOfBoundsException`。

```
String s = "Hello";
char c = s.charAt(1);   // 返回 'e'
```

/*`charAt` 只读，不会修改原字符串；也不要把它当成 `int` 来直接参与数值运算，需要先减去 `'0'` 或使用 `Character.getNumericValue`。*/