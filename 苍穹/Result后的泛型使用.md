`Result<T>`中的<>是Java泛型，用于指定返回结果中 `data`字段的数据类型。

## 什么时候必须写<>？
#### 返回有具体数据时，必须写
当你的接口必须要返回数据给前端时，必须在`Result`后加上`<>`，指明`data`的类型。

```java
//  返回单个分类对象
@GetMapping("/{id}")
public Result<Category> getById(@PathVariable Long id) {
    Category category = categoryService.getById(id);
    return Result.success(category);  // data 是 Category 类型
}

//  返回分类列表
@GetMapping("/list")
public Result<List<Category>> list() {
    List<Category> list = categoryService.list();
    return Result.success(list);  // data 是 List<Category> 类型
}

//  返回分页结果（自定义 PageResult）
@GetMapping("/page")
public Result<PageResult> pageQuery(CategoryPageQueryDTO queryDTO) {
    PageResult pageResult = categoryService.pageQuery(queryDTO);
    return Result.success(pageResult);  // data 是 PageResult 类型
}

//  返回 String 类型（如提示信息）
@PostMapping("/status/{status}")
public Result<String> startOrStop(@PathVariable Integer status, Long id) {
    categoryService.startOrStop(status, id);
    return Result.success("操作成功");  // data 是 String 类型
}
```


#### 没有数据返回时，可以不写
当接口只返回成功/失败状态，不返回`data`时，可以省略。

```java
//  不写泛型（最简洁）
@DeleteMapping
public Result delete(Long id) {
    categoryService.delete(id);
    return Result.success();  // 没有 data
}

//  也可以写成 Result<Object>，但没必要
@DeleteMapping
public Result<Object> delete(Long id) {
    categoryService.delete(id);
    return Result.success();  // data 是 null
}

//  失败时也可以省略
@PostMapping("/save")
public Result save(@RequestBody CategoryDTO categoryDTO) {
    if (categoryDTO.getName() == null) {
        return Result.error("分类名称不能为空");  // 没有 data
    }
    categoryService.save(categoryDTO);
    return Result.success();
}
```



```
接口要返回数据吗？
├── 是 → 必须写 <数据类型>
│   ├── 返回单个对象 → Result<Category>
│   ├── 返回列表 → Result<List<Category>>
│   ├── 返回分页 → Result<PageResult>
│   ├── 返回字符串 → Result<String>
│   └── 返回 Map → Result<Map<String, Object>>
└── 否 → 可以省略（或写 Result<Void>）
    ├── 新增成功
    ├── 修改成功
    ├── 删除成功
    └── 操作失败（返回错误信息）
```
