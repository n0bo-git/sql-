package com.example.springboot.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.example.springboot.entity.Cart;
import com.example.springboot.entity.Goods;
import com.example.springboot.entity.GoodsReview;
import com.example.springboot.entity.GoodsVO;
import com.example.springboot.mapper.CartMapper;
import com.example.springboot.mapper.GoodsMapper;
import com.example.springboot.mapper.GoodsReviewMapper;
import com.example.springboot.service.IGoodsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.UUID;

@Service
public class GoodsServiceImpl implements IGoodsService {

    @Autowired
    private GoodsMapper goodsMapper;

    @Autowired
    private GoodsReviewMapper goodsReviewMapper;

    @Autowired
    private CartMapper cartMapper;

    @Override
    public Page<GoodsVO> getGoodsPage(Integer pageNum, Integer pageSize, String keyword, String categoryId) {
        Page<GoodsVO> page = new Page<>(pageNum, pageSize);
        Page<GoodsVO> result = goodsMapper.selectGoodsPage(page, keyword, categoryId);

        // 为每个商品填充评论 + 平均分
        for (GoodsVO vo : result.getRecords()) {
            fillReviews(vo);
        }
        return result;
    }

    @Override
    public GoodsVO getGoodsDetail(String goodsCode) {
        GoodsVO vo = goodsMapper.selectGoodsDetail(goodsCode);
        if (vo != null) {
            fillReviews(vo);
        }
        return vo;
    }

    @Override
    public List<Goods> listAll() {
        return goodsMapper.selectList(new QueryWrapper<Goods>().orderByAsc("goods_code"));
    }

    @Override
    public void addGoods(Goods goods) {
        goodsMapper.insert(goods);
    }

    @Override
    public void updateGoods(Goods goods) {
        goodsMapper.updateById(goods);
    }

    @Override
    public void deleteGoods(String goodsCode) {
        goodsMapper.deleteById(goodsCode);
    }

    @Override
    public void addToCart(Cart cart) {
        String code = "CART" + LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMddHHmmss"))
                + UUID.randomUUID().toString().substring(0, 4).toUpperCase();
        cart.setCartCode(code);
        cart.setAddTime(LocalDateTime.now());
        if (cart.getQuantity() == null || cart.getQuantity() <= 0) {
            cart.setQuantity(1);
        }
        cart.setTotalPrice(cart.getUnitPrice().multiply(new java.math.BigDecimal(cart.getQuantity())));
        cartMapper.insert(cart);
    }

    // ========== 私有方法 ==========
    private void fillReviews(GoodsVO vo) {
        List<GoodsReview> reviews = goodsReviewMapper.selectReviewsByGoodsCode(vo.getGoodsCode());
        vo.setReviews(reviews);
        if (reviews != null && !reviews.isEmpty()) {
            double avg = reviews.stream()
                    .mapToInt(GoodsReview::getReviewRating)
                    .average()
                    .orElse(0);
            vo.setAvgRating(Math.round(avg * 10.0) / 10.0);
        } else {
            vo.setAvgRating(0.0);
        }
    }
}
