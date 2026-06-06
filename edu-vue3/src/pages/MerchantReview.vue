<template>
  <div class="page-wrap">
    <h2>商家评价</h2>
    <el-table :data="list" border stripe v-loading="loading">
      <el-table-column prop="reviewId" label="编号" width="80" />
      <el-table-column prop="targetType" label="类型" width="100" />
      <el-table-column prop="targetCode" label="对象编号" width="100" />
      <el-table-column prop="reviewContent" label="评价内容" min-width="250" />
      <el-table-column prop="rating" label="评分" width="80" />
      <el-table-column prop="reviewTime" label="时间" width="160" />
    </el-table>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { getCurrentInstance } from 'vue'
const { proxy } = getCurrentInstance(); const $ = proxy.$request
const list = ref([]); const loading = ref(false)
onMounted(async () => { loading.value = true; try { const r = await $.get('/merchant/review'); list.value = r.data||[] } finally { loading.value = false } })
</script>
<style scoped>.page-wrap{padding:20px}</style>
