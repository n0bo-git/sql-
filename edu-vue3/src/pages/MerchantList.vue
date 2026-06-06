<template>
  <div class="page-wrap">
    <h2>商家详情</h2>
    <el-table :data="list" border stripe v-loading="loading">
      <el-table-column prop="manuCode" label="厂家编码" width="100" />
      <el-table-column prop="manuName" label="厂家名称" min-width="200" />
      <el-table-column prop="manuPhone" label="电话" width="160" />
    </el-table>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { getCurrentInstance } from 'vue'
const { proxy } = getCurrentInstance(); const $ = proxy.$request
const list = ref([]); const loading = ref(false)
onMounted(async () => { loading.value = true; try { const r = await $.get('/goods/manufacturers'); list.value = r.data||[] } finally { loading.value = false } })
</script>
<style scoped>.page-wrap{padding:20px}</style>
