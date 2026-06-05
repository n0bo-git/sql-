package com.example.springboot.controller;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.example.springboot.common.Result;
import com.example.springboot.entity.Cart;
import com.example.springboot.entity.Goods;
import com.example.springboot.entity.GoodsVO;
import com.example.springboot.service.IGoodsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@CrossOrigin
@RestController
@RequestMapping("/goods")
public class GoodsController {

    @Autowired
    private IGoodsService goodsService;

    // ==================== 查询 ====================

    /**
     * 分页查询商品列表（含厂家、封面图、评论）
     */
    @GetMapping("/page")
    public Result getGoodsPage(@RequestParam(defaultValue = "1") Integer pageNum,
                               @RequestParam(defaultValue = "8") Integer pageSize,
                               @RequestParam(required = false) String keyword,
                               @RequestParam(required = false) String categoryId) {
        Page<GoodsVO> page = goodsService.getGoodsPage(pageNum, pageSize, keyword, categoryId);
        return Result.success(page);
    }

    /**
     * 查询全部商品
     */
    @GetMapping("/selectAll")
    public Result selectAll() {
        List<Goods> list = goodsService.listAll();
        return Result.success(list);
    }

    /**
     * 根据 goodsCode 查询商品详情
     */
    @GetMapping("/selectById/{goodsCode}")
    public Result selectById(@PathVariable String goodsCode) {
        GoodsVO vo = goodsService.getGoodsDetail(goodsCode);
        return Result.success(vo);
    }

    // ==================== 增删改 ====================

    /**
     * 新增商品
     */
    @PostMapping("/add")
    public Result add(@RequestBody Goods goods) {
        try {
            goodsService.addGoods(goods);
        } catch (Exception e) {
            if (e instanceof DuplicateKeyException) {
                return Result.error("商品编码已存在");
            } else {
                return Result.error("系统错误");
            }
        }
        return Result.success();
    }

    /**
     * 修改商品
     */
    @PutMapping("/update")
    public Result update(@RequestBody Goods goods) {
        goodsService.updateGoods(goods);
        return Result.success();
    }

    /**
     * 删除商品
     */
    @DeleteMapping("/delete/{goodsCode}")
    public Result delete(@PathVariable String goodsCode) {
        goodsService.deleteGoods(goodsCode);
        return Result.success();
    }

    // ==================== 购物车 ====================

    /**
     * 加入购物车
     */
    @PostMapping("/cart/add")
    public Result addToCart(@RequestBody Cart cart) {
        goodsService.addToCart(cart);
        return Result.success();
    }
}
