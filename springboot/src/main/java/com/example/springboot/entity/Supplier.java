package com.example.springboot.entity;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;

@TableName("supplier")
public class Supplier {

    @TableId("supplier_code")
    private String supplierCode;

    private String supplierName;
    private String contactPerson;
    private String contactPhone;
    private String contactEmail;
    private String address;
    private String bankAccount;
    private String bankName;
    private String taxId;
    private String supplyCategory;
    private Integer cooperationStatus;
    private String remark;
    private java.time.LocalDateTime createTime;
    private java.time.LocalDateTime updateTime;

    // ---- getters/setters ----
    public String getSupplierCode() { return supplierCode; }
    public void setSupplierCode(String c) { this.supplierCode = c; }
    public String getSupplierName() { return supplierName; }
    public void setSupplierName(String n) { this.supplierName = n; }
    public String getContactPerson() { return contactPerson; }
    public void setContactPerson(String p) { this.contactPerson = p; }
    public String getContactPhone() { return contactPhone; }
    public void setContactPhone(String p) { this.contactPhone = p; }
    public String getContactEmail() { return contactEmail; }
    public void setContactEmail(String e) { this.contactEmail = e; }
    public String getAddress() { return address; }
    public void setAddress(String a) { this.address = a; }
    public String getBankAccount() { return bankAccount; }
    public void setBankAccount(String b) { this.bankAccount = b; }
    public String getBankName() { return bankName; }
    public void setBankName(String b) { this.bankName = b; }
    public String getTaxId() { return taxId; }
    public void setTaxId(String t) { this.taxId = t; }
    public String getSupplyCategory() { return supplyCategory; }
    public void setSupplyCategory(String c) { this.supplyCategory = c; }
    public Integer getCooperationStatus() { return cooperationStatus; }
    public void setCooperationStatus(Integer s) { this.cooperationStatus = s; }
    public String getRemark() { return remark; }
    public void setRemark(String r) { this.remark = r; }
    public java.time.LocalDateTime getCreateTime() { return createTime; }
    public void setCreateTime(java.time.LocalDateTime t) { this.createTime = t; }
    public java.time.LocalDateTime getUpdateTime() { return updateTime; }
    public void setUpdateTime(java.time.LocalDateTime t) { this.updateTime = t; }
}
