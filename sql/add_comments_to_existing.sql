-- ============================================================
-- demo 库已有表添加字段注释
-- 在 Navicat 中选中 demo 库运行
-- ============================================================

-- ============================================================
-- 1. goods 商品表
-- ============================================================
ALTER TABLE `goods`
  MODIFY COLUMN `goods_code` varchar(20) NOT NULL COMMENT '商品编码',
  MODIFY COLUMN `manu_code` varchar(20) NOT NULL COMMENT '厂家编码',
  MODIFY COLUMN `goods_desc` varchar(200) DEFAULT NULL COMMENT '商品描述',
  MODIFY COLUMN `unit_price` decimal(10,2) NOT NULL COMMENT '单价';

-- ============================================================
-- 2. manufacturer 厂家表
-- ============================================================
ALTER TABLE `manufacturer`
  MODIFY COLUMN `manu_code` varchar(20) NOT NULL COMMENT '厂家编码',
  MODIFY COLUMN `manu_name` varchar(50) NOT NULL COMMENT '厂家名称',
  MODIFY COLUMN `manu_phone` varchar(20) NOT NULL COMMENT '厂家电话';

-- ============================================================
-- 3. customer 顾客表
-- ============================================================
ALTER TABLE `customer`
  MODIFY COLUMN `cust_code` varchar(20) NOT NULL COMMENT '顾客编码',
  MODIFY COLUMN `cust_name` varchar(50) NOT NULL COMMENT '顾客名称',
  MODIFY COLUMN `address` varchar(100) NOT NULL COMMENT '地址',
  MODIFY COLUMN `postcode` varchar(10) DEFAULT NULL COMMENT '邮编',
  MODIFY COLUMN `phone` varchar(20) NOT NULL COMMENT '联系电话',
  MODIFY COLUMN `e-mail` varchar(30) NOT NULL COMMENT '顾客邮箱',
  MODIFY COLUMN `cust_password` varchar(50) NOT NULL COMMENT '顾客密码',
  MODIFY COLUMN `cust_balance` int NOT NULL COMMENT '顾客余额';

-- ============================================================
-- 4. cart 购物车表
-- ============================================================
ALTER TABLE `cart`
  MODIFY COLUMN `cart_code` varchar(20) NOT NULL COMMENT '购物车编码',
  MODIFY COLUMN `cust_code` varchar(20) NOT NULL COMMENT '顾客编码',
  MODIFY COLUMN `goods_code` varchar(20) NOT NULL COMMENT '商品编码',
  MODIFY COLUMN `quantity` int NOT NULL COMMENT '数量',
  MODIFY COLUMN `unit_price` decimal(10,2) NOT NULL COMMENT '单价',
  MODIFY COLUMN `total_price` decimal(10,2) DEFAULT NULL COMMENT '小计',
  MODIFY COLUMN `add_time` datetime NOT NULL COMMENT '添加时间';

-- ============================================================
-- 5. goods_review 商品评论表
-- ============================================================
ALTER TABLE `goods_review`
  MODIFY COLUMN `review_code` varchar(20) NOT NULL COMMENT '评论编码',
  MODIFY COLUMN `cust_code` varchar(20) NOT NULL COMMENT '顾客编码',
  MODIFY COLUMN `goods_code` varchar(20) NOT NULL COMMENT '商品编码',
  MODIFY COLUMN `review` varchar(255) DEFAULT NULL COMMENT '评论内容',
  MODIFY COLUMN `review_rating` tinyint DEFAULT NULL COMMENT '评分(1-5星)',
  MODIFY COLUMN `review_time` datetime NOT NULL COMMENT '评论时间';
