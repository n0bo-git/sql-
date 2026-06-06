/*
 Navicat Premium Dump SQL

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 80046 (8.0.46)
 Source Host           : localhost:3306
 Source Schema         : demo

 Date: 06/06/2026 优化版
 改动：
   userlogin.role → TINYINT (0=管理员 1=商家 2=普通用户)
   usermessage.user_id 作为主键，与 userlogin.id 一一对应
   所有外键统一指向 usermessage.user_id
   旧 customer/user 表已删除
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ============================================================
-- 1. userlogin 用户登录表
-- ============================================================
DROP TABLE IF EXISTS `userlogin`;
CREATE TABLE `userlogin` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '用户编号',
  `username` varchar(255) NOT NULL COMMENT '登录账号',
  `password` varchar(255) NOT NULL COMMENT '登录密码',
  `role` tinyint NOT NULL DEFAULT 2 COMMENT '身份：0=管理员 1=商家 2=普通用户',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COMMENT='用户登录表';

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
-- 2. usermessage 用户详细信息表
-- ============================================================
DROP TABLE IF EXISTS `usermessage`;
CREATE TABLE `usermessage` (
  `user_id` int NOT NULL COMMENT '用户编号（=userlogin.id）',
  `name` varchar(50) NOT NULL COMMENT '姓名',
  `phone` varchar(20) DEFAULT NULL COMMENT '电话',
  `email` varchar(50) DEFAULT NULL COMMENT '邮箱',
  `address` varchar(200) DEFAULT NULL COMMENT '地址',
  `postcode` varchar(10) DEFAULT NULL COMMENT '邮编',
  `balance` int DEFAULT 0 COMMENT '余额（分）',
  `avatar` varchar(255) DEFAULT NULL COMMENT '头像',
  `sex` varchar(10) DEFAULT NULL COMMENT '性别',
  `age` int DEFAULT NULL COMMENT '年龄',
  `infos` varchar(255) DEFAULT NULL COMMENT '简介',
  PRIMARY KEY (`user_id`),
  CONSTRAINT `fk_um_userlogin` FOREIGN KEY (`user_id`) REFERENCES `userlogin` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户详细信息表';

INSERT INTO `usermessage` VALUES
(1, '管理员', '13677889988', 'admin@xxx.com', '江苏南京', NULL, 0, '/avatar/admin.jpg', '男', 27, '我是管理员'),
(2, '汤姆', '13988776699', 'jerry@qq.com', '北京', NULL, 0, '/avatar/tom.jpg', '男', 24, '普通用户'),
(3, '杰瑞', '15098765321', 'tom@qq.com', '上海', NULL, 0, '/avatar/jerry.jpg', '男', 25, '普通用户'),
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
  `category_id` varchar(20) NOT NULL COMMENT '分类编号',
  `category_name` varchar(50) NOT NULL COMMENT '分类名称',
  `parent_id` varchar(20) DEFAULT NULL COMMENT '父分类编号',
  `sort_order` int DEFAULT 0 COMMENT '排序号',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`category_id`),
  KEY `idx_parent` (`parent_id`),
  CONSTRAINT `fk_category_parent` FOREIGN KEY (`parent_id`) REFERENCES `goods_category` (`category_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='商品分类表';

INSERT INTO `goods_category` VALUES
('CAT01', '电子产品', NULL, 1, '2026-06-05 14:58:42'),
('CAT02', '家用电器', NULL, 2, '2026-06-05 14:58:42'),
('CAT03', '手机通讯', 'CAT01', 1, '2026-06-05 14:58:42'),
('CAT04', '电脑办公', 'CAT01', 2, '2026-06-05 14:58:42'),
('CAT05', '智能穿戴', 'CAT01', 3, '2026-06-05 14:58:42'),
('CAT06', '厨房电器', 'CAT02', 1, '2026-06-05 14:58:42'),
('CAT07', '生活电器', 'CAT02', 2, '2026-06-05 14:58:42'),
('CAT08', '空调', 'CAT02', 3, '2026-06-05 14:58:42');

-- ============================================================
-- 4. manufacturer 厂家
-- ============================================================
DROP TABLE IF EXISTS `manufacturer`;
CREATE TABLE `manufacturer` (
  `manu_code` varchar(20) NOT NULL COMMENT '厂家编码',
  `manu_name` varchar(50) NOT NULL COMMENT '厂家名称',
  `manu_phone` varchar(20) NOT NULL COMMENT '厂家电话',
  PRIMARY KEY (`manu_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='厂家表';

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
  `goods_code` varchar(20) NOT NULL COMMENT '商品编码',
  `manu_code` varchar(20) NOT NULL COMMENT '厂家编码',
  `category_id` varchar(20) DEFAULT NULL COMMENT '分类编号',
  `goods_desc` varchar(200) DEFAULT NULL COMMENT '商品描述',
  `unit_price` decimal(10,2) NOT NULL COMMENT '单价',
  PRIMARY KEY (`goods_code`, `manu_code`),
  KEY `idx_manu` (`manu_code`),
  KEY `idx_category` (`category_id`),
  CONSTRAINT `fk_goods_category` FOREIGN KEY (`category_id`) REFERENCES `goods_category` (`category_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_goods_manufacturer` FOREIGN KEY (`manu_code`) REFERENCES `manufacturer` (`manu_code`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='商品表';

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
  `image_id` varchar(20) NOT NULL COMMENT '图片编号',
  `goods_code` varchar(20) NOT NULL COMMENT '商品编号',
  `image_url` varchar(255) NOT NULL COMMENT '图片地址',
  `is_cover` tinyint(1) DEFAULT 0 COMMENT '是否封面 1=是 0=否',
  `sort_order` int DEFAULT 0 COMMENT '排序号',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`image_id`),
  KEY `idx_goods` (`goods_code`),
  CONSTRAINT `fk_image_goods` FOREIGN KEY (`goods_code`) REFERENCES `goods` (`goods_code`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='商品图片表';

INSERT INTO `goods_image` VALUES
('IMG001', 'G001', '/images/goods/G001_cover.jpg', 1, 1, '2026-06-05 14:58:42'),
('IMG002', 'G001', '/images/goods/G001_detail1.jpg', 0, 2, '2026-06-05 14:58:42'),
('IMG003', 'G002', '/images/goods/G002_cover.jpg', 1, 1, '2026-06-05 14:58:42'),
('IMG004', 'G003', '/images/goods/G003_cover.jpg', 1, 1, '2026-06-05 14:58:42'),
('IMG005', 'G004', '/images/goods/G004_cover.jpg', 1, 1, '2026-06-05 14:58:42'),
('IMG006', 'G005', '/images/goods/G005_cover.jpg', 1, 1, '2026-06-05 14:58:42'),
('IMG007', 'G006', '/images/goods/G006_cover.jpg', 1, 1, '2026-06-05 14:58:42'),
('IMG008', 'G007', '/images/goods/G007_cover.jpg', 1, 1, '2026-06-05 14:58:42'),
('IMG009', 'G008', '/images/goods/G008_cover.jpg', 1, 1, '2026-06-05 14:58:42'),
('IMG010', 'G009', '/images/goods/G009_cover.jpg', 1, 1, '2026-06-05 14:58:42'),
('IMG011', 'G010', '/images/goods/G010_cover.jpg', 1, 1, '2026-06-05 14:58:42'),
('IMG012', 'G011', '/images/goods/G011_cover.jpg', 1, 1, '2026-06-05 14:58:42'),
('IMG013', 'G012', '/images/goods/G012_cover.jpg', 1, 1, '2026-06-05 14:58:42');

-- ============================================================
-- 7. goods_review 商品评论
-- ============================================================
DROP TABLE IF EXISTS `goods_review`;
CREATE TABLE `goods_review` (
  `review_code` varchar(20) NOT NULL COMMENT '评论编码',
  `user_id` int NOT NULL COMMENT '评论用户编号',
  `goods_code` varchar(20) NOT NULL COMMENT '商品编号',
  `review` varchar(255) DEFAULT NULL COMMENT '评论内容',
  `review_rating` tinyint DEFAULT NULL COMMENT '评分 1-5星',
  `review_time` datetime NOT NULL COMMENT '评论时间',
  PRIMARY KEY (`review_code`),
  KEY `idx_user` (`user_id`),
  KEY `idx_goods` (`goods_code`),
  CONSTRAINT `fk_review_user` FOREIGN KEY (`user_id`) REFERENCES `usermessage` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_review_goods` FOREIGN KEY (`goods_code`) REFERENCES `goods` (`goods_code`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='商品评论表';

INSERT INTO `goods_review` VALUES
('GR001', 4, 'G001', '手机非常好用，拍照效果一流，电池续航也不错！', 5, '2024-01-10 15:00:00'),
('GR002', 4, 'G004', '手环做工精致，佩戴舒适，功能齐全，价格实惠。', 5, '2024-01-10 15:05:00'),
('GR003', 5, 'G006', '空调制冷效果很好，噪音小，安装师傅也很专业。', 4, '2024-01-11 09:00:00'),
('GR004', 6, 'G011', '笔记本轻薄便携，性能强劲，但屏幕有点反光。', 4, '2024-01-12 10:30:00'),
('GR005', 6, 'G012', '无人机航拍效果超棒，操作简单，稳定性好！', 5, '2024-01-12 10:35:00'),
('GR006', 8, 'G006', '性价比很高，制冷速度很快，就是遥控器操作不太方便。', 3, '2024-01-14 14:20:00'),
('GR007', 8, 'G007', '电磁炉加热快，外观时尚，触控灵敏。', 5, '2024-01-14 14:25:00'),
('GR008', 10, 'G003', '小米手机性价比真的高，徕卡拍照很喜欢！', 5, '2024-01-15 11:00:00'),
('GR009', 11, 'G009', '空调安装及时，用了几天感觉不错，节能省电。', 4, '2024-01-16 16:00:00'),
('GR010', 11, 'G005', '电饭煲煮饭很香，内胆不粘，清洗方便。', 5, '2024-01-16 16:10:00'),
('GR011', 6, 'G001', '第二次购买了，送给父母，他们很喜欢。', 5, '2024-01-18 08:30:00'),
('GR012', 7, 'G012', '之前犹豫了很久，买了之后非常满意，超出预期！', 5, '2024-01-19 19:00:00');

-- ============================================================
-- 8. cart 购物车
-- ============================================================
DROP TABLE IF EXISTS `cart`;
CREATE TABLE `cart` (
  `cart_code` varchar(20) NOT NULL COMMENT '购物车编码',
  `user_id` int NOT NULL COMMENT '用户编号',
  `goods_code` varchar(20) NOT NULL COMMENT '商品编号',
  `quantity` int NOT NULL COMMENT '数量',
  `unit_price` decimal(10,2) NOT NULL COMMENT '单价',
  `total_price` decimal(10,2) DEFAULT NULL COMMENT '小计',
  `add_time` datetime NOT NULL COMMENT '添加时间',
  PRIMARY KEY (`cart_code`),
  KEY `idx_user` (`user_id`),
  KEY `idx_goods` (`goods_code`),
  CONSTRAINT `fk_cart_user` FOREIGN KEY (`user_id`) REFERENCES `usermessage` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_cart_goods` FOREIGN KEY (`goods_code`) REFERENCES `goods` (`goods_code`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='购物车表';

INSERT INTO `cart` VALUES
('CART001', 4, 'G003', 1, 5999.00, 5999.00, '2024-01-15 09:30:00'),
('CART002', 5, 'G005', 2, 349.00, 698.00, '2024-01-15 10:00:00'),
('CART003', 6, 'G010', 1, 1599.00, 1599.00, '2024-01-15 11:20:00'),
('CART004', 8, 'G002', 1, 8999.00, 8999.00, '2024-01-15 14:00:00'),
('CART005', 9, 'G004', 3, 399.00, 1197.00, '2024-01-15 15:45:00'),
('CART006', 4, 'G012', 1, 4788.00, 4788.00, '2024-01-15 16:10:00');

-- ============================================================
-- 9. supplier 供应商
-- ============================================================
DROP TABLE IF EXISTS `supplier`;
CREATE TABLE `supplier` (
  `supplier_code` varchar(20) NOT NULL COMMENT '供应商编号',
  `supplier_name` varchar(100) NOT NULL COMMENT '供应商名称',
  `contact_person` varchar(30) DEFAULT NULL COMMENT '联系人',
  `contact_phone` varchar(20) DEFAULT NULL COMMENT '联系电话',
  `contact_email` varchar(50) DEFAULT NULL COMMENT '联系邮箱',
  `address` varchar(200) DEFAULT NULL COMMENT '地址',
  `bank_account` varchar(30) DEFAULT NULL COMMENT '银行账号',
  `bank_name` varchar(100) DEFAULT NULL COMMENT '开户银行',
  `tax_id` varchar(30) DEFAULT NULL COMMENT '税号',
  `supply_category` varchar(50) DEFAULT NULL COMMENT '供应类别',
  `cooperation_status` tinyint(1) DEFAULT 1 COMMENT '合作状态 1=合作中 0=已终止',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`supplier_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='供应商表';

INSERT INTO `supplier` VALUES
('S001', '深圳华强电子供应链有限公司', '王建国', '0755-82345678', 'wangjg@hq-sc.com', '深圳市福田区华强北路1002号', '6222024000012345678', '中国工商银行深圳分行', '91440300123456789A', '电子元器件', 1, '长期合作供应商', '2026-06-05 14:58:42', NULL),
('S002', '上海通达物流设备有限公司', '李明辉', '021-58765432', 'limh@td-logi.com', '上海市嘉定区安亭镇博园路668号', '6228480030012345678', '中国农业银行上海分行', '91310114001234567B', '物流设备', 1, NULL, '2026-06-05 14:58:42', NULL),
('S003', '广州鑫源包装材料有限公司', '陈志强', '020-85678901', 'chenzq@xy-pack.com', '广州市白云区人和镇凤和工业区', '6221880100012345678', '中国建设银行广州分行', '91440101001234567C', '包装材料', 1, '优先供应商', '2026-06-05 14:58:42', NULL),
('S004', '北京中科创新科技有限公司', '张伟', '010-62578901', 'zhangw@zktech.cn', '北京市海淀区中关村南大街12号', '6227000012345678901', '中国银行北京分行', '91110108009876543D', '芯片/半导体', 1, '2024年新引入', '2026-06-05 14:58:42', NULL),
('S005', '杭州恒达五金制品有限公司', '赵永刚', '0571-85234123', 'zhaoyg@hd-wujin.com', '杭州市余杭区良渚工业园', '6234560100012345678', '交通银行杭州分行', '91330110002345678E', '五金配件', 0, '合同到期未续签', '2026-06-05 14:58:42', NULL),
('S006', '成都盈科物流服务有限公司', '孙海燕', '028-85123678', 'sunhy@yk-wuliu.com', '成都市双流区航空港物流园', '6217000100012345678', '招商银行成都分行', '91510122003456789F', '物流运输', 1, NULL, '2026-06-05 14:58:42', NULL);

-- ============================================================
-- 10. goods_supply 商品供应关系
-- ============================================================
DROP TABLE IF EXISTS `goods_supply`;
CREATE TABLE `goods_supply` (
  `goods_code` varchar(20) NOT NULL COMMENT '商品编号',
  `supplier_code` varchar(20) NOT NULL COMMENT '供应商编号',
  `supply_price` decimal(10,2) DEFAULT NULL COMMENT '供应单价',
  `min_quantity` int DEFAULT 1 COMMENT '最小起订量',
  `lead_days` int DEFAULT NULL COMMENT '供货周期(天)',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`goods_code`, `supplier_code`),
  KEY `idx_supplier` (`supplier_code`),
  CONSTRAINT `fk_gs_goods` FOREIGN KEY (`goods_code`) REFERENCES `goods` (`goods_code`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_gs_supplier` FOREIGN KEY (`supplier_code`) REFERENCES `supplier` (`supplier_code`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='商品供应关系表';

INSERT INTO `goods_supply` VALUES
('G001', 'S001', 5800.00, 10, 7, '2026-06-05 14:58:42'),
('G001', 'S004', 5900.00, 5, 5, '2026-06-05 14:58:42'),
('G002', 'S001', 7500.00, 5, 10, '2026-06-05 14:58:42'),
('G003', 'S001', 4900.00, 10, 7, '2026-06-05 14:58:42'),
('G004', 'S005', 280.00, 50, 3, '2026-06-05 14:58:42'),
('G005', 'S005', 260.00, 30, 3, '2026-06-05 14:58:42'),
('G006', 'S003', 3100.00, 5, 5, '2026-06-05 14:58:42'),
('G007', 'S005', 190.00, 20, 2, '2026-06-05 14:58:42'),
('G008', 'S003', 3600.00, 3, 7, '2026-06-05 14:58:42'),
('G009', 'S003', 2300.00, 5, 5, '2026-06-05 14:58:42'),
('G010', 'S004', 1200.00, 10, 10, '2026-06-05 14:58:42'),
('G011', 'S001', 8200.00, 3, 8, '2026-06-05 14:58:42'),
('G012', 'S004', 4000.00, 5, 6, '2026-06-05 14:58:42');

-- ============================================================
-- 11. inventory 库存
-- ============================================================
DROP TABLE IF EXISTS `inventory`;
CREATE TABLE `inventory` (
  `inventory_id` varchar(20) NOT NULL COMMENT '库存编号',
  `goods_code` varchar(20) NOT NULL COMMENT '商品编号',
  `warehouse_code` varchar(20) DEFAULT NULL COMMENT '仓库编号',
  `stock_quantity` int NOT NULL DEFAULT 0 COMMENT '库存数量',
  `locked_quantity` int DEFAULT 0 COMMENT '锁定数量(已下单未发货)',
  `alert_quantity` int DEFAULT 10 COMMENT '预警库存量',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`inventory_id`),
  UNIQUE KEY `uk_goods_warehouse` (`goods_code`, `warehouse_code`),
  CONSTRAINT `fk_inv_goods` FOREIGN KEY (`goods_code`) REFERENCES `goods` (`goods_code`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='库存表';

INSERT INTO `inventory` VALUES
('INV001', 'G001', 'WH-北京', 50, 2, 10, NULL),
('INV002', 'G001', 'WH-深圳', 100, 5, 20, NULL),
('INV003', 'G002', 'WH-深圳', 30, 1, 5, NULL),
('INV004', 'G003', 'WH-北京', 80, 1, 15, NULL),
('INV005', 'G004', 'WH-北京', 200, 5, 30, NULL),
('INV006', 'G005', 'WH-上海', 150, 2, 20, NULL),
('INV007', 'G006', 'WH-上海', 25, 3, 5, NULL),
('INV008', 'G007', 'WH-广州', 100, 2, 15, NULL),
('INV009', 'G008', 'WH-广州', 15, 1, 5, NULL),
('INV010', 'G009', 'WH-上海', 40, 2, 8, NULL),
('INV011', 'G010', 'WH-深圳', 60, 1, 10, NULL),
('INV012', 'G011', 'WH-北京', 20, 1, 3, NULL),
('INV013', 'G012', 'WH-深圳', 35, 2, 8, NULL);

-- ============================================================
-- 12. order_main 订单主表
-- ============================================================
DROP TABLE IF EXISTS `order_main`;
CREATE TABLE `order_main` (
  `order_id` varchar(30) NOT NULL COMMENT '订单号',
  `user_id` int NOT NULL COMMENT '用户编号',
  `order_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '下单日期',
  `transport_req` varchar(100) DEFAULT NULL COMMENT '运输要求',
  `supply_flag` tinyint(1) NOT NULL DEFAULT 1 COMMENT '能否供货 1=能 0=否',
  `transport_date` date DEFAULT NULL COMMENT '运输日期',
  `goods_weight` decimal(8,2) DEFAULT NULL COMMENT '货物重量',
  `freight` decimal(10,2) DEFAULT NULL COMMENT '运费',
  `pay_list` varchar(200) DEFAULT NULL COMMENT '付款清单',
  PRIMARY KEY (`order_id`, `user_id`),
  KEY `idx_user` (`user_id`),
  CONSTRAINT `fk_order_user` FOREIGN KEY (`user_id`) REFERENCES `usermessage` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='订单主表';

INSERT INTO `order_main` VALUES
('ORD20240101001', 4, '2024-01-01 10:30:00', '送货上门', 1, '2024-01-03', 2.50, 15.00, '已付'),
('ORD20240102001', 5, '2024-01-02 14:20:00', '快递', 1, '2024-01-04', 1.80, 10.00, '已付'),
('ORD20240103001', 6, '2024-01-03 09:15:00', '工作日配送', 1, '2024-01-05', 5.00, 25.00, '已付'),
('ORD20240104001', 4, '2024-01-04 16:45:00', '送货上门', 1, '2024-01-06', 3.20, 18.00, '已付'),
('ORD20240105001', 8, '2024-01-05 11:00:00', '周末配送', 1, '2024-01-07', 8.00, 35.00, '已付'),
('ORD20240106001', 7, '2024-01-06 20:30:00', '送货上门', 0, NULL, 0.00, 0.00, '未付'),
('ORD20240107001', 9, '2024-01-07 08:00:00', '快递', 1, '2024-01-09', 4.50, 20.00, '已付'),
('ORD20240108001', 10, '2024-01-08 13:10:00', '送货上门 轻拿轻放', 1, '2024-01-10', 2.00, 12.00, '已付'),
('ORD20240109001', 11, '2024-01-09 17:00:00', '快递', 1, '2024-01-11', 6.30, 30.00, '部分付'),
('ORD20240110001', 5, '2024-01-10 10:00:00', '送货上门', 1, '2024-01-12', 1.20, 8.00, '已付'),
('ORD20240111001', 6, '2024-01-11 15:30:00', '周末配送', 1, '2024-01-13', 3.80, 22.00, '已付'),
('ORD20240112001', 7, '2024-01-12 12:00:00', '送货上门', 1, '2024-01-14', 7.50, 32.00, '已付');

-- ============================================================
-- 13. order_detail 订单明细
-- ============================================================
DROP TABLE IF EXISTS `order_detail`;
CREATE TABLE `order_detail` (
  `detail_id` varchar(30) NOT NULL COMMENT '明细编号',
  `order_id` varchar(30) NOT NULL COMMENT '订单编号',
  `goods_code` varchar(20) NOT NULL COMMENT '商品编号',
  `quantity` int NOT NULL COMMENT '数量',
  `unit_price` decimal(10,2) NOT NULL COMMENT '单价',
  `total_price` decimal(10,2) NOT NULL COMMENT '小计',
  `discount` decimal(10,2) DEFAULT 0.00 COMMENT '折扣金额',
  PRIMARY KEY (`detail_id`),
  KEY `idx_order` (`order_id`),
  KEY `idx_goods` (`goods_code`),
  CONSTRAINT `fk_od_goods` FOREIGN KEY (`goods_code`) REFERENCES `goods` (`goods_code`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='订单明细表';

INSERT INTO `order_detail` VALUES
('DET001', 'ORD20240101001', 'G001', 1, 6999.00, 6999.00, 0.00),
('DET002', 'ORD20240101001', 'G004', 2, 399.00, 798.00, 0.00),
('DET003', 'ORD20240102001', 'G006', 1, 3699.00, 3699.00, 100.00),
('DET004', 'ORD20240103001', 'G011', 1, 9999.00, 9999.00, 500.00),
('DET005', 'ORD20240103001', 'G012', 1, 4788.00, 4788.00, 0.00),
('DET006', 'ORD20240104001', 'G008', 1, 4299.00, 4299.00, 0.00),
('DET007', 'ORD20240105001', 'G006', 2, 3699.00, 7398.00, 200.00),
('DET008', 'ORD20240105001', 'G007', 1, 259.00, 259.00, 0.00),
('DET009', 'ORD20240106001', 'G010', 1, 1599.00, 1599.00, 0.00),
('DET010', 'ORD20240107001', 'G002', 1, 8999.00, 8999.00, 300.00),
('DET011', 'ORD20240108001', 'G003', 1, 5999.00, 5999.00, 0.00),
('DET012', 'ORD20240109001', 'G009', 2, 2799.00, 5598.00, 0.00),
('DET013', 'ORD20240109001', 'G005', 1, 349.00, 349.00, 0.00),
('DET014', 'ORD20240110001', 'G007', 1, 259.00, 259.00, 0.00),
('DET015', 'ORD20240111001', 'G001', 1, 6999.00, 6999.00, 200.00),
('DET016', 'ORD20240112001', 'G012', 1, 4788.00, 4788.00, 0.00),
('DET017', 'ORD20240112001', 'G004', 3, 399.00, 1197.00, 50.00);

-- ============================================================
-- 14. payment 支付记录
-- ============================================================
DROP TABLE IF EXISTS `payment`;
CREATE TABLE `payment` (
  `payment_id` varchar(30) NOT NULL COMMENT '支付编号',
  `order_id` varchar(30) NOT NULL COMMENT '订单编号',
  `user_id` int NOT NULL COMMENT '支付用户编号',
  `payment_method` varchar(20) NOT NULL COMMENT '支付方式 alipay/wechat/bank/card/balance',
  `payment_amount` decimal(10,2) NOT NULL COMMENT '支付金额',
  `payment_status` tinyint(1) DEFAULT 0 COMMENT '支付状态 0=待付 1=成功 2=失败 3=已退款',
  `transaction_id` varchar(50) DEFAULT NULL COMMENT '第三方交易流水号',
  `payment_time` datetime DEFAULT NULL COMMENT '支付时间',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`payment_id`),
  KEY `idx_order` (`order_id`),
  KEY `idx_user` (`user_id`),
  CONSTRAINT `fk_pay_user` FOREIGN KEY (`user_id`) REFERENCES `usermessage` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='支付记录表';

INSERT INTO `payment` VALUES
('PAY001', 'ORD20240101001', 4, 'alipay', 7797.00, 1, 'ALI20240101103000', '2024-01-01 10:31:00', '2026-06-05 14:58:42'),
('PAY002', 'ORD20240102001', 5, 'wechat', 3599.00, 1, 'WX20240102142100', '2024-01-02 14:21:00', '2026-06-05 14:58:42'),
('PAY003', 'ORD20240103001', 6, 'bank', 14287.00, 1, 'BANK20240103091600', '2024-01-03 09:16:00', '2026-06-05 14:58:42'),
('PAY004', 'ORD20240104001', 4, 'alipay', 4299.00, 1, 'ALI20240104164600', '2024-01-04 16:46:00', '2026-06-05 14:58:42'),
('PAY005', 'ORD20240105001', 8, 'balance', 7457.00, 1, NULL, '2024-01-05 11:01:00', '2026-06-05 14:58:42'),
('PAY006', 'ORD20240107001', 9, 'wechat', 8699.00, 1, 'WX20240107080100', '2024-01-07 08:01:00', '2026-06-05 14:58:42'),
('PAY007', 'ORD20240108001', 10, 'alipay', 5999.00, 1, 'ALI20240108131100', '2024-01-08 13:11:00', '2026-06-05 14:58:42'),
('PAY008', 'ORD20240109001', 11, 'card', 5947.00, 2, NULL, NULL, '2026-06-05 14:58:42'),
('PAY009', 'ORD20240109001', 11, 'alipay', 5947.00, 1, 'ALI20240109170200', '2024-01-09 17:02:00', '2026-06-05 14:58:42'),
('PAY010', 'ORD20240110001', 5, 'wechat', 259.00, 1, 'WX20240110100100', '2024-01-10 10:01:00', '2026-06-05 14:58:42'),
('PAY011', 'ORD20240111001', 6, 'bank', 6799.00, 1, 'BANK20240111153100', '2024-01-11 15:31:00', '2026-06-05 14:58:42'),
('PAY012', 'ORD20240112001', 7, 'alipay', 5935.00, 1, 'ALI20240112120100', '2024-01-12 12:01:00', '2026-06-05 14:58:42'),
('PAY013', 'ORD20240106001', 7, 'alipay', 1599.00, 0, NULL, NULL, '2026-06-05 14:58:42');

-- ============================================================
-- 15. shipping_address 收货地址
-- ============================================================
DROP TABLE IF EXISTS `shipping_address`;
CREATE TABLE `shipping_address` (
  `address_id` varchar(20) NOT NULL COMMENT '地址编号',
  `user_id` int NOT NULL COMMENT '用户编号',
  `receiver_name` varchar(30) NOT NULL COMMENT '收货人姓名',
  `receiver_phone` varchar(20) NOT NULL COMMENT '收货人电话',
  `province` varchar(30) DEFAULT NULL COMMENT '省',
  `city` varchar(30) DEFAULT NULL COMMENT '市',
  `district` varchar(30) DEFAULT NULL COMMENT '区',
  `detail_address` varchar(200) NOT NULL COMMENT '详细地址',
  `postcode` varchar(10) DEFAULT NULL COMMENT '邮编',
  `is_default` tinyint(1) DEFAULT 0 COMMENT '是否默认 1=是 0=否',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`address_id`),
  KEY `idx_user` (`user_id`),
  CONSTRAINT `fk_addr_user` FOREIGN KEY (`user_id`) REFERENCES `usermessage` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='收货地址表';

INSERT INTO `shipping_address` VALUES
('ADDR001', 4, '张三', '13800138001', '北京市', '北京市', '朝阳区', '建国路88号SOHO现代城A座1205', '100020', 1, '2026-06-05 14:58:42'),
('ADDR002', 4, '张太太', '13900139099', '北京市', '北京市', '海淀区', '中关村东路1号清华科技园B座808', '100084', 0, '2026-06-05 14:58:42'),
('ADDR003', 5, '李四', '13900139002', '上海市', '上海市', '浦东新区', '张江路168号盛大网络园区3号楼', '200120', 1, '2026-06-05 14:58:42'),
('ADDR004', 6, '王五', '13700137003', '广东省', '广州市', '天河区', '体育西路55号天河城广场', '510620', 1, '2026-06-05 14:58:42'),
('ADDR005', 7, '赵六', '13600136004', '广东省', '深圳市', '南山区', '科技园路12号腾讯滨海大厦', '518057', 1, '2026-06-05 14:58:42'),
('ADDR006', 8, '陈小红', '13500135005', '浙江省', '杭州市', '西湖区', '文三路200号支付宝大楼', '310012', 1, '2026-06-05 14:58:42'),
('ADDR007', 9, '刘强', '13400134006', '四川省', '成都市', '武侯区', '人民南路33号天府软件园', '610041', 1, '2026-06-05 14:58:42'),
('ADDR008', 10, '周美玲', '13300133007', '江苏省', '南京市', '鼓楼区', '中山北路18号紫峰大厦', '210008', 1, '2026-06-05 14:58:42'),
('ADDR009', 11, '吴大伟', '13200132008', '湖北省', '武汉市', '洪山区', '珞喻路77号光谷广场', '430070', 1, '2026-06-05 14:58:42');

-- ============================================================
-- 16. merchant_review 商家评价
-- ============================================================
DROP TABLE IF EXISTS `merchant_review`;
CREATE TABLE `merchant_review` (
  `review_id` varchar(20) NOT NULL COMMENT '评价编号',
  `user_id` int NOT NULL COMMENT '用户编号',
  `target_type` varchar(20) NOT NULL COMMENT '对象类型 manufacturer/supplier',
  `target_code` varchar(20) NOT NULL COMMENT '对象编号',
  `rating` tinyint NOT NULL COMMENT '评分 1-5星',
  `review_content` varchar(500) DEFAULT NULL COMMENT '评价内容',
  `reply_content` varchar(500) DEFAULT NULL COMMENT '商家回复',
  `reply_time` datetime DEFAULT NULL COMMENT '回复时间',
  `is_anonymous` tinyint(1) DEFAULT 0 COMMENT '是否匿名 1=是 0=否',
  `review_status` tinyint(1) DEFAULT 1 COMMENT '审核状态 1=通过 0=待审',
  `review_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '评价时间',
  PRIMARY KEY (`review_id`),
  KEY `idx_target` (`target_type`, `target_code`),
  KEY `idx_user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='商家评价表';

INSERT INTO `merchant_review` VALUES
('MR001', 4, 'manufacturer', 'M001', 5, '华为的产品质量一直很好，售后也很到位！', '感谢您的支持与信赖，我们会继续努力！', '2024-01-11 10:00:00', 0, 1, '2024-01-10 16:00:00'),
('MR002', 5, 'manufacturer', 'M003', 4, '格力空调用了这么多年，质量可靠。', '谢谢您的建议，我们将持续优化产品性价比。', '2024-01-12 14:00:00', 0, 1, '2024-01-11 09:30:00'),
('MR003', 6, 'manufacturer', 'M006', 3, '联想笔记本还行，但这次买的有轻微亮点。', '非常抱歉给您带来不便，我们已安排专人跟进处理。', '2024-01-13 16:00:00', 0, 1, '2024-01-12 11:00:00'),
('MR004', 6, 'manufacturer', 'M007', 5, '大疆无人机确实牛，技术全球领先！', NULL, NULL, 0, 1, '2024-01-12 11:10:00'),
('MR005', 8, 'manufacturer', 'M003', 4, '格力的产品总体满意，安装服务可以再快一点。', '感谢您的反馈，我们已优化安装调度系统。', '2024-01-15 09:00:00', 0, 1, '2024-01-14 15:00:00'),
('MR006', 8, 'supplier', 'S003', 5, '广州鑫源的包装材料质量很好，物流快！', '谢谢支持，期待与您继续合作！', '2024-01-15 10:00:00', 0, 1, '2024-01-14 15:30:00'),
('MR007', 9, 'manufacturer', 'M001', 5, '华为笔记本办公用非常流畅，颜值也高。', '非常感谢您的好评！', '2024-01-16 11:00:00', 0, 1, '2024-01-15 10:00:00'),
('MR008', 10, 'manufacturer', 'M002', 4, '小米性价比没得说，希望品控能再加强。', '感谢您的建议，我们一直在努力提升品质。', '2024-01-17 14:00:00', 0, 1, '2024-01-15 12:00:00'),
('MR009', 11, 'manufacturer', 'M004', 4, '海尔家电用了很多年，售后服务特别好！', '服务好是我们的宗旨，谢谢您的认可！', '2024-01-17 15:00:00', 0, 1, '2024-01-16 17:00:00'),
('MR010', 7, 'manufacturer', 'M007', 5, '太喜欢大疆了，每次带出去飞行都引来围观！', NULL, NULL, 1, 1, '2024-01-20 10:00:00'),
('MR011', 4, 'supplier', 'S001', 5, '华强供应链发货非常及时，合作很顺畅。', '感谢您的认可，我们将一如既往提供优质服务。', '2024-01-21 09:00:00', 0, 1, '2024-01-20 14:00:00'),
('MR012', 9, 'supplier', 'S004', 3, '中科创新的芯片质量可以，但交货周期偏长。', '感谢您的反馈，我们正在扩大产能缩短交期。', '2024-01-22 10:00:00', 0, 1, '2024-01-21 11:00:00');

SET FOREIGN_KEY_CHECKS = 1;
