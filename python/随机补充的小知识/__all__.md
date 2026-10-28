\_\_all__是一个模块基本的特殊变量，用于指定`from 模块名 import *`时会导入哪些功能（\*通配了哪些功能 ）。类似于私有公有。

```python
# my_fun.py
__all__ = ['log_deparator1', 'log_deparator2', 'log_deparator3']  
  
PI = 3.14159  
  
def log_deparator1():  
    print("-" * 30)  
  
def log_deparator2():  
    print("+" * 30)  
  
def log_deparator3():  
    print("*" * 30)  
  
  
def log_deparator4():  
    print("%" * 30)

# main.py    
# 导入模块  
from my_fun import *  
  
# 使用模块中的功能  
log_deparator1()  
log_deparator2()  
log_deparator3()  
log_deparator4()  #爆红 
print(PI) #爆红
```