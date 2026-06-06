-- 临时去掉购物车外键约束（demo 阶段不需要严格 FK）
ALTER TABLE `cart` DROP FOREIGN KEY IF EXISTS `fk_cart_user`;
