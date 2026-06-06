<template>
  <div class="page-wrap">
    <h2>供应商详情</h2>
    <el-table :data="list" border stripe v-loading="loading">
      <el-table-column prop="supplierCode" label="编号" width="80" />
      <el-table-column prop="supplierName" label="名称" min-width="200" />
      <el-table-column prop="contactPerson" label="联系人" width="100" />
      <el-table-column prop="contactPhone" label="电话" width="140" />
      <el-table-column prop="supplyCategory" label="类别" width="100" />
      <el-table-column label="合作状态" width="100">
        <template #default="{row}">{{ row.cooperationStatus===1?'合作中':'已终止' }}</template>
      </el-table-column>
    </el-table>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { getCurrentInstance } from 'vue'
const { proxy } = getCurrentInstance(); const $ = proxy.$request
const list = ref([]); const loading = ref(false)
onMounted(async () => { loading.value = true; try { const r = await $.get('/supplier/selectAll'); list.value = r.data||[] } finally { loading.value = false } })
</script>
<style scoped>.page-wrap{padding:20px}</style>
