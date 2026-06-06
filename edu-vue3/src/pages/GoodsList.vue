<template>
  <div class="page-wrap">
    <div class="page-header">
      <h2>商品管理</h2>
      <el-button v-if="canEdit" type="primary" @click="openAdd"><el-icon><Plus /></el-icon>新增商品</el-button>
    </div>
    <el-table :data="list" border stripe v-loading="loading">
      <el-table-column prop="goodsCode" label="商品编码" width="100" />
      <el-table-column prop="goodsDesc" label="描述" min-width="200" />
      <el-table-column prop="manuCode" label="厂家" width="100" />
      <el-table-column prop="unitPrice" label="单价" width="100" />
      <el-table-column v-if="canEdit" label="操作" width="160">
        <template #default="{row}">
          <el-button size="small" @click="openEdit(row)">编辑</el-button>
          <el-button size="small" type="danger" @click="handleDelete(row)">删除</el-button>
        </template>
      </el-table-column>
    </el-table>

    <el-dialog v-if="canEdit" v-model="formVisible" :title="isEdit?'编辑商品':'新增商品'" width="500px">
      <el-form :model="form" label-width="100px">
        <el-form-item label="商品编码"><el-input v-model="form.goodsCode" :disabled="isEdit" /></el-form-item>
        <el-form-item label="厂家编码"><el-input v-model="form.manuCode" /></el-form-item>
        <el-form-item label="商品描述"><el-input v-model="form.goodsDesc" /></el-form-item>
        <el-form-item label="单价"><el-input-number v-model="form.unitPrice" :precision="2" :min="0" /></el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="formVisible=false">取消</el-button>
        <el-button type="primary" @click="handleSave">{{ isEdit?'保存':'新增' }}</el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script setup>
import { ref, reactive, computed, onMounted } from 'vue'
import { ElMessage, ElMessageBox } from 'element-plus'
import { Plus } from '@element-plus/icons-vue'
import { getCurrentInstance } from 'vue'
import { useUserStore } from '@/stores/user'

const { proxy } = getCurrentInstance(); const $ = proxy.$request
const userStore = useUserStore()
const canEdit = computed(() => userStore.isAdmin || userStore.isMerchant)

const list = ref([]); const loading = ref(false)
const formVisible = ref(false); const isEdit = ref(false)
const form = reactive({ goodsCode:'',manuCode:'',goodsDesc:'',unitPrice:0 })

async function load() { loading.value = true; try { const r = await $.get('/goods/selectAll'); list.value = r.data||[] } finally { loading.value = false } }
function openAdd() { isEdit.value = false; Object.assign(form, { goodsCode:'',manuCode:'',goodsDesc:'',unitPrice:0 }); formVisible.value = true }
function openEdit(row) { isEdit.value = true; Object.assign(form, row); formVisible.value = true }
async function handleDelete(row) {
  await ElMessageBox.confirm('确定删除该商品？', '警告', { type:'warning' })
  try { await $.delete('/goods/delete/'+row.goodsCode); ElMessage.success('已删除'); load() } catch(e) { ElMessage.error(e.message) }
}
async function handleSave() {
  try {
    if (isEdit.value) await $.put('/goods/update', {...form}); else await $.post('/goods/add', {...form})
    ElMessage.success(isEdit.value?'已修改':'已新增'); formVisible.value = false; load()
  } catch(e) { ElMessage.error(e.message) }
}
onMounted(load)
</script>
<style scoped>.page-wrap{padding:20px}.page-header{display:flex;justify-content:space-between;align-items:center;margin-bottom:16px}</style>
