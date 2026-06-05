package com.example.springboot.entity;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;

@TableName("goods_review")
public class GoodsReview {

    @TableId("review_code")
    private String reviewCode;

    private String custCode;
    private String goodsCode;
    private String review;
    private Integer reviewRating;
    private java.time.LocalDateTime reviewTime;

    /** 顾客名称（非表字段，用于关联查询展示） */
    @TableField(exist = false)
    private String custName;

    // ---- getters / setters ----
    public String getReviewCode() { return reviewCode; }
    public void setReviewCode(String reviewCode) { this.reviewCode = reviewCode; }

    public String getCustCode() { return custCode; }
    public void setCustCode(String custCode) { this.custCode = custCode; }

    public String getGoodsCode() { return goodsCode; }
    public void setGoodsCode(String goodsCode) { this.goodsCode = goodsCode; }

    public String getReview() { return review; }
    public void setReview(String review) { this.review = review; }

    public Integer getReviewRating() { return reviewRating; }
    public void setReviewRating(Integer reviewRating) { this.reviewRating = reviewRating; }

    public java.time.LocalDateTime getReviewTime() { return reviewTime; }
    public void setReviewTime(java.time.LocalDateTime reviewTime) { this.reviewTime = reviewTime; }

    public String getCustName() { return custName; }
    public void setCustName(String custName) { this.custName = custName; }
}
