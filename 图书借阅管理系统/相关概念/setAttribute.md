   
- `request.setAttribute`：数据只在 “一次请求” 中有效（转发后失效）；
- `session.setAttribute`：数据在 “整个会话周期” 中有效（直到用户关闭浏览器 / 登出）；
- 核心价值：后续读者访问 “我的借阅记录”“个人中心” 等页面时，后端可以通过 `session.getAttribute("reader")` 获取当前登录用户，无需重复登录。