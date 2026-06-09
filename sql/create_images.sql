-- 创建商品图片表（如果不存在）
CREATE TABLE IF NOT EXISTS `goods_image` (
  `image_id` varchar(20) NOT NULL,
  `goods_code` varchar(20) NOT NULL,
  `image_url` varchar(255) NOT NULL,
  `is_cover` tinyint(1) DEFAULT 0,
  `sort_order` int DEFAULT 0,
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`image_id`),
  KEY `idx_goods` (`goods_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
