EL（Expression Language）表达式是 **JSP 中用于简化数据读取的语法**，核心作用是：**不用写 Java 代码，就能快速获取存放在 `request`、`session`、`application` 等域中的数据**，让 JSP 页面更简洁、易维护。

你可以把它理解为：JSP 页面的 “数据读取快捷键”—— 原本需要写 `<%= request.getAttribute("error") %>` 才能获取的错误提示，用 EL 只需要 `${error}` 就能实现。

---

### 一、EL 表达式的核心语法

#### 1. 基础格式
```jsp
${表达式内容}
```
- `${}` 是 EL 表达式的固定标识；
- 表达式内容可以是：域变量名、对象属性、集合元素、算术 / 逻辑运算等。

#### 2. 最常用场景（结合之前的登录代码）

我们以登录失败时的错误提示为例，完整展示 EL 的使用：

##### 步骤 1：Servlet 中存入数据到请求域
```jsp
<!-- login.jsp 页面 --> 
<!DOCTYPE html> 
<html>
<head>
	<meta charset="UTF-8">
	<title>管理员登录</title>
</head>
<body>
	<h1>管理员登录</h1> 
	<!-- 用 EL 读取 error 变量，若不存在则显示空（不会报错） --> 
	<div style="color: red;">${error}</div> 
	
	<form method="post" action="${pageContext.request.contextPath}/login"> 
		用户名：<input type="text" name="username"><br> 
		密码：<input type="password" name="password"><br> 
		<button type="submit">登录</button> 
	</form> 
</body> 
</html>
```
- `${error}`：等价于 `<%= request.getAttribute("error") %>`，自动从各个域中查找名为 `error` 的变量；
- `${pageContext.request.contextPath}`：获取项目上下文路径（避免硬编码），等价于 Java 代码 `request.getContextPath()`。

---

### 二、EL 表达式的核心能力

#### 1. 读取不同域中的数据（优先级：page → request → session → application）

|域对象|对应 Java 代码|EL 表达式简写|EL 表达式全称（指定域）|
|---|---|---|---|
|Page 域|pageContext.getAttribute("key")|`${key}`|`${pageScope.key}`|
|Request 域|request.getAttribute("key")|`${key}`|`${requestScope.key}`|
|Session 域|session.getAttribute("key")|`${key}`|`${sessionScope.key}`|
|Application 域|application.getAttribute("key")|`${key}`|`${applicationScope.key}`|
**示例**：读取 Session 中的管理员信息（登录成功后存入的 `user` 对象）
```jsp
<!-- main.jsp 页面 --> 
<h3>欢迎您：${sessionScope.user.username}</h3> 
<!-- 简写：${user.username}（EL 会自动遍历域，找到第一个名为 user 的变量） -->
```
`${user.username}`：等价于 `((User)session.getAttribute("user")).getUsername()`，EL 会自动调用对象的 `getter` 方法（无需写 `get`）。
#### 2. 算术 / 逻辑运算
```jsp
<!-- 算术运算 --> 
${10 + 20} <!-- 输出 30 --> 
${user.age + 1} <!-- 管理员年龄+1 --> 

<!-- 逻辑运算 --> 
${user.role == "admin" && user.status == "active"} <!-- 管理员且状态激活 --> 
${empty error} <!-- 判断 error 是否为空（空字符串/Null/空集合都返回 true） -->
```
#### 3. 读取集合数据
```jsp
<!-- 读取列表（假设 Servlet 中存入了 List<Book> books 到 request 域） --> 
<c:forEach items="${books}" var="book"> 
	<li>书名：${book.name}，作者：${book.author}</li> 
</c:forEach> 

<!-- 读取 Map（假设存入了 Map<String, String> map 到 request 域） --> 
${map["key1"]} <!-- 或 ${map.key1} -->
```

### 三、EL 表达式的优势（对比传统 JSP 脚本）
|传统 JSP 脚本|EL 表达式|
|---|---|
|`<%= request.getAttribute("error") %>`|`${error}`|
|`<%= ((User)session.getAttribute("user")).getUsername() %>`|`${user.username}`|
|代码繁琐、可读性差|简洁、易读、少出错|
|需要处理 Null（否则报空指针）|自动处理 Null（返回空字符串）|
### 四、关键注意事项

1. **EL 表达式默认启用**：JSP 2.0+ 版本默认支持 EL，若要关闭，需在 JSP 页面顶部加：
    ```jsp
    <%@ page isELIgnored="true" %>
    ```
    
2. **处理 Null 安全**：如果变量不存在或为 Null，EL 不会报错，只会显示空字符串（比如 `${xxx}` 若 xxx 不存在，页面上无任何显示）；
3. **与 JSTL 配合使用**：EL 常和 JSTL（JSP 标准标签库）结合，比如 `<c:forEach>` 遍历集合、`<c:if>` 条件判断，让 JSP 完全摆脱 Java 脚本。

---

### 总结

1. EL 表达式是 JSP 的 “数据读取快捷键”，核心语法 `${}`，用于简化域数据的读取；
2. 核心能力：读取域对象 / 对象属性 / 集合、做运算，自动调用 `getter` 方法，Null 安全；
3. 实战场景：登录页回显错误提示（`${error}`）、主页面显示用户信息（`${user.username}`）、遍历数据列表等，是 JSP 开发中必备的基础语法