/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 50737
 Source Host           : localhost:3306
 Source Schema         : code_scaffold

 Target Server Type    : MySQL
 Target Server Version : 50737
 File Encoding         : 65001

 Date: 14/11/2025 11:13:13
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户名',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '密码',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '姓名',
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '电话',
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '邮箱',
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '地址',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '头像',
  `sex` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '性别',
  `age` int(11) NULL DEFAULT NULL COMMENT '年龄',
  `infos` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '个人介绍',
  `role` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '角色',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '用户表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, 'admin', '123', '管理员', '13677889988', 'admin@xxx.com', '江苏南京', 'http://localhost:9999/file/download/汤姆.jpg', '男', 27, '我是管理员', 'ADMIN');
INSERT INTO `user` VALUES (2, 'tom', '123', '汤姆', '13988776699', 'jerry@qq.com', '北京', 'http://localhost:9999/file/download/汤姆.jpg', '男', 24, '我爱你，亲爱的姑娘', 'USER');
INSERT INTO `user` VALUES (3, 'jerry', '123', '杰瑞', '15098765321', 'tom@qq.com', '上海', 'http://localhost:9999/file/download/杰瑞.jpg', '男', 25, '我爱你，亲爱的姑娘', 'USER');

SET FOREIGN_KEY_CHECKS = 1;
