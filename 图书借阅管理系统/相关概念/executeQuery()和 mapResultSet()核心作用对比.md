

这两个方法是 JDBC 开发中**数据查询→结果转换**的 “黄金搭档”，分工明确：

|方法名|核心作用|类比（新手友好）|
|---|---|---|
|`executeQuery()`|执行**查询类 SQL**（`SELECT`），返回数据库的原始结果集（`ResultSet`）|去仓库按清单（SQL）找货，拿回一堆未整理的货物（原始数据）|
|`mapResultSet()`|将 `ResultSet` 中的单行原始数据，映射为 Java 业务实体对象（如 `Book`/`BorrowRecord`）|把一堆未整理的货物，按规则打包成标准化的商品盒（实体对象）|

下面结合你之前的 `BookDao`/`BorrowRecordDao` 代码，详细拆解每个方法的作用、使用场景和核心逻辑：

---

## 一、`executeQuery()` 详解

### 1. 核心定义（JDBC 原生方法 + 你封装的通用方法）

#### （1）JDBC 原生 `executeQuery()`

是 `PreparedStatement`/`Statement` 接口的方法，**专门执行 `SELECT` 语句**，返回 `ResultSet`（结果集）—— 包含查询到的所有行数据，是数据库返回的 “原始数据容器”。

#### （2）你封装的通用 `executeQuery(String sql)`

在 `BookDao` 中，你把重复的查询逻辑抽成了私有通用方法，本质是对原生 `executeQuery()` 的封装：

```java
private List<Book> executeQuery(String sql) {
    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;
    List<Book> list = new ArrayList<>();
    try {
        conn = DBUtil.getConnection();
        stmt = conn.prepareStatement(sql);
        rs = stmt.executeQuery(); // 执行SQL，获取原始结果集
        while (rs.next()) {
            list.add(mapResultSet(rs)); // 调用映射方法转换为实体
        }
    } catch (SQLException e) {
        e.printStackTrace();
    } finally {
        DBUtil.close(conn, stmt, rs);
    }
    return list;
}
```

### 2. 核心作用

- **执行查询 SQL**：只处理 `SELECT` 语句（增删改用 `executeUpdate()`），比如 `findAll()`/`findAvailable()` 中查询图书列表；
- **获取原始结果**：返回 `ResultSet`，可以通过 `rs.next()` 遍历行，`rs.getInt()`/`rs.getString()` 获取列值；
- **封装通用逻辑**：你封装的版本还做了 “获取连接→执行 SQL→关闭资源” 的统一处理，避免重复代码。

### 3. 关键使用规则

- 只能执行 `SELECT` 语句，执行 `INSERT/UPDATE/DELETE` 会报错；
- 执行后必须遍历 `ResultSet` 才能拿到数据（默认指向第一行之前，需 `rs.next()` 移动游标）；
- 必须在 `finally` 中关闭 `ResultSet`，否则会导致资源泄露。

---

## 二、`mapResultSet()` 详解

### 1. 核心定义（你自定义的映射方法）

是你在 `BookDao` 中定义的私有方法，作用是**将 `ResultSet` 当前行的原始数据，转换为 Java 实体对象**：

```java
private Book mapResultSet(ResultSet rs) throws SQLException {
    Book book = new Book();
    // 逐列映射：数据库字段 → Book 对象属性
    book.setId(rs.getInt("id"));
    book.setIsbn(rs.getString("isbn"));
    book.setName(rs.getString("name"));
    // ... 其他字段映射
    book.setCategoryName(rs.getString("category_name"));
    return book;
}
```

### 2. 核心作用

- **面向对象转换**：把数据库的 “行数据”（无意义的列值集合），转换为有业务含义的 Java 实体（如 `Book`），上层代码无需直接操作 `ResultSet`；
- **简化数据处理**：比如查询到图书数据后，直接调用 `book.getName()` 就能拿到图书名称，而非 `rs.getString("name")`；
- **统一映射规则**：所有查询方法复用同一个映射逻辑，避免字段映射错误（比如把 `stock` 映射到 `categoryId`）。

### 3. 关键使用规则

- 必须在 `rs.next()` 为 `true` 时调用（否则 `ResultSet` 无数据，会报错）；
- 映射时字段类型要匹配（比如数据库 `INT` 对应 `rs.getInt()`，`VARCHAR` 对应 `rs.getString()`）；
- 可处理空值：比如 `category_name` 为 null 时，`rs.getString()` 会返回 null，实体属性也会设为 null（无需额外处理）。

---

## 三、两个方法的协同工作流程（以 `findAll()` 为例）

```
flowchart TD
    A[调用 findAll()] --> B[执行通用 executeQuery(sql)]
    B --> C[获取数据库连接]
    C --> D[执行原生 executeQuery()，返回 ResultSet]
    D --> E{rs.next() 是否有数据？}
    E -- 有 --> F[调用 mapResultSet(rs)，转换为 Book 对象]
    F --> G[添加到 List<Book>]
    G --> E
    E -- 无 --> H[关闭连接/ResultSet 等资源]
    H --> I[返回 List<Book>]
```


### 实战执行示例

假设 `book` 表有一行数据：

|id|isbn|name|author|stock|
|---|---|---|---|---|
|1|978711160|Java 编程思想|埃克尔|5|

执行流程：

1. `executeQuery()` 执行 `SELECT * FROM book`，返回包含这行数据的 `ResultSet`；
2. `rs.next()` 移动到这行数据；
3. `mapResultSet(rs)` 读取：
    
    - `rs.getInt("id")` → `book.setId(1)`
    - `rs.getString("isbn")` → `book.setIsbn("978711160")`
    - ... 最终返回一个 `Book` 对象；
    
4. 把 `Book` 对象加入 List，最终返回 `[Book(id=1, isbn=978711160, ...)]`。

---

## 四、关键区别与联系

### 区别

|维度|`executeQuery()`|`mapResultSet()`|
|---|---|---|
|归属|JDBC 原生方法（`PreparedStatement`）|你自定义的业务方法|
|输入|SQL 语句|`ResultSet`（当前行）|
|输出|`ResultSet`（原始结果集）|Java 实体对象（如 `Book`）|
|作用范围|处理 “查询→获取原始数据” 的整体流程|处理 “单行原始数据→实体对象” 的转换|
|异常|抛出 `SQLException`（需捕获）|声明抛出 `SQLException`（交给上层处理）|

### 联系

- `mapResultSet()` 依赖 `executeQuery()` 的结果（`ResultSet`），没有 `executeQuery()` 获取数据，`mapResultSet()` 无数据可转换；
- 两者配合，完成 “数据库查询→原始数据→业务实体” 的完整链路，是 DAO 层查询的标准模式。

---

## 总结

1. `executeQuery()`：核心是**执行查询 SQL 并获取原始结果集**，是连接数据库和 Java 程序的 “数据通道”；
2. `mapResultSet()`：核心是**将原始结果集转换为 Java 实体对象**，让代码从 “操作数据库字段” 升级为 “操作业务对象”；
3. 两者协同：是 JDBC 开发中 “查询类功能” 的标准实现，既保证了代码复用（通用 `executeQuery()`），又保证了面向对象编程（`mapResultSet()`）。

简单记：`executeQuery()` 是 “拿数据”，`mapResultSet()` 是 “整理数据”，前者拿回来一堆零散数据，后者把数据打包成好用的对象。