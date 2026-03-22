`getParameter` 是**从前端（页面 / 地址栏）获取用户传过来的数据，给后端 Servlet 使用的**

---

# 1. 它是干什么的？

浏览器 / 页面传给后端的数据，比如：

- 表单里输入的账号、密码、图书名称
- 地址栏上的 `?id=1` 这种参数

后端**必须用 `getParameter` 才能拿到**，否则拿不到用户传的值。

---

# 2. 用法
 
```java
String 值 = request.getParameter("参数名");
```

比如：

地址栏：
 
```plaintext
/borrow/return?id=1
```

后端获取：
 
```java
String idStr = request.getParameter("id");
int id = Integer.parseInt(idStr);  // 转成数字
```

---

# 3. 常见使用场景（你项目里全是这样）

### （1）获取表单输入

```java
String isbn = request.getParameter("isbn");
String name = request.getParameter("name");
```

对应表单：
 
```html
<input name="isbn">
<input name="name">
```

### （2）获取地址栏参数（?id=xxx）
 
```java
int id = Integer.parseInt(request.getParameter("id"));
```

### （3）获取搜索关键词
 

```java
String keyword = request.getParameter("keyword");
```

---

# 4. `setAttribute` vs `getParameter` 对比

|方法|方向|作用|
|---|---|---|
|`getParameter`|**前端 → 后端**|拿用户传过来的数据|
|`setAttribute`|**后端 → 前端**|把数据带给页面显示|

- **进：getParameter（拿数据进来）**
- **出：setAttribute（发数据出去）**

---

# 总结

- **`getParameter("name")`**
- **作用：获取前端传过来的参数**
- **谁用：Servlet 拿用户输入 / 地址栏数据**