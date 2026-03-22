
Session 可以理解为**服务器为每个用户（浏览器）建立的 “专属身份档案”** —— 当用户第一次访问服务器时，服务器会创建一个唯一的 Session（包含用户的登录状态、操作记录等），并把这个 Session 的 “编号”（SessionID）通过 Cookie 传给浏览器；后续用户的每次请求，浏览器都会带着这个 “编号”，服务器就能通过编号找到对应的 Session，识别出 “这是哪个用户的请求”。
#### 一、核心概念

1. **本质**：服务器端的内存 / 文件 / 数据库中存储的**键值对数据**（比如 `{"user":"管理员账号", "reader":"读者ID1001"}`），每个 Session 有唯一的 `SessionID`。
2. **作用**：解决 HTTP 协议 “无状态” 的问题（HTTP 每次请求都是独立的，服务器默认不记得上一次请求的用户），实现 “登录状态保持”“用户信息存储”。
3. **类比**：就像你去酒店入住，前台给你一张房卡（SessionID），房卡上的编号对应你的房间（Session），后续你用房卡开门、消费，酒店都能通过编号找到你的房间和入住信息。

#### 二、技术细节（结合之前的过滤器代码）

##### 1. Session 的生命周期

- **创建**：用户第一次访问服务器时（或调用 `request.getSession()` 时），服务器自动生成 Session，默认存在内存中（分布式系统会存到 Redis 等中间件）。
- **传递**：服务器把 `SessionID` 封装到 Cookie（默认键名 `JSESSIONID`）中返回给浏览器，浏览器后续请求会自动携带这个 Cookie。
- **销毁**：
    - 主动销毁：调用 `session.invalidate()`（比如用户点击 “退出登录”）；
    - 被动销毁：Session 超时（默认 30 分钟无操作，可配置）；
    - 服务器关闭（内存中的 Session 会丢失，分布式场景需持久化）。

##### **2.** **代码中 Session 的关键用法**
```java
// 1. 获取 Session（false 表示：有则返回，无则返回 null，不新建） 
HttpSession session = httpRequest.getSession(false); 
// 2. 校验 Session 中的用户信息（登录后存入的属性） 
if (session == null || session.getAttribute("reader") == null) {
 // 无 Session 或无读者信息 → 未登录，重定向到登录页 
 httpResponse.sendRedirect(contextPath + "/reader-login"); } 
 // 【补充】登录成功后，往 Session 存数据（登录接口中）
  HttpSession loginSession = request.getSession(); // 无则新建 
 loginSession.setAttribute("reader", 读者对象); // 存读者信息 
 loginSession.setAttribute("user", 管理员对象); // 存管理员信息
  // 【补充】退出登录时，销毁 
 Session loginSession.invalidate();
```

##### **3. Session 与 Cookie 的区别**
|特性|Session|Cookie|
|---|---|---|
|存储位置|服务器端|客户端（浏览器）|
|存储内容|可以存对象 / 大量数据|只能存字符串，大小有限（4KB 左右）|
|安全性|高（数据不在客户端暴露）|低（可被篡改 / 窃取）|
|生命周期|服务器控制（超时 / 销毁）|可设置过期时间（永久 / 会话级）|
|核心作用|保存用户状态（登录信息）|传递 SessionID / 保存少量非敏感数据（如 “记住密码”）|
#### 三、Session 在过滤器中的核心价值

在之前的 `AuthFilter` 中，Session 是**权限校验的核心依据**：

- 读者登录后，服务器把读者信息存入 Session（`session.setAttribute("reader", ...)`）；
- 过滤器通过 `session.getAttribute("reader")` 检查是否存在该属性，判断用户是否已登录；
- 若不存在，则说明用户未登录，直接重定向到登录页，阻止访问受保护的路径（如 `/user/`）。