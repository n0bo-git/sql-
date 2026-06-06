package com.example.springboot.entity;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;

@TableName("order_main")
public class OrderMain {

    @TableId("order_id")
    private String orderId;

    private Integer userId;
    private java.time.LocalDateTime orderDate;
    private String transportReq;
    private Integer supplyFlag;
    private java.time.LocalDate transportDate;
    private java.math.BigDecimal goodsWeight;
    private java.math.BigDecimal freight;
    private String payList;

    // ---- getters/setters ----
    public String getOrderId() { return orderId; }
    public void setOrderId(String o) { this.orderId = o; }
    public Integer getUserId() { return userId; }
    public void setUserId(Integer u) { this.userId = u; }
    public java.time.LocalDateTime getOrderDate() { return orderDate; }
    public void setOrderDate(java.time.LocalDateTime d) { this.orderDate = d; }
    public String getTransportReq() { return transportReq; }
    public void setTransportReq(String t) { this.transportReq = t; }
    public Integer getSupplyFlag() { return supplyFlag; }
    public void setSupplyFlag(Integer f) { this.supplyFlag = f; }
    public java.time.LocalDate getTransportDate() { return transportDate; }
    public void setTransportDate(java.time.LocalDate d) { this.transportDate = d; }
    public java.math.BigDecimal getGoodsWeight() { return goodsWeight; }
    public void setGoodsWeight(java.math.BigDecimal w) { this.goodsWeight = w; }
    public java.math.BigDecimal getFreight() { return freight; }
    public void setFreight(java.math.BigDecimal f) { this.freight = f; }
    public String getPayList() { return payList; }
    public void setPayList(String p) { this.payList = p; }
}
