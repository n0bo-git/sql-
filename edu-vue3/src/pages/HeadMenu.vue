<template>
  <div class="head-menu">
    <h2>头导航</h2>
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
import { UserFilled, ArrowDown, Wallet, SwitchButton } from '@element-plus/icons-vue'
import { useUserStore } from '@/stores/user'

const router = useRouter()
const userStore = useUserStore()

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
.head-menu {
  display: flex;
  align-items: center;
  justify-content: space-between;
  height: 100%;
  padding: 0 24px;
  color: #fff;
}

.head-menu h2 {
  margin: 0;
  font-size: 18px;
}

.avatar-area {
  display: flex;
  align-items: center;
}

.avatar-trigger {
  display: flex;
  align-items: center;
  gap: 8px;
  cursor: pointer;
  padding: 4px 8px;
  border-radius: 8px;
  transition: background 0.2s;
}

.avatar-trigger:hover {
  background: rgba(255, 255, 255, 0.15);
}

.username {
  font-size: 14px;
  max-width: 120px;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

.arrow-icon {
  font-size: 12px;
  transition: transform 0.2s;
}
</style>
