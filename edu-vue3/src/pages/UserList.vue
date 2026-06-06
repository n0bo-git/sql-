<template>
  <div class="page-wrap">
    <h2>用户详情</h2>
    <el-table :data="list" border stripe v-loading="loading">
      <el-table-column prop="id" label="ID" width="60" />
      <el-table-column prop="username" label="用户名" width="120" />
      <el-table-column label="身份" width="100">
        <template #default="{row}">{{ ['管理员','商家','普通用户'][row.role]||'未知' }}</template>
      </el-table-column>
      <el-table-column prop="token" label="姓名" width="100" />
      <el-table-column prop="newPassword" label="电话" width="140" />
    </el-table>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { getCurrentInstance } from 'vue'
const { proxy } = getCurrentInstance(); const $ = proxy.$request
const list = ref([]); const loading = ref(false)
onMounted(async () => { loading.value = true; try { const r = await $.get('/user/list'); list.value = r.data||[] } finally { loading.value = false } })
</script>
<style scoped>.page-wrap{padding:20px}</style>
