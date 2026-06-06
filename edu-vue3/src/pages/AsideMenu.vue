<template>
  <div class="aside-container">
    <div class="menu-area">
      <h5 class="mb-2">个人中心</h5>
      <el-menu default-active="2" class="el-menu-vertical-demo" unique-opened router>
        <el-sub-menu index="1" v-if="userStore.isAdmin || userStore.isMerchant">
          <template #title><el-icon><List /></el-icon><span>详情管理</span></template>
          <el-menu-item-group v-if="userStore.isAdmin || userStore.isMerchant" title="商品管理">
            <el-menu-item index="/home/goods/list">商品详情</el-menu-item>
            <el-menu-item index="/home/supplier/list">供应商详情</el-menu-item>
          </el-menu-item-group>
          <el-menu-item-group v-if="userStore.isAdmin" title="用户管理">
            <el-menu-item index="/home/user/list">用户详情</el-menu-item>
            <el-menu-item index="/home/review/list">评论详情</el-menu-item>
          </el-menu-item-group>
          <el-menu-item-group v-if="userStore.isAdmin" title="商家管理">
            <el-menu-item index="/home/merchant/list">商家详情</el-menu-item>
            <el-menu-item index="/home/merchant/review">商家评价</el-menu-item>
          </el-menu-item-group>
        </el-sub-menu>
        <el-menu-item index="/home/profile"><el-icon><User /></el-icon><span>个人资料</span></el-menu-item>
        <el-sub-menu index="3">
          <template #title><el-icon><ShoppingCart /></el-icon><span>购物</span></template>
          <el-menu-item-group>
            <el-menu-item index="/home/cart">购物车详情</el-menu-item>
            <el-menu-item index="/home/order/list">订单详情</el-menu-item>
          </el-menu-item-group>
        </el-sub-menu>
        <el-menu-item index="/"><el-icon><HomeFilled /></el-icon><span>首页</span></el-menu-item>
      </el-menu>
    </div>

    <div class="avatar-area">
      <el-dropdown trigger="click" @command="handleCommand">
        <span class="avatar-trigger">
          <el-avatar :size="36" :icon="UserFilled" />
          <span class="username">
            {{ userStore.email || '未登录' }}
            <span class="role-badge">{{ ['管理员','商家','用户'][userStore.role] }}</span>
          </span>
          <el-icon class="arrow-icon"><ArrowDown /></el-icon>
        </span>
        <template #dropdown>
          <el-dropdown-menu>
            <el-dropdown-item command="balance">
              <el-icon><Wallet /></el-icon>余额: ¥{{ userStore.balance }}
            </el-dropdown-item>
            <el-dropdown-item command="recharge">
              <el-icon><Money /></el-icon>充值
            </el-dropdown-item>
            <el-dropdown-item command="logout" divided>
              <el-icon><SwitchButton /></el-icon>登出
            </el-dropdown-item>
          </el-dropdown-menu>
        </template>
      </el-dropdown>
    </div>

    <!-- 充值弹窗 -->
    <el-dialog v-model="rechargeVisible" title="余额充值" width="400px" :close-on-click-modal="false">
      <div class="recharge-box">
        <p class="recharge-info">当前余额：<b>¥{{ userStore.balance }}</b></p>
        <div class="recharge-amounts">
          <el-button v-for="amt in [100,500,1000,5000]" :key="amt"
            :type="amount===amt?'primary':''" @click="amount=amt">¥{{ amt }}</el-button>
        </div>
        <el-input-number v-model="amount" :min="1" :max="99999" style="width:100%;margin-top:12px" placeholder="自定义金额" />
        <div class="recharge-methods">
          <span style="margin-right:8px">方式：</span>
          <el-radio-group v-model="method">
            <el-radio label="威信">威信</el-radio>
            <el-radio label="致富宝">致富宝</el-radio>
            <el-radio label="英航卡">英航卡</el-radio>
          </el-radio-group>
        </div>
      </div>
      <template #footer>
        <el-button @click="rechargeVisible=false">取消</el-button>
        <el-button type="primary" :loading="recharging" @click="handleRecharge">确认充值 ¥{{ amount }}</el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script setup>
import { ref } from 'vue'
import { useRouter } from 'vue-router'
import { ElMessage } from 'element-plus'
import { List, User, ShoppingCart, HomeFilled, UserFilled, ArrowDown, Wallet, SwitchButton, Money } from '@element-plus/icons-vue'
import { useUserStore } from '@/stores/user'

const router = useRouter()
const userStore = useUserStore()

const rechargeVisible = ref(false)
const amount = ref(1000)
const method = ref('威信')
const recharging = ref(false)

function handleCommand(command) {
  if (command === 'balance') { userStore.toggleBalance() }
  else if (command === 'recharge') { rechargeVisible.value = true }
  else if (command === 'logout') { userStore.logout(); router.push('/login') }
}

async function handleRecharge() {
  recharging.value = true
  try {
    await userStore.recharge(amount.value)
    ElMessage.success(`${method.value}充值成功！余额 +¥${amount.value}，当前余额：¥${userStore.balance}`)
    rechargeVisible.value = false
  } catch { ElMessage.error('充值失败') }
  finally { recharging.value = false }
}
</script>

<style scoped>
.aside-container { display: flex; flex-direction: column; height: 100%; background: #fff; }
.menu-area { flex: 1; overflow-y: auto; }
.menu-area h5 { padding: 16px 20px 8px; margin: 0; font-size: 14px; color: #909399; }
.avatar-area { padding: 16px 12px; border-top: 1px solid #ebeef5; display: flex; justify-content: center; }
.avatar-trigger { display: flex; align-items: center; gap: 8px; cursor: pointer; padding: 6px 10px; border-radius: 8px; transition: background 0.2s; }
.avatar-trigger:hover { background: #f5f7fa; }
.username { font-size: 13px; color: #303133; max-width: 100px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap; }
.role-badge { font-size: 10px; color: #8b5cf6; margin-left: 4px; }
.arrow-icon { font-size: 12px; color: #909399; transition: transform 0.2s; }
.recharge-box { text-align: center; }
.recharge-info { font-size: 16px; margin-bottom: 16px; }
.recharge-info b { color: #16a34a; font-size: 20px; }
.recharge-amounts { display: flex; gap: 8px; justify-content: center; flex-wrap: wrap; }
.recharge-methods { margin-top: 16px; display: flex; align-items: center; justify-content: center; }
</style>
