<template>
  <div class="page-wrap">
    <div class="page-header">
      <h2>购物车</h2>
      <div v-if="selected.length > 0" class="pay-area">
        <span class="total-text">合计：<b>¥{{ totalPrice }}</b>（{{ selected.length }}件）</span>
        <el-button type="danger" size="large" @click="handlePay" :loading="paying">
          <el-icon><Money /></el-icon>立即支付
        </el-button>
      </div>
    </div>

    <el-table :data="list" border stripe v-loading="loading" @selection-change="onSelectionChange" ref="tableRef">
      <el-table-column type="selection" width="50" />
      <el-table-column prop="cartCode" label="编号" width="160" />
      <el-table-column prop="goodsCode" label="商品编码" width="100" />
      <el-table-column prop="quantity" label="数量" width="80" />
      <el-table-column prop="unitPrice" label="单价" width="100" />
      <el-table-column prop="totalPrice" label="小计" width="100">
        <template #default="{row}"><b style="color:#ef4444">¥{{ row.totalPrice }}</b></template>
      </el-table-column>
      <el-table-column prop="addTime" label="添加时间" width="160" />
      <el-table-column label="操作" width="80">
        <template #default="{row}">
          <el-button size="small" type="danger" @click="handleDelete(row)">删除</el-button>
        </template>
      </el-table-column>
    </el-table>

    <el-empty v-if="!loading && list.length===0" description="购物车为空">
      <el-button type="primary" @click="$router.push('/')">去逛逛</el-button>
    </el-empty>

    <div v-if="userStore.isLoggedIn" class="balance-bar">
      当前余额：<b style="color:#16a34a">¥{{ balance }}</b>
      <span style="color:#909399;font-size:12px;margin-left:8px">用户ID: {{ userStore.userId }}</span>
      <el-button size="small" text @click="refreshBalance">刷新</el-button>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'
import { ElMessage, ElMessageBox } from 'element-plus'
import { Money } from '@element-plus/icons-vue'
import { getCurrentInstance } from 'vue'
import { useUserStore } from '@/stores/user'

const { proxy } = getCurrentInstance(); const $ = proxy.$request
const userStore = useUserStore()

const list = ref([]); const loading = ref(false); const paying = ref(false)
const selected = ref([]); const tableRef = ref(null)
const balance = ref(0)

const totalPrice = computed(() =>
  selected.value.reduce((sum, row) => sum + (Number(row.totalPrice)||0), 0).toFixed(2)
)

async function load() {
  loading.value = true
  try {
    const r = await $.get('/cart/selectAll')
    const all = r.data || []
    console.log('[Cart] 全部购物车:', all.length, '条, 当前userId:', userStore.userId, 'isLoggedIn:', userStore.isLoggedIn)
    // 管理员看全部，其他只看自己
    if (userStore.isAdmin) {
      list.value = all
    } else if (userStore.isLoggedIn) {
      list.value = all.filter(c => Number(c.userId) === Number(userStore.userId))
    } else {
      list.value = all
    }
    console.log('[Cart] 过滤后:', list.value.length, '条')
  } catch(e) {
    console.error('[Cart] 加载失败:', e)
    ElMessage.error('加载购物车失败: ' + (e.message || ''))
  } finally { loading.value = false }
}

async function refreshBalance() {
  try {
    const r = await $.get('/usermessage/selectByUserId/' + userStore.userId)
    console.log('[Cart] 余额查询:', r.data)
    if (r.data) balance.value = r.data.balance || 0
  } catch(e) { console.error('[Cart] 余额失败:', e) }
}

function onSelectionChange(rows) { selected.value = rows }

async function handleDelete(row) {
  try { await $.delete('/cart/delete/' + row.cartCode); ElMessage.success('已删除'); load() }
  catch(e) { ElMessage.error(e.message) }
}

async function handlePay() {
  if (selected.value.length === 0) { ElMessage.warning('请选择要支付的商品'); return }
  if (!userStore.isLoggedIn) { ElMessage.warning('请先登录'); return }
  try {
    await ElMessageBox.confirm(
      `确认支付 ¥${totalPrice.value}？将从余额中扣除。`, '确认付款',
      { confirmButtonText: '确认支付', cancelButtonText: '取消', type: 'warning' }
    )
  } catch { return }

  paying.value = true
  try {
    const cartCodes = selected.value.map(r => r.cartCode)
    console.log('[Cart] 支付请求:', { userId: userStore.userId, cartCodes })
    const r = await $.post('/cart/pay', { userId: userStore.userId, cartCodes })
    ElMessage.success(r.msg || '支付成功')
    refreshBalance(); await load(); selected.value = []
  } catch(e) { ElMessage.error(e.message || '支付失败') }
  finally { paying.value = false }
}

onMounted(() => { load(); if (userStore.isLoggedIn) refreshBalance() })
</script>
<style scoped>
.page-wrap{padding:20px}
.page-header{display:flex;justify-content:space-between;align-items:center;margin-bottom:16px;flex-wrap:wrap;gap:12px}
.pay-area{display:flex;align-items:center;gap:16px}
.total-text{font-size:16px}
.total-text b{color:#ef4444;font-size:20px}
.balance-bar{margin-top:20px;padding:12px 16px;background:#f0fdf4;border-radius:8px;font-size:15px}
</style>
