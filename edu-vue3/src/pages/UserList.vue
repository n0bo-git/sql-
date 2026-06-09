<template>
  <div class="page-wrap">
    <h2>用户管理</h2>
    <el-table :data="list" border stripe v-loading="loading">
      <el-table-column prop="id" label="ID" width="60" />
      <el-table-column prop="username" label="用户名" width="120" />
      <el-table-column label="身份" width="160">
        <template #default="{row}">
          <el-select v-model="row.role" size="small" @change="(v) => changeRole(row, v)" :disabled="row.id===userStore.userId">
            <el-option :value="0" label="管理员" />
            <el-option :value="2" label="普通用户" />
          </el-select>
        </template>
      </el-table-column>
      <el-table-column prop="token" label="姓名" width="100" />
      <el-table-column prop="newPassword" label="电话" width="140" />
    </el-table>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { ElMessage } from 'element-plus'
import { getCurrentInstance } from 'vue'
import { useUserStore } from '@/stores/user'

const { proxy } = getCurrentInstance(); const $ = proxy.$request
const userStore = useUserStore()
const list = ref([]); const loading = ref(false)

async function load() {
  loading.value = true
  try { const r = await $.get('/user/list'); list.value = r.data||[] } finally { loading.value = false }
}

async function changeRole(row, newRole) {
  try {
    await $.put('/user/role', { userId: row.id, role: newRole })
    ElMessage.success(`已将 ${row.username} 设为 ${['管理员','商家','用户'][newRole]}`)
    load()
  } catch(e) { ElMessage.error(e.message); load() }
}

onMounted(load)
</script>
<style scoped>.page-wrap{padding:20px}</style>
