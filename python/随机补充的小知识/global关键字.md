- 用于明确告诉Python解释器，在函数中要使用全局变量，使得可以在函数内部修改全局变量的值。
```python
num1= 1
def fun1():
    num1 = 100
    print(num1)

fun1()  # 100
print(num1) # 1

num1= 1
def fun1():
    global num1
    num1 = 100 #修改全局变量num1
    print(num1)

fun1() # 100
print(num1) # 100

```

> [!NOTE] 说明
> 基于global声明全局变量时，要先声明，再使用。

