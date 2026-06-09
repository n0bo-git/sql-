<template>
  <div class="page-wrap">
    <h2>评论详情</h2>
    <el-table :data="list" border stripe v-loading="loading">
      <el-table-column prop="reviewCode" label="编号" width="100" />
      <el-table-column prop="goodsCode" label="商品" width="80" />
      <el-table-column prop="custName" label="用户" width="100" />
      <el-table-column prop="review" label="评论内容" min-width="250" />
      <el-table-column prop="reviewRating" label="评分" width="80" />
      <el-table-column prop="reviewTime" label="时间" width="160" />
      <el-table-column label="操作" width="80">
        <template #default="{row}">
          <el-button size="small" type="danger" @click="handleDelete(row)">删除</el-button>
        </template>
      </el-table-column>
    </el-table>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { ElMessage } from 'element-plus'
import { getCurrentInstance } from 'vue'
const { proxy } = getCurrentInstance(); const $ = proxy.$request
const list = ref([]); const loading = ref(false)
async function load() { loading.value = true; try { const r = await $.get('/review/page',{pageNum:1,pageSize:999}); list.value = r.data?.records||[] } finally { loading.value = false } }
async function handleDelete(row) { try { await $.delete('/review/delete/'+row.reviewCode); ElMessage.success('已删除'); load() } catch(e) { ElMessage.error(e.message) } }
onMounted(load)
</script>
<style scoped>.page-wrap{padding:20px}</style>
