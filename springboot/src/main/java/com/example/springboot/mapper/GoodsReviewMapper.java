package com.example.springboot.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.example.springboot.entity.GoodsReview;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

public interface GoodsReviewMapper extends BaseMapper<GoodsReview> {

    @Select("SELECT gr.review_code, gr.user_id, gr.goods_code, gr.review, " +
        "gr.review_rating, gr.review_time, " +
        "COALESCE(um.name, '匿名用户') AS cust_name " +
        "FROM goods_review gr " +
        "LEFT JOIN usermessage um ON gr.user_id = um.user_id " +
        "WHERE gr.goods_code = #{goodsCode} " +
        "ORDER BY gr.review_time DESC")
    List<GoodsReview> selectReviewsByGoodsCode(@Param("goodsCode") String goodsCode);
}
