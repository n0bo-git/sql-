package com.example.springboot.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.example.springboot.entity.Goods;
import com.example.springboot.entity.GoodsVO;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

public interface GoodsMapper extends BaseMapper<Goods> {

    /**
     * 分页查询商品列表（含厂家名称 + 分类），支持关键词搜索 + 分类筛选
     */
    @Select("<script>" +
        "SELECT g.goods_code, g.manu_code, g.category_id, g.goods_desc, g.unit_price, " +
        "m.manu_name " +
        "FROM goods g " +
        "LEFT JOIN manufacturer m ON g.manu_code = m.manu_code " +
        "<where>" +
        "  <if test='keyword != null and keyword != \"\"'>" +
        "    AND (g.goods_desc LIKE CONCAT('%', #{keyword}, '%') OR m.manu_name LIKE CONCAT('%', #{keyword}, '%'))" +
        "  </if>" +
        "  <if test='categoryId != null and categoryId != \"\"'>" +
        "    AND g.category_id = #{categoryId}" +
        "  </if>" +
        "</where>" +
        "ORDER BY g.goods_code ASC" +
        "</script>")
    Page<GoodsVO> selectGoodsPage(Page<GoodsVO> page,
                                  @Param("keyword") String keyword,
                                  @Param("categoryId") String categoryId);

    /**
     * 查询单条商品详情（含厂家名称）
     */
    @Select("SELECT g.goods_code, g.manu_code, g.category_id, g.goods_desc, g.unit_price, " +
        "m.manu_name " +
        "FROM goods g " +
        "LEFT JOIN manufacturer m ON g.manu_code = m.manu_code " +
        "WHERE g.goods_code = #{goodsCode}")
    GoodsVO selectGoodsDetail(@Param("goodsCode") String goodsCode);

    /**
     * 查询商品封面图
     */
    @Select("SELECT image_url FROM goods_image WHERE goods_code = #{goodsCode} AND is_cover = 1 ORDER BY create_time DESC LIMIT 1")
    String selectCoverImage(@Param("goodsCode") String goodsCode);

    /**
     * 查询全部 goods 记录（基础 CRUD 用）
     */
    @Select("SELECT * FROM goods ORDER BY goods_code ASC")
    List<Goods> selectAllGoods();
}
