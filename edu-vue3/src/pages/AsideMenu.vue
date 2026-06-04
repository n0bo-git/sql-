<template>
  <el-row class="tac">
    <el-col :span="24">
      <h5 class="mb-2">个人中心</h5>
      <el-menu
        default-active="2"
        class="el-menu-vertical-demo"
        @open="handleOpen"
        @close="handleClose"
        unique-opened = true
      >
      <el-sub-menu index="1">
        <template #title>
          <el-icon><location /></el-icon>
          <span>详情管理</span>
        </template>
        <el-menu-item-group title="商品管理">
          <el-menu-item index="1-1">商品详情</el-menu-item>
          <el-menu-item index="1-2">供应商详情</el-menu-item>
        </el-menu-item-group>
        <el-menu-item-group title="用户管理">
          <el-menu-item index="1-3">用户详情</el-menu-item>
          <el-menu-item index="1-4">评论详情</el-menu-item>
        </el-menu-item-group>
        <el-menu-item-group title="商家管理">
          <el-menu-item index="1-5">商家详情</el-menu-item>
          <el-menu-item index="1-6">商家评价</el-menu-item>
        </el-menu-item-group>
      </el-sub-menu>
      <el-menu-item index="2">
        <el-icon><icon-menu /></el-icon>
        <span>个人资料</span>
        </el-menu-item>
      <el-sub-menu index="3">
        <template #title>
          <el-icon><location /></el-icon>
          <span>购物</span>
          </template>
          <el-menu-item-group>
            <el-menu-item index="1-1">购物车详情</el-menu-item>
            <el-menu-item index="1-2">订单详情</el-menu-item>
          </el-menu-item-group>
      </el-sub-menu>
      <el-menu-item index="4">
        <el-icon><setting /></el-icon>
        <span>首页</span>
        </el-menu-item>
      </el-menu>
    </el-col>
  </el-row>
</template>

<script setup>
import {
  Document,
  Menu as IconMenu,
  Location,
  Setting,
} from '@element-plus/icons-vue'

const handleOpen = (key, keyPath) => {
  console.log(key, keyPath)
}
const handleClose = (key, keyPath) => {
  console.log(key, keyPath)
}
</script>
