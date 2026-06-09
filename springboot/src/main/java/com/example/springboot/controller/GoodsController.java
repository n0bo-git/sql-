package com.example.springboot.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.example.springboot.common.Result;
import com.example.springboot.entity.*;
import com.example.springboot.mapper.GoodsCategoryMapper;
import com.example.springboot.mapper.GoodsImageMapper;
import com.example.springboot.mapper.ManufacturerMapper;
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

    @Autowired
    private GoodsCategoryMapper goodsCategoryMapper;

    @Autowired
    private ManufacturerMapper manufacturerMapper;
    @Autowired
    private GoodsImageMapper goodsImageMapper;

    /** 新增商品分类 */
    @PostMapping("/category/add")
    public Result addCategory(@RequestBody GoodsCategory cat) {
        goodsCategoryMapper.insert(cat);
        return Result.success();
    }

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
            e.printStackTrace();
            String msg = e.getMessage() != null ? e.getMessage() : e.getClass().getSimpleName();
            if (e instanceof DuplicateKeyException) {
                return Result.error("商品编码已存在: " + msg);
            }
            // 找根因
            Throwable cause = e.getCause();
            while (cause != null && cause.getMessage() == null) cause = cause.getCause();
            return Result.error("新增失败: " + (cause != null ? cause.getMessage() : msg));
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

    // ==================== 分类 & 厂家（供前端下拉） ====================

    /**
     * 查询全部分类（从 goods_category 表）
     */
    @GetMapping("/categories")
    public Result getCategories() {
        List<GoodsCategory> list = goodsCategoryMapper.selectList(
            new QueryWrapper<GoodsCategory>().orderByAsc("sort_order"));
        return Result.success(list);
    }

    /**
     * 查询全部厂家（从 manufacturer 表）
     */
    @GetMapping("/manufacturers")
    public Result getManufacturers() {
        List<Manufacturer> list = manufacturerMapper.selectList(
            new QueryWrapper<Manufacturer>().orderByAsc("manu_code"));
        return Result.success(list);
    }

    /** 新增厂家 */
    @PostMapping("/manufacturer/add")
    public Result addManufacturer(@RequestBody Manufacturer mfr) {
        manufacturerMapper.insert(mfr);
        return Result.success();
    }

    /** 更新厂家信息 */
    @PutMapping("/manufacturer/update")
    public Result updateManufacturer(@RequestBody Manufacturer mfr) {
        manufacturerMapper.updateById(mfr);
        return Result.success();
    }

    /** 保存商品图片（自动清除旧封面） */
    @PostMapping("/image/save")
    public Result saveImage(@RequestBody GoodsImage img) {
        if (img.getCreateTime() == null) img.setCreateTime(java.time.LocalDateTime.now());
        // 将该商品旧封面的 is_cover 全部置 0
        if (img.getIsCover() != null && img.getIsCover() == 1) {
            goodsImageMapper.clearCover(img.getGoodsCode());
        }
        goodsImageMapper.insert(img);
        return Result.success();
    }

}
