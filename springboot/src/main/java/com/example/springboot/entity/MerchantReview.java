package com.example.springboot.entity;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;

@TableName("merchant_review")
public class MerchantReview {

    @TableId("review_id")
    private String reviewId;

    private Integer userId;
    private String targetType;
    private String targetCode;
    private Integer rating;
    private String reviewContent;
    private String replyContent;
    private java.time.LocalDateTime replyTime;
    private Integer isAnonymous;
    private Integer reviewStatus;
    private java.time.LocalDateTime reviewTime;

    public String getReviewId() { return reviewId; }
    public void setReviewId(String r) { this.reviewId = r; }
    public Integer getUserId() { return userId; }
    public void setUserId(Integer u) { this.userId = u; }
    public String getTargetType() { return targetType; }
    public void setTargetType(String t) { this.targetType = t; }
    public String getTargetCode() { return targetCode; }
    public void setTargetCode(String c) { this.targetCode = c; }
    public Integer getRating() { return rating; }
    public void setRating(Integer r) { this.rating = r; }
    public String getReviewContent() { return reviewContent; }
    public void setReviewContent(String c) { this.reviewContent = c; }
    public String getReplyContent() { return replyContent; }
    public void setReplyContent(String c) { this.replyContent = c; }
    public java.time.LocalDateTime getReplyTime() { return replyTime; }
    public void setReplyTime(java.time.LocalDateTime t) { this.replyTime = t; }
    public Integer getIsAnonymous() { return isAnonymous; }
    public void setIsAnonymous(Integer a) { this.isAnonymous = a; }
    public Integer getReviewStatus() { return reviewStatus; }
    public void setReviewStatus(Integer s) { this.reviewStatus = s; }
    public java.time.LocalDateTime getReviewTime() { return reviewTime; }
    public void setReviewTime(java.time.LocalDateTime t) { this.reviewTime = t; }
}
