-- ============================================================
-- demo 数据库（精简版：8张核心表）
-- userlogin / usermessage / goods / manufacturer / goods_image
-- goods_review / goods_category / cart
-- ============================================================

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ============================================================
-- 1. userlogin 用户登录表
-- ============================================================
DROP TABLE IF EXISTS `userlogin`;
CREATE TABLE `userlogin` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` tinyint NOT NULL DEFAULT 2 COMMENT '0=管理员 2=用户',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4;

INSERT INTO `userlogin` VALUES
(1, 'admin', '123', 0),
(2, 'tom', '123', 2),
(3, 'jerry', '123', 2),
(4, 'zhangsan', '123456', 2),
(5, 'lisi', '123456', 2),
(6, 'wangwu', '123456', 2),
(7, 'zhaoliu', '123456', 2),
(8, 'chenxh', '123456', 2),
(9, 'liuqiang', '123456', 2),
(10, 'zhouml', '123456', 2),
(11, 'wudw', '123456', 2);

-- ============================================================
-- 2. usermessage 用户信息表
-- ============================================================
DROP TABLE IF EXISTS `usermessage`;
CREATE TABLE `usermessage` (
  `user_id` int NOT NULL,
  `name` varchar(50) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `address` varchar(200) DEFAULT NULL,
  `postcode` varchar(10) DEFAULT NULL,
  `balance` int DEFAULT 0,
  `avatar` varchar(255) DEFAULT NULL,
  `sex` varchar(10) DEFAULT NULL,
  `age` int DEFAULT NULL,
  `infos` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  CONSTRAINT `fk_um_userlogin` FOREIGN KEY (`user_id`) REFERENCES `userlogin` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `usermessage` VALUES
(1, '管理员', '13677889988', 'admin@xxx.com', '江苏南京', NULL, 0, NULL, '男', 27, '我是管理员'),
(2, '汤姆', '13988776699', 'jerry@qq.com', '北京', NULL, 0, NULL, '男', 24, NULL),
(3, '杰瑞', '15098765321', 'tom@qq.com', '上海', NULL, 0, NULL, '男', 25, NULL),
(4, '张三', '13800138001', 'zhangsan@qq.com', '北京市朝阳区建国路88号', '100020', 5000, NULL, NULL, NULL, NULL),
(5, '李四', '13900139002', 'lisi@163.com', '上海市浦东新区张江路168号', '200120', 3000, NULL, NULL, NULL, NULL),
(6, '王五', '13700137003', 'wangwu@gmail.com', '广州市天河区体育西路55号', '510620', 8000, NULL, NULL, NULL, NULL),
(7, '赵六', '13600136004', 'zhaoliu@outlook.com', '深圳市南山区科技园路12号', '518057', 1500, NULL, NULL, NULL, NULL),
(8, '陈小红', '13500135005', 'chenxh@qq.com', '杭州市西湖区文三路200号', '310012', 12000, NULL, NULL, NULL, NULL),
(9, '刘强', '13400134006', 'liuqiang@126.com', '成都市武侯区人民南路33号', '610041', 6200, NULL, NULL, NULL, NULL),
(10, '周美玲', '13300133007', 'zhouml@qq.com', '南京市鼓楼区中山北路18号', '210008', 4500, NULL, NULL, NULL, NULL),
(11, '吴大伟', '13200132008', 'wudw@163.com', '武汉市洪山区珞喻路77号', '430070', 3800, NULL, NULL, NULL, NULL);

-- ============================================================
-- 3. goods_category 商品分类
-- ============================================================
DROP TABLE IF EXISTS `goods_category`;
CREATE TABLE `goods_category` (
  `category_id` varchar(20) NOT NULL,
  `category_name` varchar(50) NOT NULL,
  `parent_id` varchar(20) DEFAULT NULL,
  `sort_order` int DEFAULT 0,
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `goods_category` VALUES
('CAT01', '电子产品', NULL, 1, NOW()),
('CAT02', '家用电器', NULL, 2, NOW()),
('CAT03', '手机通讯', 'CAT01', 1, NOW()),
('CAT04', '电脑办公', 'CAT01', 2, NOW()),
('CAT05', '智能穿戴', 'CAT01', 3, NOW()),
('CAT06', '厨房电器', 'CAT02', 1, NOW()),
('CAT07', '生活电器', 'CAT02', 2, NOW()),
('CAT08', '空调', 'CAT02', 3, NOW());

-- ============================================================
-- 4. manufacturer 厂家
-- ============================================================
DROP TABLE IF EXISTS `manufacturer`;
CREATE TABLE `manufacturer` (
  `manu_code` varchar(20) NOT NULL,
  `manu_name` varchar(50) NOT NULL,
  `manu_phone` varchar(20) NOT NULL,
  PRIMARY KEY (`manu_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `manufacturer` VALUES
('M001', '华为技术有限公司', '0755-28780808'),
('M002', '小米科技有限公司', '010-60606666'),
('M003', '格力电器股份有限公司', '0756-8618999'),
('M004', '海尔智家股份有限公司', '0532-88939999'),
('M005', '比亚迪股份有限公司', '0755-89888888'),
('M006', '联想集团有限公司', '010-58868888'),
('M007', '大疆创新科技有限公司', '0755-26655666');

-- ============================================================
-- 5. goods 商品
-- ============================================================
DROP TABLE IF EXISTS `goods`;
CREATE TABLE `goods` (
  `goods_code` varchar(20) NOT NULL,
  `manu_code` varchar(20) NOT NULL,
  `category_id` varchar(20) DEFAULT NULL,
  `goods_desc` varchar(200) DEFAULT NULL,
  `unit_price` decimal(10,2) NOT NULL,
  PRIMARY KEY (`goods_code`, `manu_code`),
  KEY `idx_manu` (`manu_code`),
  KEY `idx_category` (`category_id`),
  CONSTRAINT `fk_goods_category` FOREIGN KEY (`category_id`) REFERENCES `goods_category` (`category_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_goods_manufacturer` FOREIGN KEY (`manu_code`) REFERENCES `manufacturer` (`manu_code`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `goods` VALUES
('G001', 'M001', 'CAT03', '华为 Mate 70 Pro 智能手机 12GB+512GB', 6999.00),
('G002', 'M001', 'CAT04', '华为 MateBook X Pro 笔记本电脑 16GB+1TB', 8999.00),
('G003', 'M002', 'CAT03', '小米 15 Ultra 智能手机 16GB+512GB', 5999.00),
('G004', 'M002', 'CAT05', '小米手环 9 Pro 智能手环', 399.00),
('G005', 'M002', 'CAT06', '小米电饭煲 4L 智能预约', 349.00),
('G006', 'M003', 'CAT08', '格力冷静王+ 变频冷暖空调 1.5匹', 3699.00),
('G007', 'M003', 'CAT06', '格力电磁炉 2200W 触控式', 259.00),
('G008', 'M004', 'CAT07', '海尔全自动滚筒洗衣机 10公斤', 4299.00),
('G009', 'M004', 'CAT08', '海尔节能变频空调 大1匹', 2799.00),
('G010', 'M005', 'CAT05', '比亚迪智能手表 车钥匙版', 1599.00),
('G011', 'M006', 'CAT04', '联想 ThinkPad X1 Carbon 商务笔记本 16GB+512GB', 9999.00),
('G012', 'M007', 'CAT01', '大疆 Mini 4 Pro 无人机 带屏遥控版', 4788.00);

-- ============================================================
-- 6. goods_image 商品图片
-- ============================================================
DROP TABLE IF EXISTS `goods_image`;
CREATE TABLE `goods_image` (
  `image_id` varchar(20) NOT NULL,
  `goods_code` varchar(20) NOT NULL,
  `image_url` varchar(255) NOT NULL,
  `is_cover` tinyint(1) DEFAULT 0,
  `sort_order` int DEFAULT 0,
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`image_id`),
  KEY `idx_goods` (`goods_code`),
  CONSTRAINT `fk_image_goods` FOREIGN KEY (`goods_code`) REFERENCES `goods` (`goods_code`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `goods_image` VALUES
('IMG001','G001','/images/goods/G001_cover.jpg',1,1,NOW()),
('IMG002','G001','/images/goods/G001_detail1.jpg',0,2,NOW()),
('IMG003','G002','/images/goods/G002_cover.jpg',1,1,NOW()),
('IMG004','G003','/images/goods/G003_cover.jpg',1,1,NOW()),
('IMG005','G004','/images/goods/G004_cover.jpg',1,1,NOW()),
('IMG006','G005','/images/goods/G005_cover.jpg',1,1,NOW()),
('IMG007','G006','/images/goods/G006_cover.jpg',1,1,NOW()),
('IMG008','G007','/images/goods/G007_cover.jpg',1,1,NOW()),
('IMG009','G008','/images/goods/G008_cover.jpg',1,1,NOW()),
('IMG010','G009','/images/goods/G009_cover.jpg',1,1,NOW()),
('IMG011','G010','/images/goods/G010_cover.jpg',1,1,NOW()),
('IMG012','G011','/images/goods/G011_cover.jpg',1,1,NOW()),
('IMG013','G012','/images/goods/G012_cover.jpg',1,1,NOW());

-- ============================================================
-- 7. goods_review 商品评论
-- ============================================================
DROP TABLE IF EXISTS `goods_review`;
CREATE TABLE `goods_review` (
  `review_code` varchar(20) NOT NULL,
  `user_id` int NOT NULL,
  `goods_code` varchar(20) NOT NULL,
  `review` varchar(255) DEFAULT NULL,
  `review_rating` tinyint DEFAULT NULL,
  `review_time` datetime NOT NULL,
  PRIMARY KEY (`review_code`),
  KEY `idx_user` (`user_id`),
  KEY `idx_goods` (`goods_code`),
  CONSTRAINT `fk_review_user` FOREIGN KEY (`user_id`) REFERENCES `usermessage` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_review_goods` FOREIGN KEY (`goods_code`) REFERENCES `goods` (`goods_code`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `goods_review` VALUES
('GR001',4,'G001','手机非常好用，拍照效果一流，电池续航也不错！',5,'2024-01-10 15:00:00'),
('GR002',4,'G004','手环做工精致，佩戴舒适，功能齐全，价格实惠。',5,'2024-01-10 15:05:00'),
('GR003',5,'G006','空调制冷效果很好，噪音小，安装师傅也很专业。',4,'2024-01-11 09:00:00'),
('GR004',6,'G011','笔记本轻薄便携，性能强劲，但屏幕有点反光。',4,'2024-01-12 10:30:00'),
('GR005',6,'G012','无人机航拍效果超棒，操作简单，稳定性好！',5,'2024-01-12 10:35:00'),
('GR006',8,'G006','性价比很高，制冷速度很快，就是遥控器操作不太方便。',3,'2024-01-14 14:20:00'),
('GR007',8,'G007','电磁炉加热快，外观时尚，触控灵敏。',5,'2024-01-14 14:25:00'),
('GR008',10,'G003','小米手机性价比真的高，徕卡拍照很喜欢！',5,'2024-01-15 11:00:00'),
('GR009',11,'G009','空调安装及时，用了几天感觉不错，节能省电。',4,'2024-01-16 16:00:00'),
('GR010',11,'G005','电饭煲煮饭很香，内胆不粘，清洗方便。',5,'2024-01-16 16:10:00'),
('GR011',6,'G001','第二次购买了，送给父母，他们很喜欢。',5,'2024-01-18 08:30:00'),
('GR012',7,'G012','之前犹豫了很久，买了之后非常满意，超出预期！',5,'2024-01-19 19:00:00');

-- ============================================================
-- 8. cart 购物车
-- ============================================================
DROP TABLE IF EXISTS `cart`;
CREATE TABLE `cart` (
  `cart_code` varchar(20) NOT NULL,
  `user_id` int NOT NULL,
  `goods_code` varchar(20) NOT NULL,
  `quantity` int NOT NULL,
  `unit_price` decimal(10,2) NOT NULL,
  `total_price` decimal(10,2) DEFAULT NULL,
  `add_time` datetime NOT NULL,
  PRIMARY KEY (`cart_code`),
  KEY `idx_user` (`user_id`),
  KEY `idx_goods` (`goods_code`),
  CONSTRAINT `fk_cart_goods` FOREIGN KEY (`goods_code`) REFERENCES `goods` (`goods_code`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `cart` VALUES
('CART001',4,'G003',1,5999.00,5999.00,'2024-01-15 09:30:00'),
('CART002',5,'G005',2,349.00,698.00,'2024-01-15 10:00:00'),
('CART003',6,'G010',1,1599.00,1599.00,'2024-01-15 11:20:00'),
('CART004',8,'G002',1,8999.00,8999.00,'2024-01-15 14:00:00'),
('CART005',9,'G004',3,399.00,1197.00,'2024-01-15 15:45:00'),
('CART006',4,'G012',1,4788.00,4788.00,'2024-01-15 16:10:00');

SET FOREIGN_KEY_CHECKS = 1;
