package com.example.springboot.service.impl;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.example.springboot.entity.Cart;
import com.example.springboot.entity.Goods;
import com.example.springboot.entity.GoodsReview;
import com.example.springboot.entity.GoodsVO;
import com.example.springboot.mapper.CartMapper;
import com.example.springboot.mapper.GoodsMapper;
import com.example.springboot.mapper.GoodsReviewMapper;
import com.example.springboot.service.IGoodsService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.UUID;

@Service
public class GoodsServiceImpl implements IGoodsService {

    private static final Logger log = LoggerFactory.getLogger(GoodsServiceImpl.class);

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

        for (GoodsVO vo : result.getRecords()) {
            fillCoverImage(vo);
            fillReviews(vo);
        }
        return result;
    }

    @Override
    public GoodsVO getGoodsDetail(String goodsCode) {
        GoodsVO vo = goodsMapper.selectGoodsDetail(goodsCode);
        if (vo != null) {
            fillCoverImage(vo);
            fillReviews(vo);
        }
        return vo;
    }

    @Override
    public List<Goods> listAll() {
        return goodsMapper.selectAllGoods();
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
        String code = "CART" + LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyMMddHHmmss"))
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

    /** 填充封面图：goods_image 表可能不存在，查不到不抛异常 */
    private void fillCoverImage(GoodsVO vo) {
        try {
            String imageUrl = goodsMapper.selectCoverImage(vo.getGoodsCode());
            vo.setCoverImage(imageUrl);  // null 也没关系，前端会用占位图
        } catch (Exception e) {
            // goods_image 表不存在或其他数据库错误 → 忽略，图片为空
            log.warn("获取封面图失败 (goodsCode={}): {}", vo.getGoodsCode(), e.getMessage());
            vo.setCoverImage(null);
        }
    }

    /** 填充评论和评分：goods_review 表可能不存在，查不到不抛异常 */
    private void fillReviews(GoodsVO vo) {
        try {
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
        } catch (Exception e) {
            log.warn("获取评论失败 (goodsCode={}): {}", vo.getGoodsCode(), e.getMessage());
            vo.setReviews(null);
            vo.setAvgRating(0.0);
        }
    }
}
