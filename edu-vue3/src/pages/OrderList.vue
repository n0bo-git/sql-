<template>
  <div class="page-wrap">
    <h2>订单详情</h2>
    <el-table :data="filteredList" border stripe v-loading="loading">
      <el-table-column prop="orderId" label="订单号" width="180" />
      <el-table-column prop="userId" label="用户ID" width="80" />
      <el-table-column prop="orderDate" label="下单日期" width="160" />
      <el-table-column prop="transportReq" label="运输要求" width="120" />
      <el-table-column label="供货" width="60">
        <template #default="{row}">{{ row.supplyFlag===1?'是':'否' }}</template>
      </el-table-column>
      <el-table-column prop="freight" label="运费" width="80" />
      <el-table-column prop="payList" label="付款" width="80" />
    </el-table>
    <el-empty v-if="!loading && filteredList.length===0" description="暂无订单" />
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'
import { getCurrentInstance } from 'vue'
import { useUserStore } from '@/stores/user'

const { proxy } = getCurrentInstance(); const $ = proxy.$request
const userStore = useUserStore()
const list = ref([]); const loading = ref(false)

const filteredList = computed(() => {
  // 管理员看全部，其他用户只看自己
  if (userStore.isAdmin) return list.value
  return list.value.filter(o => o.userId === userStore.userId)
})

onMounted(async () => {
  loading.value = true
  try { const r = await $.get('/order/list'); list.value = r.data||[] } finally { loading.value = false }
})
</script>
<style scoped>.page-wrap{padding:20px}</style>
