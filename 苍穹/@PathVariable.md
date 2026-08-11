它是Spring框架里用于将**URL路径中的动态参数绑定到控制器方法入参**的注解。
作用：e.g 请求/users/1001，可提取出1001.

### 用法
```java
@GetMapping("/users/{id}")
public String getUser(@PathVariable Long id){
	//id==1001
	return "user:" + id;
}
```

