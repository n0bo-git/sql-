package com.example.springboot.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.example.springboot.common.Result;
import com.example.springboot.entity.*;
import com.example.springboot.mapper.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 统一数据接口：供应商 / 评论 / 购物车 / 订单 / 用户信息
 */
@CrossOrigin
@RestController
public class DataController {

    @Autowired private com.example.springboot.mapper.SupplierMapper supplierMapper;
    @Autowired private GoodsReviewMapper goodsReviewMapper;
    @Autowired private CartMapper cartMapper;
    @Autowired private UserMessageMapper userMessageMapper;
    @Autowired private UserMapper userMapper;
    @Autowired private MerchantReviewMapper merchantReviewMapper;
    @Autowired private OrderMainMapper orderMainMapper;

    // ==================== 供应商 ====================
    @GetMapping("/supplier/selectAll")
    public Result supplierAll() {
        return Result.success(supplierMapper.selectList(new QueryWrapper<Supplier>().orderByAsc("supplier_code")));
    }

    // ==================== 评论管理 ====================
    @GetMapping("/review/page")
    public Result reviewPage(@RequestParam(defaultValue = "1") Integer pageNum,
                             @RequestParam(defaultValue = "10") Integer pageSize) {
        return Result.success(new Page<GoodsReview>(pageNum, pageSize).setRecords(
            goodsReviewMapper.selectList(new QueryWrapper<GoodsReview>().orderByDesc("review_time"))));
    }

    @DeleteMapping("/review/delete/{reviewCode}")
    public Result reviewDelete(@PathVariable String reviewCode) {
        goodsReviewMapper.deleteById(reviewCode);
        return Result.success();
    }

    // ==================== 购物车 ====================
    @GetMapping("/cart/selectAll")
    public Result cartAll() {
        return Result.success(cartMapper.selectList(new QueryWrapper<Cart>().orderByDesc("add_time")));
    }

    @DeleteMapping("/cart/delete/{cartCode}")
    public Result cartDelete(@PathVariable String cartCode) {
        cartMapper.deleteById(cartCode);
        return Result.success();
    }

    /** 购物车支付：扣余额，清已选商品 */
    @PostMapping("/cart/pay")
    public Result cartPay(@RequestBody java.util.Map<String, Object> body) {
        Integer userId = (Integer) body.get("userId");
        @SuppressWarnings("unchecked")
        java.util.List<String> cartCodes = (java.util.List<String>) body.get("cartCodes");
        if (userId == null || cartCodes == null || cartCodes.isEmpty()) {
            return Result.error("请选择要支付的商品");
        }

        // 1. 计算总价
        java.math.BigDecimal total = java.math.BigDecimal.ZERO;
        for (String code : cartCodes) {
            Cart cart = cartMapper.selectById(code);
            if (cart != null && cart.getUserId() != null && cart.getUserId().equals(userId)) {
                if (cart.getTotalPrice() != null) total = total.add(cart.getTotalPrice());
            }
        }
        if (total.compareTo(java.math.BigDecimal.ZERO) <= 0) {
            return Result.error("无效的支付金额");
        }

        // 2. 查余额
        UserMessage msg = userMessageMapper.selectById(userId);
        if (msg == null || msg.getBalance() == null) {
            return Result.error("用户信息不存在");
        }
        java.math.BigDecimal balance = java.math.BigDecimal.valueOf(msg.getBalance());
        if (balance.compareTo(total) < 0) {
            return Result.error("余额不足！需要 ¥" + total + "，当前余额 ¥" + balance);
        }

        // 3. 扣余额
        msg.setBalance(balance.subtract(total).intValue());
        userMessageMapper.updateById(msg);

        // 4. 生成订单
        String orderId = "ORD" + java.time.LocalDateTime.now().format(java.time.format.DateTimeFormatter.ofPattern("yyyyMMddHHmmss"));
        OrderMain order = new OrderMain();
        order.setOrderId(orderId);
        order.setUserId(userId);
        order.setOrderDate(java.time.LocalDateTime.now());
        order.setTransportReq("快递");
        order.setSupplyFlag(1);
        order.setGoodsWeight(java.math.BigDecimal.ZERO);
        order.setFreight(total);
        order.setPayList("已付");
        orderMainMapper.insert(order);

        // 5. 清已支付的购物车项
        for (String code : cartCodes) {
            cartMapper.deleteById(code);
        }

        return Result.success("支付成功 ¥" + total + "，订单号 " + orderId + "，剩余余额 ¥" + msg.getBalance());
    }

    // ==================== 用户信息 ====================
    @GetMapping("/usermessage/selectAll")
    public Result userMessageAll() {
        return Result.success(userMessageMapper.selectList(null));
    }

    @GetMapping("/usermessage/selectByUserId/{userId}")
    public Result userMessageByUserId(@PathVariable Integer userId) {
        return Result.success(userMessageMapper.selectById(userId));
    }

    @PutMapping("/usermessage/update")
    public Result userMessageUpdate(@RequestBody UserMessage msg) {
        userMessageMapper.updateById(msg);
        return Result.success();
    }

    // ==================== 用户列表（联合查询） ====================
    @GetMapping("/user/list")
    public Result userList() {
        List<User> users = userMapper.selectList(new QueryWrapper<User>().orderByAsc("id"));
        // 填充 usermessage 信息
        for (User u : users) {
            UserMessage um = userMessageMapper.selectById(u.getId());
            if (um != null) {
                u.setToken(um.getName());       // 复用 token 字段传 name 给前端
                u.setNewPassword(um.getPhone()); // 复用 newPassword 传 phone
            }
        }
        return Result.success(users);
    }

    // ==================== 商家评价 ====================
    @GetMapping("/merchant/review")
    public Result merchantReview() {
        return Result.success(merchantReviewMapper.selectList(
            new QueryWrapper<MerchantReview>().orderByDesc("review_time")));
    }

    // ==================== 订单 ====================
    @GetMapping("/order/list")
    public Result orderList() {
        return Result.success(orderMainMapper.selectList(
            new QueryWrapper<OrderMain>().orderByDesc("order_date")));
    }
}
