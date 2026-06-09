package com.example.springboot.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.example.springboot.entity.GoodsImage;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Update;

public interface GoodsImageMapper extends BaseMapper<GoodsImage> {

    /** 清除某商品的所有封面标记 */
    @Update("UPDATE goods_image SET is_cover = 0 WHERE goods_code = #{goodsCode} AND is_cover = 1")
    void clearCover(@Param("goodsCode") String goodsCode);
}
