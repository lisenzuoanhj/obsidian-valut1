**用于把新内容追加到现有数据的末尾**

1.用于`StringBuilder` / `StringBuffer`
可变字符序列，做字符串拼接时比 “+” 高效得多。
```
StringBuilder sb = new StringBuilder("Hello");
sb.append(' ');      // 追加一个字符
sb.append("world");  // 追加字符串
sb.append(123);      // 追加数字，内部会转成 "123"
System.out.println(sb); // Hello world123
```
2.`Writer` / `PrintWriter` / `BufferedWriter` …
```
Writer w = new FileWriter("log.txt", true); // true=追加模式
w.append("一行新日志\n");   // 等价于 write，但返回 Writer 本身，可链式调用
w.close();
```
/*注意：这里的 `append` 只是往“流”里写；如果构造流时没加 `true`，文件仍会被清空。*/

与 “+” 的区别：String 不可变，每次 “+” 都会产生新对象；`StringBuilder.append` 直接在原数组上扩容，性能高。