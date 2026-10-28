python中的内置变量，表示当前模块的名字（直接运行当前模块，\_\_name__的值为“\_\_main__”;当该模块被导入时，\_\_name__的值就是模块的名字）
```python
# my_fun.py
PI = 3.14159  
  
def log_deparator1():  
    print("-" * 30)  
  
  
def log_deparator2():  
    print("+" * 30)  
  
  
def log_deparator3():  
    print("*" * 30)  
  
  
def log_deparator4():  
    print("%" * 30)  
  
print(__name__)  # 在my_fun.py运行时输出的是 __main
log_deparator1()

# main.py
# 导入模块  
import my_fun  
  
# 使用模块中的功能  
print(my_fun.PI)  
my_fun.log_deparator1()  
my_fun.log_deparator2()

# 在被导入的文件里面则是输出文件名 my_fun
```

![[Pasted image 20261028203828.png]]

当想测试代码时，可以使用`if __name__ == '__main__':`来分隔测试代码和正式代码，快捷键是`main`。