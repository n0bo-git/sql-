package com.example.springboot.entity;

import java.math.BigDecimal;
import java.util.List;

/**
 * 商品展示 VO —— 聚合 goods + manufacturer + image + reviews
 */
public class GoodsVO {

    private String goodsCode;
    private String manuCode;
    private String categoryId;
    private String goodsDesc;
    private BigDecimal unitPrice;

    /** 厂家名称 */
    private String manuName;

    /** 封面图片地址 */
    private String coverImage;

    /** 该商品的评论列表 */
    private List<GoodsReview> reviews;

    /** 平均评分 */
    private Double avgRating;

    // ---- getters / setters ----
    public String getGoodsCode() { return goodsCode; }
    public void setGoodsCode(String goodsCode) { this.goodsCode = goodsCode; }

    public String getManuCode() { return manuCode; }
    public void setManuCode(String manuCode) { this.manuCode = manuCode; }

    public String getCategoryId() { return categoryId; }
    public void setCategoryId(String categoryId) { this.categoryId = categoryId; }

    public String getGoodsDesc() { return goodsDesc; }
    public void setGoodsDesc(String goodsDesc) { this.goodsDesc = goodsDesc; }

    public BigDecimal getUnitPrice() { return unitPrice; }
    public void setUnitPrice(BigDecimal unitPrice) { this.unitPrice = unitPrice; }

    public String getManuName() { return manuName; }
    public void setManuName(String manuName) { this.manuName = manuName; }

    public String getCoverImage() { return coverImage; }
    public void setCoverImage(String coverImage) { this.coverImage = coverImage; }

    public List<GoodsReview> getReviews() { return reviews; }
    public void setReviews(List<GoodsReview> reviews) { this.reviews = reviews; }

    public Double getAvgRating() { return avgRating; }
    public void setAvgRating(Double avgRating) { this.avgRating = avgRating; }
}
