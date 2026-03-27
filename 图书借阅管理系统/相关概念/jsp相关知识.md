
1.
```jsp
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
```
网页是test/html,编码固定为UTF-8,语言是Java.

2.
```jsp
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
```
原有的Java代码写作`<% %>`,这行代码可以简化为`<c:>`.

3.html的基本结构
```html
<html>
 <head>
  <title>网页标题</title>
 </head>
 <body>
   网页里真正显示的内容都在这
 </body>
</html>
```

4.标题
```html
<h1>最大标题</h1> 
<h2>二级标题</h2>
```

5.段落 
```html
<p>这是一段文字</p>
```

6.换行 br
```html
第一行<br>
第二行
```

7.链接 
```html
<a href="https://www.baidu.com">点我去百度</a>
```

8.图片 
```html
<img src="图片地址.jpg">
```

9.表单 : 用来**输入账号密码、提交数据**
```html
<form action="提交到哪里.jsp" method="post">
  用户名：<input type="text" name="username">
  密码：<input type="password" name="pwd">
  <button type="submit">登录</button>
</form>
```

10.表格 table
```html
<table>
  <tr>
    <td>第一行第一列</td>
    <td>第一行第二列</td>
  </tr>
  <tr>
    <td>第二行第一列</td>
    <td>第二行第二列</td>
  </tr>
</table>
```

11.列表 ul/ol
```html
<ul>
  <li>列表项1</li>
  <li>列表项2</li>
</ul>
```



标签里可以加额外信息，叫**属性**。
```html
<input name="username" value="张三">
```

- `name`：名字，JSP 用 `request.getParameter("username")` 取数据
- `value`：默认值