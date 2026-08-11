
优点：1.提高访问速度；2.进行负载均衡；3.保证后端服务安全。
### 1.反向代理

```nginx
server{
	listen 80;
	server_name localhost;
	
	location /api/{
		proxy_pass  https://localhost8080/admin/; #反向代理
	}
}
```
#### e.g 
登录页面发送的请求地址为`http://localhost/api/employee/login`， 通过nginx的反向代理则去到后端的`https://localhost8080/admin/employee/login`。

### 2.负载均衡
```nginx
upstream webservers{
	server 192.168.100.128.8080
	server 192.168.100.129.8080
}

server{
	listen 80;
	server_name localhost;

	location /api/{
		proxy_pass https://webservers/admin/;#负载均衡
	}
}	
```

nginx负载均衡策略：

![[Pasted image 20260718152631.png]]

![[Pasted image 20260724151807.png]]