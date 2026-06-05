package com.example.springboot.entity;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;

@TableName("manufacturer")
public class Manufacturer {

    @TableId("manu_code")
    private String manuCode;

    private String manuName;
    private String manuPhone;

    // ---- getters / setters ----
    public String getManuCode() { return manuCode; }
    public void setManuCode(String manuCode) { this.manuCode = manuCode; }

    public String getManuName() { return manuName; }
    public void setManuName(String manuName) { this.manuName = manuName; }

    public String getManuPhone() { return manuPhone; }
    public void setManuPhone(String manuPhone) { this.manuPhone = manuPhone; }
}
