/*
 Navicat Premium Dump SQL

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 80046 (8.0.46)
 Source Host           : localhost:3306
 Source Schema         : bate

 Target Server Type    : MySQL
 Target Server Version : 80046 (8.0.46)
 File Encoding         : 65001

 Date: 05/06/2026 15:01:32
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for cart
-- ----------------------------
DROP TABLE IF EXISTS `cart`;
CREATE TABLE `cart`  (
  `cart_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '购物车编码',
  `cust_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '顾客编码',
  `goods_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '商品编码',
  `quantity` int NOT NULL COMMENT '数量',
  `unit_price` decimal(10, 2) NOT NULL COMMENT '单价',
  `total_price` decimal(10, 2) NULL DEFAULT NULL COMMENT '小计',
  `add_time` datetime NOT NULL COMMENT '添加时间',
  PRIMARY KEY (`cart_code`) USING BTREE,
  INDEX `idx_cust_code`(`cust_code` ASC) USING BTREE,
  INDEX `idx_goods_code`(`goods_code` ASC) USING BTREE,
  CONSTRAINT `fk_cart_customer` FOREIGN KEY (`cust_code`) REFERENCES `customer` (`cust_code`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_cart_goods` FOREIGN KEY (`goods_code`) REFERENCES `goods` (`goods_code`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of cart
-- ----------------------------
INSERT INTO `cart` VALUES ('CART001', 'C001', 'G003', 1, 5999.00, 5999.00, '2024-01-15 09:30:00');
INSERT INTO `cart` VALUES ('CART002', 'C002', 'G005', 2, 349.00, 698.00, '2024-01-15 10:00:00');
INSERT INTO `cart` VALUES ('CART003', 'C003', 'G010', 1, 1599.00, 1599.00, '2024-01-15 11:20:00');
INSERT INTO `cart` VALUES ('CART004', 'C005', 'G002', 1, 8999.00, 8999.00, '2024-01-15 14:00:00');
INSERT INTO `cart` VALUES ('CART005', 'C006', 'G004', 3, 399.00, 1197.00, '2024-01-15 15:45:00');
INSERT INTO `cart` VALUES ('CART006', 'C001', 'G012', 1, 4788.00, 4788.00, '2024-01-15 16:10:00');

-- ----------------------------
-- Table structure for customer
-- ----------------------------
DROP TABLE IF EXISTS `customer`;
CREATE TABLE `customer`  (
  `cust_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '顾客代码',
  `cust_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '顾客名称',
  `address` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '地址',
  `postcode` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '邮编',
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '联系电话',
  `e-mail` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '顾客邮箱',
  `cust_password` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '顾客密码',
  `cust_balance` int NOT NULL COMMENT '顾客余额',
  PRIMARY KEY (`cust_code`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of customer
-- ----------------------------
INSERT INTO `customer` VALUES ('C001', '张三', '北京市朝阳区建国路88号', '100020', '13800138001', 'zhangsan@qq.com', '123456', 5000);
INSERT INTO `customer` VALUES ('C002', '李四', '上海市浦东新区张江路168号', '200120', '13900139002', 'lisi@163.com', '123456', 3000);
INSERT INTO `customer` VALUES ('C003', '王五', '广州市天河区体育西路55号', '510620', '13700137003', 'wangwu@gmail.com', '123456', 8000);
INSERT INTO `customer` VALUES ('C004', '赵六', '深圳市南山区科技园路12号', '518057', '13600136004', 'zhaoliu@outlook.com', '123456', 1500);
INSERT INTO `customer` VALUES ('C005', '陈小红', '杭州市西湖区文三路200号', '310012', '13500135005', 'chenxh@qq.com', '123456', 12000);
INSERT INTO `customer` VALUES ('C006', '刘强', '成都市武侯区人民南路33号', '610041', '13400134006', 'liuqiang@126.com', '123456', 6200);
INSERT INTO `customer` VALUES ('C007', '周美玲', '南京市鼓楼区中山北路18号', '210008', '13300133007', 'zhouml@qq.com', '123456', 4500);
INSERT INTO `customer` VALUES ('C008', '吴大伟', '武汉市洪山区珞喻路77号', '430070', '13200132008', 'wudw@163.com', '123456', 3800);

-- ----------------------------
-- Table structure for goods
-- ----------------------------
DROP TABLE IF EXISTS `goods`;
CREATE TABLE `goods`  (
  `goods_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '商品分类编码',
  `manu_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '生产厂家编码',
  `category_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '鍟嗗搧鍒嗙被缂栧彿',
  `goods_desc` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '商品说明',
  `unit_price` decimal(10, 2) NOT NULL COMMENT '单价',
  PRIMARY KEY (`goods_code`, `manu_code`) USING BTREE,
  INDEX `fk_goods_manufacturer`(`manu_code` ASC) USING BTREE,
  INDEX `idx_category`(`category_id` ASC) USING BTREE,
  CONSTRAINT `fk_goods_category` FOREIGN KEY (`category_id`) REFERENCES `goods_category` (`category_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_goods_manufacturer` FOREIGN KEY (`manu_code`) REFERENCES `manufacturer` (`manu_code`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of goods
-- ----------------------------
INSERT INTO `goods` VALUES ('G001', 'M001', 'CAT03', '华为 Mate 70 Pro 智能手机 12GB+512GB', 6999.00);
INSERT INTO `goods` VALUES ('G002', 'M001', 'CAT04', '华为 MateBook X Pro 笔记本电脑 16GB+1TB', 8999.00);
INSERT INTO `goods` VALUES ('G003', 'M002', 'CAT03', '小米 15 Ultra 智能手机 16GB+512GB', 5999.00);
INSERT INTO `goods` VALUES ('G004', 'M002', 'CAT05', '小米手环 9 Pro 智能手环', 399.00);
INSERT INTO `goods` VALUES ('G005', 'M002', 'CAT06', '小米电饭煲 4L 智能预约', 349.00);
INSERT INTO `goods` VALUES ('G006', 'M003', 'CAT08', '格力冷静王+ 变频冷暖空调 1.5匹', 3699.00);
INSERT INTO `goods` VALUES ('G007', 'M003', 'CAT06', '格力电磁炉 2200W 触控式', 259.00);
INSERT INTO `goods` VALUES ('G008', 'M004', 'CAT07', '海尔全自动滚筒洗衣机 10公斤', 4299.00);
INSERT INTO `goods` VALUES ('G009', 'M004', 'CAT08', '海尔节能变频空调 大1匹', 2799.00);
INSERT INTO `goods` VALUES ('G010', 'M005', 'CAT05', '比亚迪智能手表 车钥匙版', 1599.00);
INSERT INTO `goods` VALUES ('G011', 'M006', 'CAT04', '联想 ThinkPad X1 Carbon 商务笔记本 16GB+512GB', 9999.00);
INSERT INTO `goods` VALUES ('G012', 'M007', 'CAT01', '大疆 Mini 4 Pro 无人机 带屏遥控版', 4788.00);

-- ----------------------------
-- Table structure for goods_category
-- ----------------------------
DROP TABLE IF EXISTS `goods_category`;
CREATE TABLE `goods_category`  (
  `category_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '鍒嗙被缂栧彿',
  `category_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '鍒嗙被鍚嶇О',
  `parent_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '鐖跺垎绫荤紪鍙?鏀?寔澶氱骇鍒嗙被)',
  `sort_order` int NULL DEFAULT 0 COMMENT '鎺掑簭鍙',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '鍒涘缓鏃堕棿',
  PRIMARY KEY (`category_id`) USING BTREE,
  INDEX `idx_parent`(`parent_id` ASC) USING BTREE,
  CONSTRAINT `fk_category_parent` FOREIGN KEY (`parent_id`) REFERENCES `goods_category` (`category_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '鍟嗗搧鍒嗙被琛' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of goods_category
-- ----------------------------
INSERT INTO `goods_category` VALUES ('CAT01', '电子产品', NULL, 1, '2026-06-05 14:58:42');
INSERT INTO `goods_category` VALUES ('CAT02', '家用电器', NULL, 2, '2026-06-05 14:58:42');
INSERT INTO `goods_category` VALUES ('CAT03', '手机通讯', 'CAT01', 1, '2026-06-05 14:58:42');
INSERT INTO `goods_category` VALUES ('CAT04', '电脑办公', 'CAT01', 2, '2026-06-05 14:58:42');
INSERT INTO `goods_category` VALUES ('CAT05', '智能穿戴', 'CAT01', 3, '2026-06-05 14:58:42');
INSERT INTO `goods_category` VALUES ('CAT06', '厨房电器', 'CAT02', 1, '2026-06-05 14:58:42');
INSERT INTO `goods_category` VALUES ('CAT07', '生活电器', 'CAT02', 2, '2026-06-05 14:58:42');
INSERT INTO `goods_category` VALUES ('CAT08', '空调', 'CAT02', 3, '2026-06-05 14:58:42');

-- ----------------------------
-- Table structure for goods_image
-- ----------------------------
DROP TABLE IF EXISTS `goods_image`;
CREATE TABLE `goods_image`  (
  `image_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '鍥剧墖缂栧彿',
  `goods_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '鍟嗗搧缂栧彿',
  `image_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '鍥剧墖鍦板潃',
  `is_cover` tinyint(1) NULL DEFAULT 0 COMMENT '鏄?惁灏侀潰鍥?1-鏄?0-鍚',
  `sort_order` int NULL DEFAULT 0 COMMENT '鎺掑簭鍙',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '鍒涘缓鏃堕棿',
  PRIMARY KEY (`image_id`) USING BTREE,
  INDEX `idx_goods`(`goods_code` ASC) USING BTREE,
  CONSTRAINT `fk_image_goods` FOREIGN KEY (`goods_code`) REFERENCES `goods` (`goods_code`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '鍟嗗搧鍥剧墖琛' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of goods_image
-- ----------------------------
INSERT INTO `goods_image` VALUES ('IMG001', 'G001', '/images/goods/G001_cover.jpg', 1, 1, '2026-06-05 14:58:42');
INSERT INTO `goods_image` VALUES ('IMG002', 'G001', '/images/goods/G001_detail1.jpg', 0, 2, '2026-06-05 14:58:42');
INSERT INTO `goods_image` VALUES ('IMG003', 'G002', '/images/goods/G002_cover.jpg', 1, 1, '2026-06-05 14:58:42');
INSERT INTO `goods_image` VALUES ('IMG004', 'G003', '/images/goods/G003_cover.jpg', 1, 1, '2026-06-05 14:58:42');
INSERT INTO `goods_image` VALUES ('IMG005', 'G004', '/images/goods/G004_cover.jpg', 1, 1, '2026-06-05 14:58:42');
INSERT INTO `goods_image` VALUES ('IMG006', 'G005', '/images/goods/G005_cover.jpg', 1, 1, '2026-06-05 14:58:42');
INSERT INTO `goods_image` VALUES ('IMG007', 'G006', '/images/goods/G006_cover.jpg', 1, 1, '2026-06-05 14:58:42');
INSERT INTO `goods_image` VALUES ('IMG008', 'G007', '/images/goods/G007_cover.jpg', 1, 1, '2026-06-05 14:58:42');
INSERT INTO `goods_image` VALUES ('IMG009', 'G008', '/images/goods/G008_cover.jpg', 1, 1, '2026-06-05 14:58:42');
INSERT INTO `goods_image` VALUES ('IMG010', 'G009', '/images/goods/G009_cover.jpg', 1, 1, '2026-06-05 14:58:42');
INSERT INTO `goods_image` VALUES ('IMG011', 'G010', '/images/goods/G010_cover.jpg', 1, 1, '2026-06-05 14:58:42');
INSERT INTO `goods_image` VALUES ('IMG012', 'G011', '/images/goods/G011_cover.jpg', 1, 1, '2026-06-05 14:58:42');
INSERT INTO `goods_image` VALUES ('IMG013', 'G012', '/images/goods/G012_cover.jpg', 1, 1, '2026-06-05 14:58:42');

-- ----------------------------
-- Table structure for goods_review
-- ----------------------------
DROP TABLE IF EXISTS `goods_review`;
CREATE TABLE `goods_review`  (
  `review_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '评价编码',
  `cust_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '顾客编码',
  `goods_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '商品编码',
  `review` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '顾客评论',
  `review_rating` tinyint NULL DEFAULT NULL COMMENT '评分(1-5星)',
  `review_time` datetime NOT NULL COMMENT '评价时间',
  PRIMARY KEY (`review_code`) USING BTREE,
  INDEX `idx_cust_code`(`cust_code` ASC) USING BTREE,
  INDEX `idx_goods_code`(`goods_code` ASC) USING BTREE,
  CONSTRAINT `fk_review_customer` FOREIGN KEY (`cust_code`) REFERENCES `customer` (`cust_code`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_review_goods` FOREIGN KEY (`goods_code`) REFERENCES `goods` (`goods_code`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of goods_review
-- ----------------------------
INSERT INTO `goods_review` VALUES ('GR001', 'C001', 'G001', '手机非常好用，拍照效果一流，电池续航也不错！', 5, '2024-01-10 15:00:00');
INSERT INTO `goods_review` VALUES ('GR002', 'C001', 'G004', '手环做工精致，佩戴舒适，功能齐全，价格实惠。', 5, '2024-01-10 15:05:00');
INSERT INTO `goods_review` VALUES ('GR003', 'C002', 'G006', '空调制冷效果很好，噪音小，安装师傅也很专业。', 4, '2024-01-11 09:00:00');
INSERT INTO `goods_review` VALUES ('GR004', 'C003', 'G011', '笔记本轻薄便携，性能强劲，但屏幕有点反光。', 4, '2024-01-12 10:30:00');
INSERT INTO `goods_review` VALUES ('GR005', 'C003', 'G012', '无人机航拍效果超棒，操作简单，稳定性好！', 5, '2024-01-12 10:35:00');
INSERT INTO `goods_review` VALUES ('GR006', 'C005', 'G006', '性价比很高，制冷速度很快，就是遥控器操作不太方便。', 3, '2024-01-14 14:20:00');
INSERT INTO `goods_review` VALUES ('GR007', 'C005', 'G007', '电磁炉加热快，外观时尚，触控灵敏。', 5, '2024-01-14 14:25:00');
INSERT INTO `goods_review` VALUES ('GR008', 'C007', 'G003', '小米手机性价比真的高，徕卡拍照很喜欢！', 5, '2024-01-15 11:00:00');
INSERT INTO `goods_review` VALUES ('GR009', 'C008', 'G009', '空调安装及时，用了几天感觉不错，节能省电。', 4, '2024-01-16 16:00:00');
INSERT INTO `goods_review` VALUES ('GR010', 'C008', 'G005', '电饭煲煮饭很香，内胆不粘，清洗方便。', 5, '2024-01-16 16:10:00');
INSERT INTO `goods_review` VALUES ('GR011', 'C003', 'G001', '第二次购买了，送给父母，他们很喜欢。', 5, '2024-01-18 08:30:00');
INSERT INTO `goods_review` VALUES ('GR012', 'C004', 'G012', '之前犹豫了很久，买了之后非常满意，超出预期！', 5, '2024-01-19 19:00:00');

-- ----------------------------
-- Table structure for goods_supply
-- ----------------------------
DROP TABLE IF EXISTS `goods_supply`;
CREATE TABLE `goods_supply`  (
  `goods_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '鍟嗗搧缂栧彿',
  `supplier_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '渚涘簲鍟嗙紪鍙',
  `supply_price` decimal(10, 2) NULL DEFAULT NULL COMMENT '渚涘簲鍗曚环',
  `min_quantity` int NULL DEFAULT 1 COMMENT '鏈?皬璧疯?閲',
  `lead_days` int NULL DEFAULT NULL COMMENT '渚涜揣鍛ㄦ湡(澶?',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '鍒涘缓鏃堕棿',
  PRIMARY KEY (`goods_code`, `supplier_code`) USING BTREE,
  INDEX `fk_gs_supplier`(`supplier_code` ASC) USING BTREE,
  CONSTRAINT `fk_gs_goods` FOREIGN KEY (`goods_code`) REFERENCES `goods` (`goods_code`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_gs_supplier` FOREIGN KEY (`supplier_code`) REFERENCES `supplier` (`supplier_code`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '鍟嗗搧渚涘簲鍟嗗叧鑱旇〃' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of goods_supply
-- ----------------------------
INSERT INTO `goods_supply` VALUES ('G001', 'S001', 5800.00, 10, 7, '2026-06-05 14:58:42');
INSERT INTO `goods_supply` VALUES ('G001', 'S004', 5900.00, 5, 5, '2026-06-05 14:58:42');
INSERT INTO `goods_supply` VALUES ('G002', 'S001', 7500.00, 5, 10, '2026-06-05 14:58:42');
INSERT INTO `goods_supply` VALUES ('G003', 'S001', 4900.00, 10, 7, '2026-06-05 14:58:42');
INSERT INTO `goods_supply` VALUES ('G004', 'S005', 280.00, 50, 3, '2026-06-05 14:58:42');
INSERT INTO `goods_supply` VALUES ('G005', 'S005', 260.00, 30, 3, '2026-06-05 14:58:42');
INSERT INTO `goods_supply` VALUES ('G006', 'S003', 3100.00, 5, 5, '2026-06-05 14:58:42');
INSERT INTO `goods_supply` VALUES ('G007', 'S005', 190.00, 20, 2, '2026-06-05 14:58:42');
INSERT INTO `goods_supply` VALUES ('G008', 'S003', 3600.00, 3, 7, '2026-06-05 14:58:42');
INSERT INTO `goods_supply` VALUES ('G009', 'S003', 2300.00, 5, 5, '2026-06-05 14:58:42');
INSERT INTO `goods_supply` VALUES ('G010', 'S004', 1200.00, 10, 10, '2026-06-05 14:58:42');
INSERT INTO `goods_supply` VALUES ('G011', 'S001', 8200.00, 3, 8, '2026-06-05 14:58:42');
INSERT INTO `goods_supply` VALUES ('G012', 'S004', 4000.00, 5, 6, '2026-06-05 14:58:42');

-- ----------------------------
-- Table structure for inventory
-- ----------------------------
DROP TABLE IF EXISTS `inventory`;
CREATE TABLE `inventory`  (
  `inventory_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '搴撳瓨缂栧彿',
  `goods_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '鍟嗗搧缂栧彿',
  `warehouse_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '浠撳簱缂栧彿',
  `stock_quantity` int NOT NULL DEFAULT 0 COMMENT '搴撳瓨鏁伴噺',
  `locked_quantity` int NULL DEFAULT 0 COMMENT '閿佸畾鏁伴噺 宸蹭笅鍗曟湭鍙戣揣',
  `alert_quantity` int NULL DEFAULT 10 COMMENT '棰勮?搴撳瓨閲',
  `update_time` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '鏇存柊鏃堕棿',
  PRIMARY KEY (`inventory_id`) USING BTREE,
  UNIQUE INDEX `uk_goods_warehouse`(`goods_code` ASC, `warehouse_code` ASC) USING BTREE,
  CONSTRAINT `fk_inv_goods` FOREIGN KEY (`goods_code`) REFERENCES `goods` (`goods_code`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '搴撳瓨琛' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of inventory
-- ----------------------------
INSERT INTO `inventory` VALUES ('INV001', 'G001', 'WH-北京', 50, 2, 10, NULL);
INSERT INTO `inventory` VALUES ('INV002', 'G001', 'WH-深圳', 100, 5, 20, NULL);
INSERT INTO `inventory` VALUES ('INV003', 'G002', 'WH-深圳', 30, 1, 5, NULL);
INSERT INTO `inventory` VALUES ('INV004', 'G003', 'WH-北京', 80, 1, 15, NULL);
INSERT INTO `inventory` VALUES ('INV005', 'G004', 'WH-北京', 200, 5, 30, NULL);
INSERT INTO `inventory` VALUES ('INV006', 'G005', 'WH-上海', 150, 2, 20, NULL);
INSERT INTO `inventory` VALUES ('INV007', 'G006', 'WH-上海', 25, 3, 5, NULL);
INSERT INTO `inventory` VALUES ('INV008', 'G007', 'WH-广州', 100, 2, 15, NULL);
INSERT INTO `inventory` VALUES ('INV009', 'G008', 'WH-广州', 15, 1, 5, NULL);
INSERT INTO `inventory` VALUES ('INV010', 'G009', 'WH-上海', 40, 2, 8, NULL);
INSERT INTO `inventory` VALUES ('INV011', 'G010', 'WH-深圳', 60, 1, 10, NULL);
INSERT INTO `inventory` VALUES ('INV012', 'G011', 'WH-北京', 20, 1, 3, NULL);
INSERT INTO `inventory` VALUES ('INV013', 'G012', 'WH-深圳', 35, 2, 8, NULL);

-- ----------------------------
-- Table structure for manufacturer
-- ----------------------------
DROP TABLE IF EXISTS `manufacturer`;
CREATE TABLE `manufacturer`  (
  `manu_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '厂家代码',
  `manu_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '厂家名称',
  `manu_phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '厂家电话',
  PRIMARY KEY (`manu_code`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of manufacturer
-- ----------------------------
INSERT INTO `manufacturer` VALUES ('M001', '华为技术有限公司', '0755-28780808');
INSERT INTO `manufacturer` VALUES ('M002', '小米科技有限公司', '010-60606666');
INSERT INTO `manufacturer` VALUES ('M003', '格力电器股份有限公司', '0756-8618999');
INSERT INTO `manufacturer` VALUES ('M004', '海尔智家股份有限公司', '0532-88939999');
INSERT INTO `manufacturer` VALUES ('M005', '比亚迪股份有限公司', '0755-89888888');
INSERT INTO `manufacturer` VALUES ('M006', '联想集团有限公司', '010-58868888');
INSERT INTO `manufacturer` VALUES ('M007', '大疆创新科技有限公司', '0755-26655666');

-- ----------------------------
-- Table structure for merchant_review
-- ----------------------------
DROP TABLE IF EXISTS `merchant_review`;
CREATE TABLE `merchant_review`  (
  `review_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '璇勪环缂栧彿',
  `cust_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '椤惧?缂栧彿',
  `target_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '璇勪环瀵硅薄绫诲瀷 manufacturer/supplier',
  `target_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '璇勪环瀵硅薄缂栧彿',
  `rating` tinyint NOT NULL COMMENT '璇勫垎 1-5鏄',
  `review_content` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '璇勪环鍐呭?',
  `reply_content` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '鍟嗗?鍥炲?',
  `reply_time` datetime NULL DEFAULT NULL COMMENT '鍥炲?鏃堕棿',
  `is_anonymous` tinyint(1) NULL DEFAULT 0 COMMENT '鏄?惁鍖垮悕 1-鏄?0-鍚',
  `review_status` tinyint(1) NULL DEFAULT 1 COMMENT '瀹℃牳鐘舵? 1-閫氳繃 0-寰呭? -1-椹冲洖',
  `review_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '璇勪环鏃堕棿',
  PRIMARY KEY (`review_id`) USING BTREE,
  INDEX `idx_target`(`target_type` ASC, `target_code` ASC) USING BTREE,
  INDEX `idx_cust`(`cust_code` ASC) USING BTREE,
  INDEX `idx_rating`(`rating` ASC) USING BTREE,
  CONSTRAINT `fk_mr_customer` FOREIGN KEY (`cust_code`) REFERENCES `customer` (`cust_code`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '鍟嗗?璇勪环琛' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of merchant_review
-- ----------------------------
INSERT INTO `merchant_review` VALUES ('MR001', 'C001', 'manufacturer', 'M001', 5, '华为的产品质量一直很好，售后也很到位！', '感谢您的支持与信赖，我们会继续努力！', '2024-01-11 10:00:00', 0, 1, '2024-01-10 16:00:00');
INSERT INTO `merchant_review` VALUES ('MR002', 'C002', 'manufacturer', 'M003', 4, '格力空调用了这么多年，质量可靠。不过价格稍微贵了点。', '谢谢您的建议，我们将持续优化产品性价比。', '2024-01-12 14:00:00', 0, 1, '2024-01-11 09:30:00');
INSERT INTO `merchant_review` VALUES ('MR003', 'C003', 'manufacturer', 'M006', 3, '联想笔记本还行，但这次买的有轻微亮点，换过一次了。', '非常抱歉给您带来不便，我们已安排专人跟进处理。', '2024-01-13 16:00:00', 0, 1, '2024-01-12 11:00:00');
INSERT INTO `merchant_review` VALUES ('MR004', 'C003', 'manufacturer', 'M007', 5, '大疆无人机确实牛，技术全球领先！', NULL, NULL, 0, 1, '2024-01-12 11:10:00');
INSERT INTO `merchant_review` VALUES ('MR005', 'C005', 'manufacturer', 'M003', 4, '格力的产品总体满意，安装服务可以再快一点。', '感谢您的反馈，我们已优化安装调度系统。', '2024-01-15 09:00:00', 0, 1, '2024-01-14 15:00:00');
INSERT INTO `merchant_review` VALUES ('MR006', 'C005', 'supplier', 'S003', 5, '广州鑫源的包装材料质量很好，包装严实，物流快！', '谢谢支持，期待与您继续合作！', '2024-01-15 10:00:00', 0, 1, '2024-01-14 15:30:00');
INSERT INTO `merchant_review` VALUES ('MR007', 'C006', 'manufacturer', 'M001', 5, '华为笔记本办公用非常流畅，颜值也高。', '非常感谢您的好评！', '2024-01-16 11:00:00', 0, 1, '2024-01-15 10:00:00');
INSERT INTO `merchant_review` VALUES ('MR008', 'C007', 'manufacturer', 'M002', 4, '小米性价比没得说，希望品控能再加强。', '感谢您的建议，我们一直在努力提升品质。', '2024-01-17 14:00:00', 0, 1, '2024-01-15 12:00:00');
INSERT INTO `merchant_review` VALUES ('MR009', 'C008', 'manufacturer', 'M004', 4, '海尔家电用了很多年，售后服务特别好！', '服务好是我们的宗旨，谢谢您的认可！', '2024-01-17 15:00:00', 0, 1, '2024-01-16 17:00:00');
INSERT INTO `merchant_review` VALUES ('MR010', 'C004', 'manufacturer', 'M007', 5, '太喜欢大疆了，每次带出去飞行都引来围观！', NULL, NULL, 1, 1, '2024-01-20 10:00:00');
INSERT INTO `merchant_review` VALUES ('MR011', 'C001', 'supplier', 'S001', 5, '华强供应链发货非常及时，合作很顺畅。', '感谢您的认可，我们将一如既往提供优质服务。', '2024-01-21 09:00:00', 0, 1, '2024-01-20 14:00:00');
INSERT INTO `merchant_review` VALUES ('MR012', 'C006', 'supplier', 'S004', 3, '中科创新的芯片质量可以，但交货周期偏长了一些。', '感谢您的反馈，我们正在扩大产能缩短交期。', '2024-01-22 10:00:00', 0, 1, '2024-01-21 11:00:00');

-- ----------------------------
-- Table structure for order_detail
-- ----------------------------
DROP TABLE IF EXISTS `order_detail`;
CREATE TABLE `order_detail`  (
  `detail_id` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '鏄庣粏缂栧彿',
  `order_id` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '璁㈠崟缂栧彿',
  `goods_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '鍟嗗搧缂栧彿',
  `quantity` int NOT NULL COMMENT '鏁伴噺',
  `unit_price` decimal(10, 2) NOT NULL COMMENT '鍗曚环',
  `total_price` decimal(10, 2) NOT NULL COMMENT '灏忚?',
  `discount` decimal(10, 2) NULL DEFAULT 0.00 COMMENT '鎶樻墸閲戦?',
  PRIMARY KEY (`detail_id`) USING BTREE,
  INDEX `idx_order`(`order_id` ASC) USING BTREE,
  INDEX `idx_goods`(`goods_code` ASC) USING BTREE,
  CONSTRAINT `fk_od_goods` FOREIGN KEY (`goods_code`) REFERENCES `goods` (`goods_code`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_od_order` FOREIGN KEY (`order_id`) REFERENCES `order_main` (`order_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '璁㈠崟鏄庣粏琛' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of order_detail
-- ----------------------------
INSERT INTO `order_detail` VALUES ('DET001', 'ORD20240101001', 'G001', 1, 6999.00, 6999.00, 0.00);
INSERT INTO `order_detail` VALUES ('DET002', 'ORD20240101001', 'G004', 2, 399.00, 798.00, 0.00);
INSERT INTO `order_detail` VALUES ('DET003', 'ORD20240102001', 'G006', 1, 3699.00, 3699.00, 100.00);
INSERT INTO `order_detail` VALUES ('DET004', 'ORD20240103001', 'G011', 1, 9999.00, 9999.00, 500.00);
INSERT INTO `order_detail` VALUES ('DET005', 'ORD20240103001', 'G012', 1, 4788.00, 4788.00, 0.00);
INSERT INTO `order_detail` VALUES ('DET006', 'ORD20240104001', 'G008', 1, 4299.00, 4299.00, 0.00);
INSERT INTO `order_detail` VALUES ('DET007', 'ORD20240105001', 'G006', 2, 3699.00, 7398.00, 200.00);
INSERT INTO `order_detail` VALUES ('DET008', 'ORD20240105001', 'G007', 1, 259.00, 259.00, 0.00);
INSERT INTO `order_detail` VALUES ('DET009', 'ORD20240106001', 'G010', 1, 1599.00, 1599.00, 0.00);
INSERT INTO `order_detail` VALUES ('DET010', 'ORD20240107001', 'G002', 1, 8999.00, 8999.00, 300.00);
INSERT INTO `order_detail` VALUES ('DET011', 'ORD20240108001', 'G003', 1, 5999.00, 5999.00, 0.00);
INSERT INTO `order_detail` VALUES ('DET012', 'ORD20240109001', 'G009', 2, 2799.00, 5598.00, 0.00);
INSERT INTO `order_detail` VALUES ('DET013', 'ORD20240109001', 'G005', 1, 349.00, 349.00, 0.00);
INSERT INTO `order_detail` VALUES ('DET014', 'ORD20240110001', 'G007', 1, 259.00, 259.00, 0.00);
INSERT INTO `order_detail` VALUES ('DET015', 'ORD20240111001', 'G001', 1, 6999.00, 6999.00, 200.00);
INSERT INTO `order_detail` VALUES ('DET016', 'ORD20240112001', 'G012', 1, 4788.00, 4788.00, 0.00);
INSERT INTO `order_detail` VALUES ('DET017', 'ORD20240112001', 'G004', 3, 399.00, 1197.00, 50.00);

-- ----------------------------
-- Table structure for order_main
-- ----------------------------
DROP TABLE IF EXISTS `order_main`;
CREATE TABLE `order_main`  (
  `order_id` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '订单号',
  `order_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '下单日期',
  `cust_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '顾客代码',
  `transport_req` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '运输要求',
  `supply_flag` tinyint(1) NOT NULL DEFAULT 1 COMMENT '能否供货标志 1-能 0-否',
  `transport_date` date NULL DEFAULT NULL COMMENT '运输日期',
  `goods_weight` decimal(8, 2) NULL DEFAULT NULL COMMENT '货物重量',
  `freight` decimal(10, 2) NULL DEFAULT NULL COMMENT '运费',
  `pay_list` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '付款清单',
  PRIMARY KEY (`order_id`, `cust_code`) USING BTREE,
  INDEX `idx_cust_code`(`cust_code` ASC) USING BTREE,
  CONSTRAINT `fk_order_customer` FOREIGN KEY (`cust_code`) REFERENCES `customer` (`cust_code`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of order_main
-- ----------------------------
INSERT INTO `order_main` VALUES ('ORD20240101001', '2024-01-01 10:30:00', 'C001', '送货上门', 1, '2024-01-03', 2.50, 15.00, '已付');
INSERT INTO `order_main` VALUES ('ORD20240102001', '2024-01-02 14:20:00', 'C002', '快递', 1, '2024-01-04', 1.80, 10.00, '已付');
INSERT INTO `order_main` VALUES ('ORD20240103001', '2024-01-03 09:15:00', 'C003', '工作日配送', 1, '2024-01-05', 5.00, 25.00, '已付');
INSERT INTO `order_main` VALUES ('ORD20240104001', '2024-01-04 16:45:00', 'C001', '送货上门', 1, '2024-01-06', 3.20, 18.00, '已付');
INSERT INTO `order_main` VALUES ('ORD20240105001', '2024-01-05 11:00:00', 'C005', '周末配送', 1, '2024-01-07', 8.00, 35.00, '已付');
INSERT INTO `order_main` VALUES ('ORD20240106001', '2024-01-06 20:30:00', 'C004', '送货上门', 0, NULL, 0.00, 0.00, '未付');
INSERT INTO `order_main` VALUES ('ORD20240107001', '2024-01-07 08:00:00', 'C006', '快递', 1, '2024-01-09', 4.50, 20.00, '已付');
INSERT INTO `order_main` VALUES ('ORD20240108001', '2024-01-08 13:10:00', 'C007', '送货上门 轻拿轻放', 1, '2024-01-10', 2.00, 12.00, '已付');
INSERT INTO `order_main` VALUES ('ORD20240109001', '2024-01-09 17:00:00', 'C008', '快递', 1, '2024-01-11', 6.30, 30.00, '部分付');
INSERT INTO `order_main` VALUES ('ORD20240110001', '2024-01-10 10:00:00', 'C002', '送货上门', 1, '2024-01-12', 1.20, 8.00, '已付');
INSERT INTO `order_main` VALUES ('ORD20240111001', '2024-01-11 15:30:00', 'C003', '周末配送', 1, '2024-01-13', 3.80, 22.00, '已付');
INSERT INTO `order_main` VALUES ('ORD20240112001', '2024-01-12 12:00:00', 'C004', '送货上门', 1, '2024-01-14', 7.50, 32.00, '已付');

-- ----------------------------
-- Table structure for payment
-- ----------------------------
DROP TABLE IF EXISTS `payment`;
CREATE TABLE `payment`  (
  `payment_id` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '鏀?粯缂栧彿',
  `order_id` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '璁㈠崟缂栧彿',
  `cust_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '椤惧?缂栧彿',
  `payment_method` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '鏀?粯鏂瑰紡 alipay/wechat/bank/card/balance',
  `payment_amount` decimal(10, 2) NOT NULL COMMENT '鏀?粯閲戦?',
  `payment_status` tinyint(1) NULL DEFAULT 0 COMMENT '鏀?粯鐘舵? 0-寰呬粯 1-鎴愬姛 2-澶辫触 3-宸查?娆',
  `transaction_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '绗?笁鏂逛氦鏄撴祦姘村彿',
  `payment_time` datetime NULL DEFAULT NULL COMMENT '鏀?粯鏃堕棿',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '鍒涘缓鏃堕棿',
  PRIMARY KEY (`payment_id`) USING BTREE,
  INDEX `idx_order`(`order_id` ASC) USING BTREE,
  INDEX `idx_cust`(`cust_code` ASC) USING BTREE,
  CONSTRAINT `fk_pay_customer` FOREIGN KEY (`cust_code`) REFERENCES `customer` (`cust_code`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_pay_order` FOREIGN KEY (`order_id`) REFERENCES `order_main` (`order_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '鏀?粯璁板綍琛' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of payment
-- ----------------------------
INSERT INTO `payment` VALUES ('PAY001', 'ORD20240101001', 'C001', 'alipay', 7797.00, 1, 'ALI20240101103000', '2024-01-01 10:31:00', '2026-06-05 14:58:42');
INSERT INTO `payment` VALUES ('PAY002', 'ORD20240102001', 'C002', 'wechat', 3599.00, 1, 'WX20240102142100', '2024-01-02 14:21:00', '2026-06-05 14:58:42');
INSERT INTO `payment` VALUES ('PAY003', 'ORD20240103001', 'C003', 'bank', 14287.00, 1, 'BANK20240103091600', '2024-01-03 09:16:00', '2026-06-05 14:58:42');
INSERT INTO `payment` VALUES ('PAY004', 'ORD20240104001', 'C001', 'alipay', 4299.00, 1, 'ALI20240104164600', '2024-01-04 16:46:00', '2026-06-05 14:58:42');
INSERT INTO `payment` VALUES ('PAY005', 'ORD20240105001', 'C005', 'balance', 7457.00, 1, NULL, '2024-01-05 11:01:00', '2026-06-05 14:58:42');
INSERT INTO `payment` VALUES ('PAY006', 'ORD20240107001', 'C006', 'wechat', 8699.00, 1, 'WX20240107080100', '2024-01-07 08:01:00', '2026-06-05 14:58:42');
INSERT INTO `payment` VALUES ('PAY007', 'ORD20240108001', 'C007', 'alipay', 5999.00, 1, 'ALI20240108131100', '2024-01-08 13:11:00', '2026-06-05 14:58:42');
INSERT INTO `payment` VALUES ('PAY008', 'ORD20240109001', 'C008', 'card', 5947.00, 2, NULL, NULL, '2026-06-05 14:58:42');
INSERT INTO `payment` VALUES ('PAY009', 'ORD20240109001', 'C008', 'alipay', 5947.00, 1, 'ALI20240109170200', '2024-01-09 17:02:00', '2026-06-05 14:58:42');
INSERT INTO `payment` VALUES ('PAY010', 'ORD20240110001', 'C002', 'wechat', 259.00, 1, 'WX20240110100100', '2024-01-10 10:01:00', '2026-06-05 14:58:42');
INSERT INTO `payment` VALUES ('PAY011', 'ORD20240111001', 'C003', 'bank', 6799.00, 1, 'BANK20240111153100', '2024-01-11 15:31:00', '2026-06-05 14:58:42');
INSERT INTO `payment` VALUES ('PAY012', 'ORD20240112001', 'C004', 'alipay', 5935.00, 1, 'ALI20240112120100', '2024-01-12 12:01:00', '2026-06-05 14:58:42');
INSERT INTO `payment` VALUES ('PAY013', 'ORD20240106001', 'C004', 'alipay', 1599.00, 0, NULL, NULL, '2026-06-05 14:58:42');

-- ----------------------------
-- Table structure for shipping_address
-- ----------------------------
DROP TABLE IF EXISTS `shipping_address`;
CREATE TABLE `shipping_address`  (
  `address_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '鍦板潃缂栧彿',
  `cust_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '椤惧?缂栧彿',
  `receiver_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '鏀惰揣浜哄?鍚',
  `receiver_phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '鏀惰揣浜虹數璇',
  `province` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '鐪',
  `city` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '甯',
  `district` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '鍖',
  `detail_address` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '璇︾粏鍦板潃',
  `postcode` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '閭?紪',
  `is_default` tinyint(1) NULL DEFAULT 0 COMMENT '鏄?惁榛樿?鍦板潃 1-鏄?0-鍚',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '鍒涘缓鏃堕棿',
  PRIMARY KEY (`address_id`) USING BTREE,
  INDEX `idx_cust`(`cust_code` ASC) USING BTREE,
  CONSTRAINT `fk_addr_customer` FOREIGN KEY (`cust_code`) REFERENCES `customer` (`cust_code`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '鏀惰揣鍦板潃琛' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of shipping_address
-- ----------------------------
INSERT INTO `shipping_address` VALUES ('ADDR001', 'C001', '张三', '13800138001', '北京市', '北京市', '朝阳区', '建国路88号SOHO现代城A座1205', '100020', 1, '2026-06-05 14:58:42');
INSERT INTO `shipping_address` VALUES ('ADDR002', 'C001', '张太太', '13900139099', '北京市', '北京市', '海淀区', '中关村东路1号清华科技园B座808', '100084', 0, '2026-06-05 14:58:42');
INSERT INTO `shipping_address` VALUES ('ADDR003', 'C002', '李四', '13900139002', '上海市', '上海市', '浦东新区', '张江路168号盛大网络园区3号楼', '200120', 1, '2026-06-05 14:58:42');
INSERT INTO `shipping_address` VALUES ('ADDR004', 'C003', '王五', '13700137003', '广东省', '广州市', '天河区', '体育西路55号天河城广场', '510620', 1, '2026-06-05 14:58:42');
INSERT INTO `shipping_address` VALUES ('ADDR005', 'C004', '赵六', '13600136004', '广东省', '深圳市', '南山区', '科技园路12号腾讯滨海大厦', '518057', 1, '2026-06-05 14:58:42');
INSERT INTO `shipping_address` VALUES ('ADDR006', 'C005', '陈小红', '13500135005', '浙江省', '杭州市', '西湖区', '文三路200号支付宝大楼', '310012', 1, '2026-06-05 14:58:42');
INSERT INTO `shipping_address` VALUES ('ADDR007', 'C006', '刘强', '13400134006', '四川省', '成都市', '武侯区', '人民南路33号天府软件园', '610041', 1, '2026-06-05 14:58:42');
INSERT INTO `shipping_address` VALUES ('ADDR008', 'C007', '周美玲', '13300133007', '江苏省', '南京市', '鼓楼区', '中山北路18号紫峰大厦', '210008', 1, '2026-06-05 14:58:42');
INSERT INTO `shipping_address` VALUES ('ADDR009', 'C008', '吴大伟', '13200132008', '湖北省', '武汉市', '洪山区', '珞喻路77号光谷广场', '430070', 1, '2026-06-05 14:58:42');

-- ----------------------------
-- Table structure for supplier
-- ----------------------------
DROP TABLE IF EXISTS `supplier`;
CREATE TABLE `supplier`  (
  `supplier_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '渚涘簲鍟嗙紪鍙',
  `supplier_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '渚涘簲鍟嗗悕绉',
  `contact_person` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '鑱旂郴浜',
  `contact_phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '鑱旂郴鐢佃瘽',
  `contact_email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '鑱旂郴閭??',
  `address` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '鍦板潃',
  `bank_account` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '閾惰?璐﹀彿',
  `bank_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '寮?埛閾惰?',
  `tax_id` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '绋庡彿',
  `supply_category` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '渚涘簲绫诲埆',
  `cooperation_status` tinyint(1) NULL DEFAULT 1 COMMENT '鍚堜綔鐘舵? 1-鍚堜綔涓?0-宸茬粓姝',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '澶囨敞',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '鍒涘缓鏃堕棿',
  `update_time` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '鏇存柊鏃堕棿',
  PRIMARY KEY (`supplier_code`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '渚涘簲鍟嗚〃' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of supplier
-- ----------------------------
INSERT INTO `supplier` VALUES ('S001', '深圳华强电子供应链有限公司', '王建国', '0755-82345678', 'wangjg@hq-sc.com', '深圳市福田区华强北路1002号', '6222024000012345678', '中国工商银行深圳分行', '91440300123456789A', '电子元器件', 1, '长期合作供应商', '2026-06-05 14:58:42', NULL);
INSERT INTO `supplier` VALUES ('S002', '上海通达物流设备有限公司', '李明辉', '021-58765432', 'limh@td-logi.com', '上海市嘉定区安亭镇博园路668号', '6228480030012345678', '中国农业银行上海分行', '91310114001234567B', '物流设备', 1, NULL, '2026-06-05 14:58:42', NULL);
INSERT INTO `supplier` VALUES ('S003', '广州鑫源包装材料有限公司', '陈志强', '020-85678901', 'chenzq@xy-pack.com', '广州市白云区人和镇凤和工业区', '6221880100012345678', '中国建设银行广州分行', '91440101001234567C', '包装材料', 1, '优先供应商', '2026-06-05 14:58:42', NULL);
INSERT INTO `supplier` VALUES ('S004', '北京中科创新科技有限公司', '张伟', '010-62578901', 'zhangw@zktech.cn', '北京市海淀区中关村南大街12号', '6227000012345678901', '中国银行北京分行', '91110108009876543D', '芯片/半导体', 1, '2024年新引入', '2026-06-05 14:58:42', NULL);
INSERT INTO `supplier` VALUES ('S005', '杭州恒达五金制品有限公司', '赵永刚', '0571-85234123', 'zhaoyg@hd-wujin.com', '杭州市余杭区良渚工业园', '6234560100012345678', '交通银行杭州分行', '91330110002345678E', '五金配件', 0, '合同到期未续签', '2026-06-05 14:58:42', NULL);
INSERT INTO `supplier` VALUES ('S006', '成都盈科物流服务有限公司', '孙海燕', '028-85123678', 'sunhy@yk-wuliu.com', '成都市双流区航空港物流园', '6217000100012345678', '招商银行成都分行', '91510122003456789F', '物流运输', 1, NULL, '2026-06-05 14:58:42', NULL);

SET FOREIGN_KEY_CHECKS = 1;
