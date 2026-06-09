package com.example.springboot.entity;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;

@TableName("goods_review")
public class GoodsReview {

    @TableId("review_code")
    private String reviewCode;

    private Integer userId;
    private String goodsCode;
    private String review;
    private Integer reviewRating;
    private java.time.LocalDateTime reviewTime;

    /** 用户名（JOIN 查询用，非表字段） */
    @TableField(exist = false)
    private String custName;

    /** 旧 cust_code 字段，兼容 */
    @TableField(exist = false)
    private String custCode;

    // ---- getters / setters ----
    public String getReviewCode() { return reviewCode; }
    public void setReviewCode(String s) { this.reviewCode = s; }

    public Integer getUserId() { return userId; }
    public void setUserId(Integer u) { this.userId = u; }

    public String getGoodsCode() { return goodsCode; }
    public void setGoodsCode(String s) { this.goodsCode = s; }

    public String getReview() { return review; }
    public void setReview(String s) { this.review = s; }

    public Integer getReviewRating() { return reviewRating; }
    public void setReviewRating(Integer r) { this.reviewRating = r; }

    public java.time.LocalDateTime getReviewTime() { return reviewTime; }
    public void setReviewTime(java.time.LocalDateTime t) { this.reviewTime = t; }

    public String getCustName() { return custName; }
    public void setCustName(String s) { this.custName = s; }

    public String getCustCode() { return custCode; }
    public void setCustCode(String s) { this.custCode = s; }
}
