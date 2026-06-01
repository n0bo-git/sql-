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

 Date: 01/06/2026 10:51:46
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for customer
-- ----------------------------
DROP TABLE IF EXISTS `customer`;
CREATE TABLE `customer`  (
  `cust_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '顾客代码',
  `cust_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '顾客名称',
  `contact_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '联系人姓名',
  `address` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '地址',
  `postcode` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '邮编',
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '联系电话'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of customer
-- ----------------------------
INSERT INTO `customer` VALUES ('KH001', '李记百货店', '李经理', '和煦苑361', '116100', '1188888');
INSERT INTO `customer` VALUES ('KH002', '刘氏日用品', '刘经理·', '和煦苑358', '116100', '1288888');
INSERT INTO `customer` VALUES ('KH003', '翠花五金店', '虫大', '狗熊岭树洞', '116100', '1388888');
INSERT INTO `customer` VALUES ('4', '杨氏二元店', '杨经理', '和煦苑358', '116100', '1488888');

-- ----------------------------
-- Table structure for goods
-- ----------------------------
DROP TABLE IF EXISTS `goods`;
CREATE TABLE `goods`  (
  `goods_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '商品分类编码',
  `manu_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '生产厂家编码',
  `goods_desc` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '商品说明',
  `unit_price` decimal(10, 2) NOT NULL COMMENT '单价',
  PRIMARY KEY (`goods_code` DESC, `manu_code` DESC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of goods
-- ----------------------------
INSERT INTO `goods` VALUES ('SP010', 'C004', '黑白大块头罗隐', 3888.00);
INSERT INTO `goods` VALUES ('SP009', 'C004', '黑白同乘独角兽', 4888.00);
INSERT INTO `goods` VALUES ('SP008', 'C003', '洗漱用品大套餐', 58.00);
INSERT INTO `goods` VALUES ('SP007', 'C003', '清洁工具大套餐', 168.00);
INSERT INTO `goods` VALUES ('SP006', 'C002', '健康护腕', 49.00);
INSERT INTO `goods` VALUES ('SP005', 'C002', '五星乒乓球拍', 168.00);
INSERT INTO `goods` VALUES ('SP004', 'C002', '7号NBA专用篮球', 299.00);
INSERT INTO `goods` VALUES ('SP003', 'C001', '加厚演算纸', 5.00);
INSERT INTO `goods` VALUES ('SP002', 'C001', '修正液', 3.00);
INSERT INTO `goods` VALUES ('SP001', 'C001', '黑色水性笔盒装', 15.00);

-- ----------------------------
-- Table structure for manufacturer
-- ----------------------------
DROP TABLE IF EXISTS `manufacturer`;
CREATE TABLE `manufacturer`  (
  `manu_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '厂家代码',
  `manu_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '厂家名称',
  PRIMARY KEY (`manu_code`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of manufacturer
-- ----------------------------
INSERT INTO `manufacturer` VALUES ('C001', '文具全能造有限公司');
INSERT INTO `manufacturer` VALUES ('C002', '体育啥都行有限公司');
INSERT INTO `manufacturer` VALUES ('C003', '日用随便用有限公司');
INSERT INTO `manufacturer` VALUES ('C004', '黑白异色批发有限公司');

-- ----------------------------
-- Table structure for order_detail
-- ----------------------------
DROP TABLE IF EXISTS `order_detail`;
CREATE TABLE `order_detail`  (
  `order_id` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '订单号',
  `detail_id` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `goods_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `manu_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `buy_num` int NOT NULL,
  `total_amount` decimal(12, 2) NOT NULL,
  PRIMARY KEY (`detail_id`, `order_id`, `goods_code` DESC, `manu_code`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of order_detail
-- ----------------------------
INSERT INTO `order_detail` VALUES ('DD001', 'MX001', 'SP001', 'C001', 20, 300.00);
INSERT INTO `order_detail` VALUES ('DD001', 'MX002', 'SP002', 'C001', 50, 150.00);
INSERT INTO `order_detail` VALUES ('DD001', 'MX003', 'SP003', 'C001', 50, 250.00);
INSERT INTO `order_detail` VALUES ('DD002', 'MX004', 'SP004', 'C002', 5, 1495.00);
INSERT INTO `order_detail` VALUES ('DD002', 'MX005', 'SP005', 'C002', 10, 1680.00);
INSERT INTO `order_detail` VALUES ('DD002', 'MX006', 'SP006', 'C002', 20, 980.00);
INSERT INTO `order_detail` VALUES ('DD003', 'MX007', 'SP007', 'C003', 10, 1680.00);
INSERT INTO `order_detail` VALUES ('DD003', 'MX008', 'SP008', 'C003', 10, 580.00);
INSERT INTO `order_detail` VALUES ('DD004', 'MX009', 'SP009', 'C004', 2, 9776.00);
INSERT INTO `order_detail` VALUES ('DD004', 'MX010', 'SP010', 'C004', 1, 3888.00);

-- ----------------------------
-- Table structure for order_main
-- ----------------------------
DROP TABLE IF EXISTS `order_main`;
CREATE TABLE `order_main`  (
  `order_id` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '订单号',
  `order_date` datetime NULL DEFAULT NULL COMMENT '下单日期',
  `cust_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '顾客代码',
  `transport_req` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '运输要求',
  `supply_flag` tinyint NOT NULL COMMENT '能否供货标志',
  `transport_date` date NULL DEFAULT NULL COMMENT '运输日期',
  `goods_weight` decimal(8, 2) NULL DEFAULT NULL COMMENT '货物重量',
  `freight` decimal(10, 2) NULL DEFAULT NULL COMMENT '运费',
  `pay_list` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '付款清单',
  PRIMARY KEY (`order_id`, `cust_code`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of order_main
-- ----------------------------
INSERT INTO `order_main` VALUES ('DD001', '2026-06-01 09:59:58', 'KH001', '送货上门全天配送', 1, '2026-06-02', 10.00, 12.50, '微信支付已付全款');
INSERT INTO `order_main` VALUES ('DD002', '2026-06-01 10:27:36', 'KH002', '送货上门全天配送', 1, '2026-06-02', 15.00, 20.00, '微信支付未全款');
INSERT INTO `order_main` VALUES ('DD003', '2026-06-01 10:29:08', 'KH003', '送货上门全天配送', 0, '2026-06-02', 12.00, 16.00, '微信支付未付款');
INSERT INTO `order_main` VALUES ('DD004', '2026-06-01 10:31:42', 'KH004', '送货上门周末不配送', 0, '2026-06-02', 20.00, 30.00, '微信支付已付全款');

SET FOREIGN_KEY_CHECKS = 1;
