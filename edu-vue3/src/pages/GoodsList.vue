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
        <el-form-item label="商品编码"><el-input v-model="form.goodsCode" disabled placeholder="自动生成" /></el-form-item>
        <el-form-item label="厂家">
          <div style="display:flex;gap:8px;width:100%">
            <el-select v-model="form.manuCode" placeholder="请选择厂家" style="flex:1">
              <el-option v-for="m in manufacturers" :key="m.manuCode" :label="`${m.manuName} (${m.manuCode})`" :value="m.manuCode" />
            </el-select>
            <el-button size="small" @click="openMfrDialog">+ 新增厂家</el-button>
          </div>
        </el-form-item>
        <el-form-item label="商品分类">
          <div style="display:flex;gap:8px;width:100%">
            <el-select v-model="form.categoryId" placeholder="请选择分类" style="flex:1" clearable>
              <el-option v-for="c in categories" :key="c.categoryId" :label="`${c.categoryName} (${c.categoryId})`" :value="c.categoryId" />
            </el-select>
            <el-button size="small" @click="openCatDialog">+ 新增分类</el-button>
          </div>
        </el-form-item>
        <el-form-item label="商品描述"><el-input v-model="form.goodsDesc" /></el-form-item>
        <el-form-item label="单价"><el-input-number v-model="form.unitPrice" :precision="2" :min="0" /></el-form-item>
        <el-form-item label="封面图片">
          <div style="display:flex;align-items:center;gap:12px">
            <img v-if="form.imageUrl" :src="form.imageUrl" style="width:120px;height:90px;object-fit:cover;border-radius:6px;border:1px solid #e5e7eb" />
            <span v-else style="color:#909399;font-size:13px">未上传</span>
            <el-upload
              :action="uploadUrl"
              :show-file-list="false"
              :on-success="onUploadSuccess"
              :before-upload="beforeUpload"
              accept="image/*"
            >
              <el-button size="small">上传图片</el-button>
            </el-upload>
          </div>
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="formVisible=false">取消</el-button>
        <el-button type="primary" @click="handleSave">{{ isEdit?'保存':'新增' }}</el-button>
      </template>
    </el-dialog>

    <!-- 新增厂家弹窗 -->
    <el-dialog v-model="mfrVisible" title="新增厂家" width="420px">
      <el-form :model="mfrForm" label-width="100px">
        <el-form-item label="厂家编码"><el-input v-model="mfrForm.manuCode" disabled /></el-form-item>
        <el-form-item label="厂家名称"><el-input v-model="mfrForm.manuName" placeholder="如 XX科技有限公司" /></el-form-item>
        <el-form-item label="联系电话"><el-input v-model="mfrForm.manuPhone" placeholder="如 010-12345678" /></el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="mfrVisible=false">取消</el-button>
        <el-button type="primary" @click="saveManufacturer">保存</el-button>
      </template>
    </el-dialog>

    <!-- 新增分类弹窗 -->
    <el-dialog v-model="catVisible" title="新增商品分类" width="420px">
      <el-form :model="catForm" label-width="100px">
        <el-form-item label="分类编号"><el-input v-model="catForm.categoryId" disabled /></el-form-item>
        <el-form-item label="分类名称"><el-input v-model="catForm.categoryName" placeholder="如 数码配件" /></el-form-item>
        <el-form-item label="排序号"><el-input-number v-model="catForm.sortOrder" :min="0" /></el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="catVisible=false">取消</el-button>
        <el-button type="primary" @click="saveCategory">保存</el-button>
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
const canEdit = computed(() => userStore.isAdmin)

const list = ref([]); const loading = ref(false)
const manufacturers = ref([])
const formVisible = ref(false); const isEdit = ref(false)
const form = reactive({ goodsCode:'',manuCode:'',categoryId:'',goodsDesc:'',unitPrice:0,imageUrl:'' })
const uploadUrl = 'http://localhost:9999/file/upload'

function beforeUpload(file) {
  const isImage = file.type.startsWith('image/')
  if (!isImage) ElMessage.error('只能上传图片文件')
  return isImage
}

function onUploadSuccess(response) {
  form.imageUrl = response.data
  ElMessage.success('图片上传成功')
}

// ========== 新增厂家 ==========
const mfrVisible = ref(false)
const mfrForm = reactive({ manuCode:'', manuName:'', manuPhone:'' })

function openMfrDialog() {
  const codes = manufacturers.value.map(m => {
    const n = parseInt(m.manuCode?.replace('M',''))
    return isNaN(n) ? 0 : n
  })
  const next = codes.length > 0 ? Math.max(...codes) + 1 : 1
  mfrForm.manuCode = 'M' + String(next).padStart(3, '0')
  mfrForm.manuName = ''; mfrForm.manuPhone = ''
  mfrVisible.value = true
}
// ========== 分类 ==========
const categories = ref([])
const catVisible = ref(false)
const catForm = reactive({ categoryId:'', categoryName:'', sortOrder:0 })

async function loadCategories() {
  try { const r = await $.get('/goods/categories'); categories.value = r.data||[] } catch {}
}

function openCatDialog() {
  const nums = categories.value.map(c => parseInt(c.categoryId?.replace('CAT',''))).filter(n => !isNaN(n))
  const next = nums.length > 0 ? Math.max(...nums) + 1 : 1
  catForm.categoryId = 'CAT' + String(next).padStart(2, '0')
  catForm.categoryName = ''
  catForm.sortOrder = categories.value.length + 1
  catVisible.value = true
}

async function saveCategory() {
  if (!catForm.categoryName) { ElMessage.warning('分类名称必填'); return }
  try {
    await $.post('/goods/category/add', { ...catForm })
    ElMessage.success('分类已添加'); catVisible.value = false
    form.categoryId = catForm.categoryId
    await loadCategories()
  } catch(e) { ElMessage.error('添加失败: ' + (e.message||'')) }
}

async function saveManufacturer() {
  if (!mfrForm.manuCode || !mfrForm.manuName) { ElMessage.warning('厂家编码和名称必填'); return }
  try {
    // 先尝试新增
    await $.post('/goods/manufacturer/add', { ...mfrForm })
  } catch(e) {
    // 已存在则更新
    try { await $.put('/goods/manufacturer/update', { ...mfrForm }) }
    catch(e2) { ElMessage.error('保存失败: ' + (e2.message||'')); return }
  }
  ElMessage.success('厂家已保存'); mfrVisible.value = false
  form.manuCode = mfrForm.manuCode
  Object.assign(mfrForm, { manuCode:'', manuName:'', manuPhone:'' })
  await loadManufacturers()
}

async function load() { loading.value = true; try { const r = await $.get('/goods/selectAll'); list.value = r.data||[] } finally { loading.value = false } }
async function loadManufacturers() { try { const r = await $.get('/goods/manufacturers'); manufacturers.value = r.data||[] } catch {} }

async function nextCode() {
  try {
    const r = await $.get('/goods/selectAll')
    const nums = (r.data||[]).map(g => { const m = g.goodsCode?.match(/^G(\d+)$/); return m ? parseInt(m[1]) : 0 }).filter(n => n > 0)
    return 'G' + String(nums.length > 0 ? Math.max(...nums)+1 : 1).padStart(3, '0')
  } catch { return 'G' + Date.now().toString(36).toUpperCase() }
}

async function openAdd() {
  isEdit.value = false
  form.goodsCode = await nextCode(); form.manuCode = manufacturers.value[0]?.manuCode || ''
  form.goodsDesc = ''; form.unitPrice = 0; form.imageUrl = ''; formVisible.value = true
}

function openEdit(row) { isEdit.value = true; Object.assign(form, row); formVisible.value = true }

async function handleDelete(row) {
  await ElMessageBox.confirm('确定删除？', '警告', { type:'warning' })
  try { await $.delete('/goods/delete/'+row.goodsCode); ElMessage.success('已删除'); load() } catch(e) { ElMessage.error(e.message) }
}

async function handleSave() {
  if (!form.manuCode) { ElMessage.warning('请选择厂家'); return }
  if (!form.goodsDesc.trim()) { ElMessage.warning('请输入描述'); return }
  const p = { goodsCode:form.goodsCode, manuCode:form.manuCode, categoryId:form.categoryId, goodsDesc:form.goodsDesc, unitPrice:form.unitPrice }
  try {
    if (isEdit.value) await $.put('/goods/update', p); else await $.post('/goods/add', p)
    // 如果有上传图片，保存到 goods_image
    if (form.imageUrl) {
      const imgId = 'IMG' + Date.now()
      await $.post('/goods/image/save', { imageId: imgId, goodsCode: form.goodsCode, imageUrl: form.imageUrl, isCover: 1, sortOrder: 1 })
    }
    ElMessage.success(isEdit.value?'已修改':'已新增'); formVisible.value = false; load()
  } catch(e) { ElMessage.error(e.message) }
}

onMounted(() => { load(); loadManufacturers(); loadCategories() })
</script>
<style scoped>.page-wrap{padding:20px}.page-header{display:flex;justify-content:space-between;align-items:center;margin-bottom:16px}</style>
