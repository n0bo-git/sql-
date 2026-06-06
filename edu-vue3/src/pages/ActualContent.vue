<template>
  <div>
    <!-- 余额面板 -->
    <transition name="fade-slide">
      <div v-if="userStore.showBalance" class="balance-panel">
        <div class="balance-card">
          <div class="balance-header">
            <h3>
              <el-icon><Wallet /></el-icon>
              我的余额
            </h3>
            <el-button text circle @click="userStore.showBalance = false">
              <el-icon><Close /></el-icon>
            </el-button>
          </div>
          <div class="balance-amount">¥{{ userStore.balance }}</div>
          <div class="balance-actions">
            <span class="recharge-label">充值方式：</span>
            <div class="recharge-buttons">
              <el-button type="success" @click="handleRecharge('微信')">
                <el-icon><ChatDotRound /></el-icon>
                微信
              </el-button>
              <el-button type="primary" @click="handleRecharge('支付宝')">
                <el-icon><CreditCard /></el-icon>
                支付宝
              </el-button>
              <el-button type="warning" @click="handleRecharge('银行卡')">
                <el-icon><Money /></el-icon>
                银行卡
              </el-button>
            </div>
          </div>
        </div>
      </div>
    </transition>

    <!-- 路由内容 -->
    <div class="content">
      <router-view></router-view>
    </div>
  </div>
</template>

<script setup>
import { ElMessage } from 'element-plus'
import { Wallet, Close, ChatDotRound, CreditCard, Money } from '@element-plus/icons-vue'
import { useUserStore } from '@/stores/user'

const userStore = useUserStore()

async function handleRecharge(method) {
  await userStore.recharge(1000)
  ElMessage.success(`${method}充值成功！余额 +¥1000，当前余额：¥${userStore.balance}`)
}
</script>

<style scoped>
/* ===== 余额面板 ===== */
.balance-panel {
  padding: 16px 20px;
}

.balance-card {
  background: #fff;
  border-radius: 12px;
  padding: 24px;
  box-shadow: 0 2px 12px rgba(0, 0, 0, 0.08);
  max-width: 480px;
}

.balance-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-bottom: 16px;
}

.balance-header h3 {
  margin: 0;
  font-size: 16px;
  color: #333;
  display: flex;
  align-items: center;
  gap: 8px;
}

.balance-amount {
  font-size: 36px;
  font-weight: 700;
  color: #303133;
  margin-bottom: 20px;
  padding-bottom: 16px;
  border-bottom: 1px solid #ebeef5;
}

.balance-actions {
  display: flex;
  flex-direction: column;
  gap: 12px;
}

.recharge-label {
  font-size: 14px;
  color: #909399;
}

.recharge-buttons {
  display: flex;
  gap: 12px;
  flex-wrap: wrap;
}

.recharge-buttons .el-button {
  flex: 1;
  min-width: 100px;
}

/* ===== 路由内容 ===== */
.content {
  padding: 0;
}

/* ===== 过渡动画 ===== */
.fade-slide-enter-active,
.fade-slide-leave-active {
  transition: all 0.3s ease;
}
.fade-slide-enter-from,
.fade-slide-leave-to {
  opacity: 0;
  transform: translateY(-10px);
}
</style>
