package com.example.springboot.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.example.springboot.common.Result;
import com.example.springboot.entity.*;
import com.example.springboot.mapper.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.*;

@CrossOrigin
@RestController
public class DataController {

    @Autowired private GoodsReviewMapper goodsReviewMapper;
    @Autowired private CartMapper cartMapper;
    @Autowired private UserMessageMapper userMessageMapper;
    @Autowired private UserMapper userMapper;
    @Autowired private GoodsMapper goodsMapper;
    @Autowired private ManufacturerMapper manufacturerMapper;

    // ==================== 评论 ====================
    @GetMapping("/review/page")
    public Result reviewPage(@RequestParam(defaultValue = "1") Integer pageNum,
                             @RequestParam(defaultValue = "10") Integer pageSize) {
        List<GoodsReview> list = goodsReviewMapper.selectList(
            new QueryWrapper<GoodsReview>().orderByDesc("review_time"));
        for (GoodsReview r : list) {
            if (r.getUserId() != null) {
                UserMessage um = userMessageMapper.selectById(r.getUserId());
                if (um != null) r.setCustName(um.getName());
            }
        }
        Page<GoodsReview> page = new Page<>(pageNum, pageSize);
        page.setRecords(list); page.setTotal(list.size());
        return Result.success(page);
    }

    @DeleteMapping("/review/delete/{reviewCode}")
    public Result reviewDelete(@PathVariable String reviewCode) {
        goodsReviewMapper.deleteById(reviewCode);
        return Result.success();
    }

    @PostMapping("/review/add")
    public Result reviewAdd(@RequestBody Map<String, Object> body) {
        GoodsReview r = new GoodsReview();
        r.setReviewCode("GR" + java.time.LocalDateTime.now().format(java.time.format.DateTimeFormatter.ofPattern("yyyyMMddHHmmss")));
        r.setUserId(Integer.valueOf(body.get("userId").toString()));
        r.setGoodsCode(body.get("goodsCode").toString());
        r.setReview(body.get("review").toString());
        r.setReviewRating(Integer.valueOf(body.get("reviewRating").toString()));
        r.setReviewTime(java.time.LocalDateTime.now());
        goodsReviewMapper.insert(r);
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

    @PostMapping("/cart/pay")
    public Result cartPay(@RequestBody Map<String, Object> body) {
        Integer userId = (Integer) body.get("userId");
        @SuppressWarnings("unchecked")
        List<String> cartCodes = (List<String>) body.get("cartCodes");
        if (userId == null || cartCodes == null || cartCodes.isEmpty())
            return Result.error("请选择要支付的商品");

        java.math.BigDecimal total = java.math.BigDecimal.ZERO;
        List<String> validCodes = new ArrayList<>();
        for (String code : cartCodes) {
            Cart cart = cartMapper.selectById(code);
            if (cart != null && cart.getUserId() != null && cart.getUserId().equals(userId)) {
                if (cart.getTotalPrice() != null) {
                    total = total.add(cart.getTotalPrice());
                    validCodes.add(code);
                }
            }
        }
        if (total.compareTo(java.math.BigDecimal.ZERO) <= 0) return Result.error("无效的支付金额（所选商品不属于当前用户或已失效）");
        cartCodes = validCodes;

        UserMessage msg = userMessageMapper.selectById(userId);
        if (msg == null || msg.getBalance() == null) return Result.error("用户信息不存在");
        java.math.BigDecimal balance = java.math.BigDecimal.valueOf(msg.getBalance());
        if (balance.compareTo(total) < 0)
            return Result.error("余额不足！需要 ¥" + total + "，当前余额 ¥" + balance);

        msg.setBalance(balance.subtract(total).intValue());
        userMessageMapper.updateById(msg);

        for (String code : cartCodes) cartMapper.deleteById(code);
        return Result.success("支付成功 ¥" + total + "，剩余余额 ¥" + msg.getBalance());
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

    // ==================== 用户列表 ====================
    @GetMapping("/user/list")
    public Result userList() {
        List<User> users = userMapper.selectList(new QueryWrapper<User>().orderByAsc("id"));
        for (User u : users) {
            UserMessage um = userMessageMapper.selectById(u.getId());
            if (um != null) {
                u.setToken(um.getName());
                u.setNewPassword(um.getPhone());
            }
        }
        return Result.success(users);
    }

    @PutMapping("/user/role")
    public Result updateRole(@RequestBody Map<String, Object> body) {
        Integer userId = Integer.valueOf(body.get("userId").toString());
        Integer role = Integer.valueOf(body.get("role").toString());
        User u = userMapper.selectById(userId);
        if (u == null) return Result.error("用户不存在");
        u.setRole(role);
        userMapper.updateById(u);
        return Result.success();
    }

    // ==================== 商品详情 ====================
    @GetMapping("/goods/detail/{goodsCode}")
    public Result goodsDetail(@PathVariable String goodsCode) {
        GoodsVO vo = goodsMapper.selectGoodsDetail(goodsCode);
        if (vo == null) return Result.error("商品不存在");
        try {
            List<GoodsReview> reviews = goodsReviewMapper.selectReviewsByGoodsCode(goodsCode);
            vo.setReviews(reviews);
            if (reviews != null && !reviews.isEmpty()) {
                double avg = reviews.stream().mapToInt(r -> r.getReviewRating() == null ? 0 : r.getReviewRating()).average().orElse(0);
                vo.setAvgRating(Math.round(avg * 10.0) / 10.0);
            }
        } catch(Exception ignored) {}
        Manufacturer mfr = manufacturerMapper.selectById(vo.getManuCode());
        Map<String, Object> result = new HashMap<>();
        result.put("goods", vo);
        result.put("manufacturer", mfr);
        return Result.success(result);
    }
}
