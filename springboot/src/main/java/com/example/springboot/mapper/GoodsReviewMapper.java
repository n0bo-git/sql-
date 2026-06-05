package com.example.springboot.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.example.springboot.entity.GoodsReview;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

public interface GoodsReviewMapper extends BaseMapper<GoodsReview> {

    /**
     * 根据商品编码查询评论列表（含顾客名称）
     */
    @Select("SELECT gr.review_code, gr.cust_code, gr.goods_code, gr.review, " +
        "gr.review_rating, gr.review_time, c.cust_name " +
        "FROM goods_review gr " +
        "LEFT JOIN customer c ON gr.cust_code = c.cust_code " +
        "WHERE gr.goods_code = #{goodsCode} " +
        "ORDER BY gr.review_time DESC")
    List<GoodsReview> selectReviewsByGoodsCode(@Param("goodsCode") String goodsCode);
}
