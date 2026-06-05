package com.example.springboot.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.example.springboot.entity.Goods;
import com.example.springboot.entity.GoodsVO;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Result;
import org.apache.ibatis.annotations.Results;
import org.apache.ibatis.annotations.Select;

public interface GoodsMapper extends BaseMapper<Goods> {

    /**
     * 分页查询商品列表（含厂家名称 + 封面图），支持搜索
     * 使用 @Results 显式映射列名 → VO 属性，避免隐式映射失败
     */
    @Select("SELECT g.goods_code, g.manu_code, g.category_id, g.goods_desc, g.unit_price, " +
        "m.manu_name, " +
        "(SELECT gi.image_url FROM goods_image gi WHERE gi.goods_code = g.goods_code AND gi.is_cover = 1 LIMIT 1) AS cover_image " +
        "FROM goods g " +
        "LEFT JOIN manufacturer m ON g.manu_code = m.manu_code " +
        "WHERE (g.goods_desc LIKE CONCAT('%', #{keyword}, '%') OR m.manu_name LIKE CONCAT('%', #{keyword}, '%') OR #{keyword} IS NULL OR #{keyword} = '') " +
        "AND (g.category_id = #{categoryId} OR #{categoryId} IS NULL OR #{categoryId} = '') " +
        "ORDER BY g.goods_code ASC")
    @Results({
        @Result(property = "goodsCode",     column = "goods_code"),
        @Result(property = "manuCode",      column = "manu_code"),
        @Result(property = "categoryId",    column = "category_id"),
        @Result(property = "goodsDesc",     column = "goods_desc"),
        @Result(property = "unitPrice",     column = "unit_price"),
        @Result(property = "manuName",      column = "manu_name"),
        @Result(property = "coverImage",    column = "cover_image"),
    })
    Page<GoodsVO> selectGoodsPage(Page<GoodsVO> page,
                                  @Param("keyword") String keyword,
                                  @Param("categoryId") String categoryId);

    /**
     * 根据商品编码查询商品详情（含厂家名称 + 封面图）
     */
    @Select("SELECT g.goods_code, g.manu_code, g.category_id, g.goods_desc, g.unit_price, " +
        "m.manu_name, " +
        "(SELECT gi.image_url FROM goods_image gi WHERE gi.goods_code = g.goods_code AND gi.is_cover = 1 LIMIT 1) AS cover_image " +
        "FROM goods g " +
        "LEFT JOIN manufacturer m ON g.manu_code = m.manu_code " +
        "WHERE g.goods_code = #{goodsCode}")
    @Results({
        @Result(property = "goodsCode",     column = "goods_code"),
        @Result(property = "manuCode",      column = "manu_code"),
        @Result(property = "categoryId",    column = "category_id"),
        @Result(property = "goodsDesc",     column = "goods_desc"),
        @Result(property = "unitPrice",     column = "unit_price"),
        @Result(property = "manuName",      column = "manu_name"),
        @Result(property = "coverImage",    column = "cover_image"),
    })
    GoodsVO selectGoodsDetail(@Param("goodsCode") String goodsCode);
}
