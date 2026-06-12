/*
 Navicat Premium Dump SQL

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 80046 (8.0.46)
 Source Host           : localhost:3306
 Source Schema         : demo

 Target Server Type    : MySQL
 Target Server Version : 80046 (8.0.46)
 File Encoding         : 65001

 Date: 12/06/2026 15:00:28
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for cart
-- ----------------------------
DROP TABLE IF EXISTS `cart`;
CREATE TABLE `cart`  (
  `cart_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `user_id` int NOT NULL,
  `goods_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `quantity` int NOT NULL,
  `unit_price` decimal(10, 2) NOT NULL,
  `total_price` decimal(10, 2) NULL DEFAULT NULL,
  `add_time` datetime NOT NULL,
  PRIMARY KEY (`cart_code`) USING BTREE,
  INDEX `idx_user`(`user_id` ASC) USING BTREE,
  INDEX `idx_goods`(`goods_code` ASC) USING BTREE,
  CONSTRAINT `fk_cart_goods` FOREIGN KEY (`goods_code`) REFERENCES `goods` (`goods_code`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of cart
-- ----------------------------

-- ----------------------------
-- Table structure for goods
-- ----------------------------
DROP TABLE IF EXISTS `goods`;
CREATE TABLE `goods`  (
  `goods_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `manu_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `category_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `goods_desc` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `unit_price` decimal(10, 2) NOT NULL,
  PRIMARY KEY (`goods_code`, `manu_code`) USING BTREE,
  INDEX `idx_manu`(`manu_code` ASC) USING BTREE,
  INDEX `idx_category`(`category_id` ASC) USING BTREE,
  INDEX `goods_code`(`goods_code` ASC) USING BTREE,
  CONSTRAINT `fk_goods_category` FOREIGN KEY (`category_id`) REFERENCES `goods_category` (`category_id`) ON DELETE SET NULL ON UPDATE CASCADE,
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
INSERT INTO `goods` VALUES ('G013', 'M008', 'CAT09', '好', 5.00);

-- ----------------------------
-- Table structure for goods_category
-- ----------------------------
DROP TABLE IF EXISTS `goods_category`;
CREATE TABLE `goods_category`  (
  `category_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `category_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `parent_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `sort_order` int NULL DEFAULT 0,
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`category_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of goods_category
-- ----------------------------
INSERT INTO `goods_category` VALUES ('CAT01', '电子产品', NULL, 1, '2026-06-09 10:45:05');
INSERT INTO `goods_category` VALUES ('CAT02', '家用电器', NULL, 2, '2026-06-09 10:45:05');
INSERT INTO `goods_category` VALUES ('CAT03', '手机通讯', 'CAT01', 1, '2026-06-09 10:45:05');
INSERT INTO `goods_category` VALUES ('CAT04', '电脑办公', 'CAT01', 2, '2026-06-09 10:45:05');
INSERT INTO `goods_category` VALUES ('CAT05', '智能穿戴', 'CAT01', 3, '2026-06-09 10:45:05');
INSERT INTO `goods_category` VALUES ('CAT06', '厨房电器', 'CAT02', 1, '2026-06-09 10:45:05');
INSERT INTO `goods_category` VALUES ('CAT07', '生活电器', 'CAT02', 2, '2026-06-09 10:45:05');
INSERT INTO `goods_category` VALUES ('CAT08', '空调', 'CAT02', 3, '2026-06-09 10:45:05');
INSERT INTO `goods_category` VALUES ('CAT09', '神奇宝贝', NULL, 9, '2026-06-09 14:40:34');

-- ----------------------------
-- Table structure for goods_image
-- ----------------------------
DROP TABLE IF EXISTS `goods_image`;
CREATE TABLE `goods_image`  (
  `image_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `goods_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `image_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `is_cover` tinyint(1) NULL DEFAULT 0,
  `sort_order` int NULL DEFAULT 0,
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`image_id`) USING BTREE,
  INDEX `idx_goods`(`goods_code` ASC) USING BTREE,
  CONSTRAINT `fk_image_goods` FOREIGN KEY (`goods_code`) REFERENCES `goods` (`goods_code`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of goods_image
-- ----------------------------
INSERT INTO `goods_image` VALUES ('IMG1780984535226', 'G001', 'http://localhost:9999/file/download/1780984534373_杰瑞.jpg', 0, 1, '2026-06-09 13:55:35');
INSERT INTO `goods_image` VALUES ('IMG1780984547531', 'G001', 'http://localhost:9999/file/download/1780984546773_杰瑞.jpg', 0, 1, '2026-06-09 13:55:48');
INSERT INTO `goods_image` VALUES ('IMG1780984573787', 'G001', 'http://localhost:9999/file/download/1780984572316_杰瑞.jpg', 0, 1, '2026-06-09 13:56:14');
INSERT INTO `goods_image` VALUES ('IMG1780984588049', 'G001', 'http://localhost:9999/file/download/1780984587024_杰瑞.jpg', 0, 1, '2026-06-09 13:56:28');
INSERT INTO `goods_image` VALUES ('IMG1780984626568', 'G001', 'http://localhost:9999/file/download/1780984624599_杰瑞.jpg', 0, 1, '2026-06-09 13:57:07');
INSERT INTO `goods_image` VALUES ('IMG1780985523250', 'G001', 'http://localhost:9999/file/download/1780985522556_杰瑞.jpg', 0, 1, '2026-06-09 14:12:03');
INSERT INTO `goods_image` VALUES ('IMG1780987247534', 'G013', 'http://localhost:9999/file/download/lxn.jpg', 1, 1, '2026-06-09 14:40:48');
INSERT INTO `goods_image` VALUES ('IMG1781244901489', 'G001', 'http://localhost:9999/file/download/1781244900653_杰瑞.jpg', 1, 1, '2026-06-12 14:15:01');

-- ----------------------------
-- Table structure for goods_review
-- ----------------------------
DROP TABLE IF EXISTS `goods_review`;
CREATE TABLE `goods_review`  (
  `review_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `user_id` int NOT NULL,
  `goods_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `review` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `review_rating` tinyint NULL DEFAULT NULL,
  `review_time` datetime NOT NULL,
  PRIMARY KEY (`review_code`) USING BTREE,
  INDEX `idx_user`(`user_id` ASC) USING BTREE,
  INDEX `idx_goods`(`goods_code` ASC) USING BTREE,
  CONSTRAINT `fk_review_goods` FOREIGN KEY (`goods_code`) REFERENCES `goods` (`goods_code`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_review_user` FOREIGN KEY (`user_id`) REFERENCES `usermessage` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of goods_review
-- ----------------------------
INSERT INTO `goods_review` VALUES ('GR001', 4, 'G001', '手机非常好用，拍照效果一流，电池续航也不错！', 5, '2024-01-10 15:00:00');
INSERT INTO `goods_review` VALUES ('GR002', 4, 'G004', '手环做工精致，佩戴舒适，功能齐全，价格实惠。', 5, '2024-01-10 15:05:00');
INSERT INTO `goods_review` VALUES ('GR003', 5, 'G006', '空调制冷效果很好，噪音小，安装师傅也很专业。', 4, '2024-01-11 09:00:00');
INSERT INTO `goods_review` VALUES ('GR004', 6, 'G011', '笔记本轻薄便携，性能强劲，但屏幕有点反光。', 4, '2024-01-12 10:30:00');
INSERT INTO `goods_review` VALUES ('GR005', 6, 'G012', '无人机航拍效果超棒，操作简单，稳定性好！', 5, '2024-01-12 10:35:00');
INSERT INTO `goods_review` VALUES ('GR006', 8, 'G006', '性价比很高，制冷速度很快，就是遥控器操作不太方便。', 3, '2024-01-14 14:20:00');
INSERT INTO `goods_review` VALUES ('GR007', 8, 'G007', '电磁炉加热快，外观时尚，触控灵敏。', 5, '2024-01-14 14:25:00');
INSERT INTO `goods_review` VALUES ('GR008', 10, 'G003', '小米手机性价比真的高，徕卡拍照很喜欢！', 5, '2024-01-15 11:00:00');
INSERT INTO `goods_review` VALUES ('GR009', 11, 'G009', '空调安装及时，用了几天感觉不错，节能省电。', 4, '2024-01-16 16:00:00');
INSERT INTO `goods_review` VALUES ('GR010', 11, 'G005', '电饭煲煮饭很香，内胆不粘，清洗方便。', 5, '2024-01-16 16:10:00');
INSERT INTO `goods_review` VALUES ('GR011', 6, 'G001', '第二次购买了，送给父母，他们很喜欢。', 5, '2024-01-18 08:30:00');
INSERT INTO `goods_review` VALUES ('GR012', 7, 'G012', '之前犹豫了很久，买了之后非常满意，超出预期！', 5, '2024-01-19 19:00:00');

-- ----------------------------
-- Table structure for manufacturer
-- ----------------------------
DROP TABLE IF EXISTS `manufacturer`;
CREATE TABLE `manufacturer`  (
  `manu_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `manu_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `manu_phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
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
INSERT INTO `manufacturer` VALUES ('M008', '358', '8176-9275');

-- ----------------------------
-- Table structure for userlogin
-- ----------------------------
DROP TABLE IF EXISTS `userlogin`;
CREATE TABLE `userlogin`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `role` tinyint NOT NULL DEFAULT 2 COMMENT '0=管理员 2=用户',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_username`(`username` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of userlogin
-- ----------------------------
INSERT INTO `userlogin` VALUES (1, 'admin', '123', 0);
INSERT INTO `userlogin` VALUES (2, 'tom', '123123', 2);
INSERT INTO `userlogin` VALUES (3, 'jerry', '123', 2);
INSERT INTO `userlogin` VALUES (4, 'zhangsan', '123456', 2);
INSERT INTO `userlogin` VALUES (5, 'lisi', '123456', 2);
INSERT INTO `userlogin` VALUES (6, 'wangwu', '123456', 2);
INSERT INTO `userlogin` VALUES (7, 'zhaoliu', '123456', 2);
INSERT INTO `userlogin` VALUES (8, 'chenxh', '123456', 2);
INSERT INTO `userlogin` VALUES (9, 'liuqiang', '123456', 2);
INSERT INTO `userlogin` VALUES (10, 'zhouml', '123456', 2);
INSERT INTO `userlogin` VALUES (11, 'wudw', '123456', 2);
INSERT INTO `userlogin` VALUES (12, 'test', 'q123123', 0);

-- ----------------------------
-- Table structure for usermessage
-- ----------------------------
DROP TABLE IF EXISTS `usermessage`;
CREATE TABLE `usermessage`  (
  `user_id` int NOT NULL,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `address` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `postcode` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `balance` int NULL DEFAULT 0,
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `sex` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `age` int NULL DEFAULT NULL,
  `infos` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`user_id`) USING BTREE,
  CONSTRAINT `fk_um_userlogin` FOREIGN KEY (`user_id`) REFERENCES `userlogin` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of usermessage
-- ----------------------------
INSERT INTO `usermessage` VALUES (1, '管理员', '13677889988', 'admin@xxx.com', '江苏南京', NULL, 94000, 'http://localhost:9999/file/download/1780987881280_汤姆.jpg', '男', 27, '我是管理员');
INSERT INTO `usermessage` VALUES (2, '汤姆', '13988776699', 'jerry@qq.com', '北京', NULL, 58005, NULL, '男', 24, NULL);
INSERT INTO `usermessage` VALUES (3, '杰瑞', '15098765321', 'tom@qq.com', '上海', NULL, 0, NULL, '男', 25, NULL);
INSERT INTO `usermessage` VALUES (4, '张三', '13800138001', 'zhangsan@qq.com', '北京市朝阳区建国路88号', '100020', 5000, NULL, NULL, NULL, NULL);
INSERT INTO `usermessage` VALUES (5, '李四', '13900139002', 'lisi@163.com', '上海市浦东新区张江路168号', '200120', 3000, NULL, NULL, NULL, NULL);
INSERT INTO `usermessage` VALUES (6, '王五', '13700137003', 'wangwu@gmail.com', '广州市天河区体育西路55号', '510620', 8000, NULL, NULL, NULL, NULL);
INSERT INTO `usermessage` VALUES (7, '赵六', '13600136004', 'zhaoliu@outlook.com', '深圳市南山区科技园路12号', '518057', 1500, NULL, NULL, NULL, NULL);
INSERT INTO `usermessage` VALUES (8, '陈小红', '13500135005', 'chenxh@qq.com', '杭州市西湖区文三路200号', '310012', 12000, NULL, NULL, NULL, NULL);
INSERT INTO `usermessage` VALUES (9, '刘强', '13400134006', 'liuqiang@126.com', '成都市武侯区人民南路33号', '610041', 6200, NULL, NULL, NULL, NULL);
INSERT INTO `usermessage` VALUES (10, '周美玲', '13300133007', 'zhouml@qq.com', '南京市鼓楼区中山北路18号', '210008', 4500, NULL, NULL, NULL, NULL);
INSERT INTO `usermessage` VALUES (11, '吴大伟', '13200132008', 'wudw@163.com', '武汉市洪山区珞喻路77号', '430070', 3800, NULL, NULL, NULL, NULL);

SET FOREIGN_KEY_CHECKS = 1;
