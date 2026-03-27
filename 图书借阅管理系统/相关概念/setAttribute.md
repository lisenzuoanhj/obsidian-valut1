  # `setAttribute` 是**把数据从 Servlet 传给 JSP 页面用的**

相当于**在请求里放一个包裹**，Servlet 往里装东西，JSP 页面拆出来用。

---

# 1. 用法长这样

```java
request.setAttribute("名字", 数据);
```

比如你代码里：

```java
request.setAttribute("books", books);
```

意思就是：

**给这个请求里放一个叫 “books” 的数据，值是图书列表**

---

# 2. 谁用这个数据？

**JSP 页面用**，用 `${}` 拿：

```jsp
<c:forEach items="${books}" var="book">
```

这里的 `${books}` 就是你 `setAttribute` 放进去的。

---

# 3. 为什么要用它？

- Servlet 负责查数据
- JSP 负责显示页面
- 它们之间**必须靠 request 来传递数据**
- `setAttribute` 就是**传递通道**

---

# 4. 只有请求转发时才有效

因为 `setAttribute` 是放在 **request（请求对象）** 里的：

- ✅ **请求转发（forward）** → 同一个请求 → 数据能带到 JSP
- ❌ **重定向（sendRedirect）** → 新的请求 → 数据会丢失

所以你会发现：

**凡是要带数据给页面，一定用转发 + setAttribute**

---

# 5. 你项目里常见的用法

### （1）带图书列表

```java
request.setAttribute("books", bookList);
```

### （2）带错误提示
 
```java
request.setAttribute("error", "库存不足");
```

### （3）带要编辑的图书
 
```java
request.setAttribute("book", book);
```

### （4）带读者、图书下拉框数据
 
```java
request.setAttribute("readers", readers);
request.setAttribute("books", books);
```

---

# 总结

- **`setAttribute("名字", 数据)`**
- **作用：Servlet 把数据塞进请求里**
- **目的：让 JSP 页面能拿到数据显示**
- **配合：必须和 请求转发（forward）一起用**

再简单点：

**setAttribute = 塞数据到请求**

**getAttribute / ${} = 从请求里取数据** 
- `request.setAttribute`：数据只在 “一次请求” 中有效（转发后失效）；
- `session.setAttribute`：数据在 “整个会话周期” 中有效（直到用户关闭浏览器 / 登出）；
- 核心价值：后续读者访问 “我的借阅记录”“个人中心” 等页面时，后端可以通过 `session.getAttribute("reader")` 获取当前登录用户，无需重复登录。