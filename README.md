# 电商平台系统

前后端分离的在线购物平台，支持商品浏览、购物车、用户登录鉴权、商品管理、评论等功能。

---

## 项目结构

```
sql-
├── edu-vue3/          # 前端 (Vue 3 + Element Plus + Pinia)
├── springboot/        # 后端 (Spring Boot 3 + MyBatis-Plus + JWT)
├── sql/               # 数据库脚本
├── files/             # 图片存储
└── logs/              # 日志
```

---

## 技术栈

| 层级 | 技术 |
|------|------|
| 前端框架 | Vue 3 (Composition API) |
| UI 组件库 | Element Plus |
| 状态管理 | Pinia |
| 路由 | Vue Router 4 |
| 构建工具 | Vite |
| CSS 方案 | WindiCSS + Scoped CSS |
| 后端框架 | Spring Boot 3 |
| ORM | MyBatis-Plus 3.x |
| 鉴权 | JWT (auth0-java-jwt) |
| 数据库 | MySQL 8.0 |
| HTTP 工具 | fetch (原生封装) |

---

## 数据库（8 张核心表）

| 表名 | 说明 |
|------|------|
| `userlogin` | 用户登录表（id/username/password/role） |
| `usermessage` | 用户信息表（姓名/电话/邮箱/地址/余额/头像） |
| `goods` | 商品表（编码/厂家/分类/描述/单价） |
| `manufacturer` | 厂家表（编码/名称/电话） |
| `goods_category` | 商品分类表 |
| `goods_image` | 商品图片表 |
| `goods_review` | 商品评论表 |
| `cart` | 购物车表 |

初始化：Navicat 运行 `sql/demo.sql`，含全部建表语句和示例数据。

### 用户身份（userlogin.role）

| role | 身份 | 权限 |
|------|------|------|
| 0 | 管理员 | 全部功能：商品管理、用户管理、评论管理 |
| 2 | 普通用户 | 浏览商品、购物车、个人资料、评论 |

默认账号：`admin` / `123`（管理员），`tom` / `123`（用户）

---

## 启动方式

### 后端

1. 用 IDEA 打开 `springboot/`
2. 确保 `application.yml` 中数据库连接正确（默认 `demo` 库）
3. 运行 `SpringbootApplication.java`
4. 端口：`9999`

### 前端

```bash
cd edu-vue3
npm install
npm run dev
```

前端端口默认为 Vite 自动分配（通常 `5173`）。

---

## 后端分层

```
springboot/src/main/java/com/example/springboot/
├── common/          # 配置类（CORS、拦截器、MyBatis-Plus、统一返回）
├── controller/      # 接口层
│   ├── WebController       # 登录/注册
│   ├── UserController      # 用户 CRUD
│   ├── GoodsController     # 商品 CRUD + 分类/厂家 + 图片
│   ├── FileController      # 文件上传/下载
│   └── DataController      # 评论/购物车/用户信息
├── entity/          # 实体类（与数据库表对应）
├── mapper/          # 持久层（MyBatis-Plus BaseMapper）
├── service/         # 业务逻辑层
│   └── impl/
├── exception/       # 全局异常处理
└── utils/           # TokenUtils (JWT 生成/解析)
```

### 统一响应格式

```json
{
  "code": "200",
  "msg": "请求成功",
  "data": { ... }
}
```

### JWT 鉴权流程

```
登录 → 后端校验 → 生成 Token（含 userId）→ 返回前端
前端存储 localStorage.token
后续请求 → request.js 自动带 token header
后端 JwtInterceptor 拦截 → 验证 Token → 放行/拒绝
```

无需认证路径：`/login` `/register` `/goods/**` `/file/**` `/usermessage/**` `/cart/**` `/review/**`

---

## 前端页面

### 独立页面（无侧边栏）

| 路由 | 页面 | 说明 |
|------|------|------|
| `/` | UserShopping | 商品首页（搜索/分类/卡片/分页） |
| `/login` | UserLogin | 登录/注册 |
| `/product/:code` | ProductDetail | 商品详情（图片/评论/厂家/加购） |

### 侧边栏布局（`/home/*`）

| 路由 | 页面 | 说明 |
|------|------|------|
| `/home` | UserShopping | 首页（侧边栏内） |
| `/home/goods/list` | GoodsList | 商品管理（管理员增删改） |
| `/home/user/list` | UserList | 用户管理（管理员改角色） |
| `/home/review/list` | ReviewList | 评论管理 |
| `/home/profile` | Profile | 个人资料（头像/信息/密码） |
| `/home/cart` | Cart | 购物车（全选/支付/扣余额） |

### 核心组件

| 文件 | 说明 |
|------|------|
| `AsideMenu.vue` | 侧边栏导航 + 头像下拉 + 余额充值 |
| `HomeIndex.vue` | 侧边栏布局容器 |
| `stores/user.js` | Pinia 用户状态（userId/token/role/balance） |
| `utils/request.js` | fetch 请求封装（自动带 token/401 处理） |

---

## 功能清单

### 商品浏览
- 响应式卡片网格（auto-fill）
- 关键词搜索 + 分类筛选
- 分页（每页 10 个）
- 点击图片进入详情页

### 商品详情
- 商品大图 + 厂家信息
- 商品评论列表（用户名/评分/时间）
- 登录用户可发表评论
- 加入购物车

### 购物车
- 全选/多选
- 合计金额
- 余额支付（扣款 + 清购物车）
- 余额不足提示

### 商品管理（管理员）
- 新增商品（编码自动生成）
- 编辑/删除
- 厂家下拉选择 + 新增厂家
- 分类下拉选择 + 新增分类
- 图片上传

### 用户中心
- 个人资料查看/编辑（含头像上传）
- 修改密码
- 余额充值（微信/支付宝/银行卡）

### 用户管理（管理员）
- 用户列表
- 修改用户角色（管理员 ↔ 普通用户）

---

## 文件上传

上传接口：`POST /file/upload`，文件存储在 `springboot/files/`。

访问：`GET /file/download/{fileName}`

图片上传后返回完整 URL，存入 `goods_image` 表。

---

## 常见问题

**商品图片不显示**：确保 `goods_image` 表存在（运行 `sql/demo.sql`），并运行 `sql/create_images.sql`。

**登录失败**：确保 `userlogin` 表存在且有数据。默认账号 `admin/123`。

**端口修改**：后端改 `application.yml` 的 `server.port`；前端改 `request.js` 的 `BASE_URL`。
