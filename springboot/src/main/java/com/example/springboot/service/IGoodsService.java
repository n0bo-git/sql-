package com.example.springboot.service;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.example.springboot.entity.Cart;
import com.example.springboot.entity.Goods;
import com.example.springboot.entity.GoodsVO;

import java.util.List;

public interface IGoodsService {

    /**
     * 分页查询商品列表（含厂家 + 封面图 + 评论 + 均分）
     */
    Page<GoodsVO> getGoodsPage(Integer pageNum, Integer pageSize, String keyword, String categoryId);

    /**
     * 根据 goodsCode 查询商品详情
     */
    GoodsVO getGoodsDetail(String goodsCode);

    /**
     * 查询全部商品
     */
    List<Goods> listAll();

    /**
     * 新增商品
     */
    void addGoods(Goods goods);

    /**
     * 修改商品
     */
    void updateGoods(Goods goods);

    /**
     * 删除商品
     */
    void deleteGoods(String goodsCode);

    /**
     * 加入购物车
     */
    void addToCart(Cart cart);
}
