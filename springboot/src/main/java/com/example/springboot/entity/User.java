package com.example.springboot.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;


/** 用户登录表 */
@TableName("userlogin")
public class User {

    @TableId(type = IdType.AUTO)
    private Integer id;
    private String username;
    private String password;

    /** 0=管理员 2=普通用户 */
    private Integer role;

    @TableField(exist = false)
    private String token;
    @TableField(exist = false)
    private String newPassword;

    // ---- getters / setters ----
    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public Integer getRole() { return role; }
    public void setRole(Integer role) { this.role = role; }

    public String getToken() { return token; }
    public void setToken(String token) { this.token = token; }

    public String getNewPassword() { return newPassword; }
    public void setNewPassword(String newPassword) { this.newPassword = newPassword; }
}
