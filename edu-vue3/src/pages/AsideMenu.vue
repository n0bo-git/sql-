<template>
  <div class="aside-container">
    <!-- 菜单区域 -->
    <div class="menu-area">
      <h5 class="mb-2">个人中心</h5>
      <el-menu
        default-active="2"
        class="el-menu-vertical-demo"
        @open="handleOpen"
        @close="handleClose"
        unique-opened
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
    </div>

    <!-- 头像区域 - 固定在侧边栏底部 -->
    <div class="avatar-area">
      <el-dropdown trigger="click" @command="handleCommand">
        <span class="avatar-trigger">
          <el-avatar :size="36" :icon="UserFilled" />
          <span class="username">{{ userStore.email || '未登录' }}</span>
          <el-icon class="arrow-icon"><ArrowDown /></el-icon>
        </span>
        <template #dropdown>
          <el-dropdown-menu>
            <el-dropdown-item command="balance">
              <el-icon><Wallet /></el-icon>
              余额: ¥{{ userStore.balance }}
            </el-dropdown-item>
            <el-dropdown-item command="logout" divided>
              <el-icon><SwitchButton /></el-icon>
              登出
            </el-dropdown-item>
          </el-dropdown-menu>
        </template>
      </el-dropdown>
    </div>
  </div>
</template>

<script setup>
import { useRouter } from 'vue-router'
import {
  Document,
  Menu as IconMenu,
  Location,
  Setting,
  UserFilled,
  ArrowDown,
  Wallet,
  SwitchButton,
} from '@element-plus/icons-vue'
import { useUserStore } from '@/stores/user'

const router = useRouter()
const userStore = useUserStore()

function handleOpen(key, keyPath) {
  console.log(key, keyPath)
}
function handleClose(key, keyPath) {
  console.log(key, keyPath)
}

function handleCommand(command) {
  if (command === 'balance') {
    userStore.toggleBalance()
  } else if (command === 'logout') {
    userStore.logout()
    router.push('/login')
  }
}
</script>

<style scoped>
.aside-container {
  display: flex;
  flex-direction: column;
  height: 100%;
  background: #fff;
}

.menu-area {
  flex: 1;
  overflow-y: auto;
}

.menu-area h5 {
  padding: 16px 20px 8px;
  margin: 0;
  font-size: 14px;
  color: #909399;
}

.avatar-area {
  padding: 16px 12px;
  border-top: 1px solid #ebeef5;
  display: flex;
  justify-content: center;
}

.avatar-trigger {
  display: flex;
  align-items: center;
  gap: 8px;
  cursor: pointer;
  padding: 6px 10px;
  border-radius: 8px;
  transition: background 0.2s;
}

.avatar-trigger:hover {
  background: #f5f7fa;
}

.username {
  font-size: 13px;
  color: #303133;
  max-width: 80px;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

.arrow-icon {
  font-size: 12px;
  color: #909399;
  transition: transform 0.2s;
}
</style>
