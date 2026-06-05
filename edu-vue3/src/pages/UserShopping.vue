<template>
  <div class="shopping-page">
    <!-- ===== 顶部搜索栏 ===== -->
    <div class="search-bar">
      <div class="search-input-wrap">
        <el-input
          v-model="keyword"
          placeholder="搜索商品名称或品牌..."
          size="large"
          clearable
          @keyup.enter="handleSearch"
          @clear="handleSearch"
        >
          <template #prefix>
            <el-icon><Search /></el-icon>
          </template>
        </el-input>
        <el-button type="primary" size="large" @click="handleSearch">
          <el-icon><Search /></el-icon>
          搜索
        </el-button>
      </div>
      <el-select
        v-model="categoryId"
        placeholder="全部分类"
        size="large"
        clearable
        style="width: 180px"
        @change="handleSearch"
      >
        <el-option label="全部分类" value="" />
        <el-option label="手机通讯" value="CAT03" />
        <el-option label="电脑办公" value="CAT04" />
        <el-option label="智能穿戴" value="CAT05" />
        <el-option label="厨房电器" value="CAT06" />
        <el-option label="生活电器" value="CAT07" />
        <el-option label="空调" value="CAT08" />
      </el-select>
      <el-button type="success" size="large" @click="openAddDialog">
        <el-icon><Plus /></el-icon>
        新增商品
      </el-button>
    </div>

    <!-- ===== 加载状态 ===== -->
    <div v-if="loading" class="loading-wrap">
      <el-icon class="loading-icon" :size="40"><Loading /></el-icon>
      <p>加载中...</p>
    </div>

    <!-- ===== 商品列表 ===== -->
    <div v-else class="goods-grid">
      <div v-for="goods in goodsList" :key="goods.goodsCode" class="goods-card">
        <!-- 管理按钮 -->
        <div class="card-actions">
          <el-button circle size="small" type="primary" @click.stop="openEditDialog(goods)">
            <el-icon><Edit /></el-icon>
          </el-button>
          <el-button circle size="small" type="danger" @click.stop="handleDelete(goods)">
            <el-icon><Delete /></el-icon>
          </el-button>
        </div>
        <div class="card-image" @click="openDetail(goods)">
          <img
            v-if="hasValidImage(goods)"
            :src="getImageUrl(goods.coverImage)"
            :alt="goods.goodsDesc"
            @error="onImgError(goods)"
          />
          <div v-else class="img-placeholder" :style="placeholderStyle(goods.goodsCode)">
            <el-icon :size="48"><PictureFilled /></el-icon>
            <span>暂无图片</span>
          </div>
          <div class="card-category-tag">{{ getCategoryName(goods.categoryId) }}</div>
        </div>
        <div class="card-body">
          <h3 class="card-title" @click="openDetail(goods)">{{ goods.goodsDesc }}</h3>
          <div class="card-brand">
            <el-icon><Shop /></el-icon>
            <span>{{ goods.manuName }}</span>
          </div>
          <div class="card-rating" v-if="goods.avgRating > 0">
            <el-rate :model-value="goods.avgRating" disabled show-score text-color="#ff9900" />
            <span class="review-count">({{ goods.reviews?.length || 0 }}条评论)</span>
          </div>
          <div class="card-bottom">
            <span class="card-price">¥{{ goods.unitPrice }}</span>
            <el-button type="danger" size="small" round @click="openCartDialog(goods)">
              <el-icon><ShoppingCart /></el-icon>
              加入购物车
            </el-button>
          </div>
        </div>
      </div>

      <!-- 空状态 -->
      <div v-if="goodsList.length === 0" class="empty-wrap">
        <el-empty description="暂无商品" />
      </div>
    </div>

    <!-- ===== 分页 ===== -->
    <div class="pagination-wrap" v-if="total > 0">
      <el-pagination
        v-model:current-page="pageNum"
        :page-size="pageSize"
        :total="total"
        layout="total, prev, pager, next, jumper"
        background
        @current-change="loadGoods"
      />
    </div>

    <!-- ===== 新增/编辑弹窗 ===== -->
    <el-dialog
      v-model="formVisible"
      :title="isEdit ? '编辑商品' : '新增商品'"
      width="540px"
      :close-on-click-modal="false"
      class="form-dialog"
      @closed="resetForm"
    >
      <el-form ref="formRef" :model="form" :rules="formRules" label-width="100px" label-position="left">
        <el-form-item label="商品编码" prop="goodsCode">
          <el-input v-model="form.goodsCode" placeholder="如 G013" :disabled="isEdit" />
        </el-form-item>
        <el-form-item label="厂家编码" prop="manuCode">
          <el-select v-model="form.manuCode" placeholder="请选择厂家" style="width: 100%">
            <el-option label="华为 (M001)" value="M001" />
            <el-option label="小米 (M002)" value="M002" />
            <el-option label="格力 (M003)" value="M003" />
            <el-option label="海尔 (M004)" value="M004" />
            <el-option label="比亚迪 (M005)" value="M005" />
            <el-option label="联想 (M006)" value="M006" />
            <el-option label="大疆 (M007)" value="M007" />
          </el-select>
        </el-form-item>
        <el-form-item label="商品分类" prop="categoryId">
          <el-select v-model="form.categoryId" placeholder="请选择分类" style="width: 100%">
            <el-option label="手机通讯 (CAT03)" value="CAT03" />
            <el-option label="电脑办公 (CAT04)" value="CAT04" />
            <el-option label="智能穿戴 (CAT05)" value="CAT05" />
            <el-option label="厨房电器 (CAT06)" value="CAT06" />
            <el-option label="生活电器 (CAT07)" value="CAT07" />
            <el-option label="空调 (CAT08)" value="CAT08" />
          </el-select>
        </el-form-item>
        <el-form-item label="商品描述" prop="goodsDesc">
          <el-input
            v-model="form.goodsDesc"
            type="textarea"
            :rows="3"
            placeholder="请输入商品描述"
          />
        </el-form-item>
        <el-form-item label="单价 (¥)" prop="unitPrice">
          <el-input-number
            v-model="form.unitPrice"
            :precision="2"
            :min="0.01"
            :max="999999"
            style="width: 100%"
          />
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button size="large" @click="formVisible = false">取消</el-button>
        <el-button type="primary" size="large" :loading="formLoading" @click="handleFormSubmit">
          {{ isEdit ? '保存修改' : '确认新增' }}
        </el-button>
      </template>
    </el-dialog>

    <!-- ===== 商品详情弹窗（含评论） ===== -->
    <el-dialog
      v-model="detailVisible"
      :title="currentGoods?.goodsDesc"
      width="680px"
      :close-on-click-modal="false"
      class="detail-dialog"
    >
      <div v-if="currentGoods" class="detail-content">
        <div class="detail-top">
          <img
            v-if="hasValidImage(currentGoods)"
            :src="getImageUrl(currentGoods.coverImage)"
            :alt="currentGoods.goodsDesc"
            class="detail-image"
            @error="onImgError(currentGoods)"
          />
          <div v-else class="img-placeholder detail-placeholder" :style="placeholderStyle(currentGoods.goodsCode)">
            <el-icon :size="64"><PictureFilled /></el-icon>
            <span>暂无图片</span>
          </div>
          <div class="detail-info">
            <h2>{{ currentGoods.goodsDesc }}</h2>
            <p class="detail-brand">
              <el-icon><Shop /></el-icon>
              品牌/厂家：{{ currentGoods.manuName }}
            </p>
            <p class="detail-price">¥{{ currentGoods.unitPrice }}</p>
            <div v-if="currentGoods.avgRating > 0" class="detail-rating">
              <el-rate :model-value="currentGoods.avgRating" disabled show-score />
              <span>（{{ currentGoods.reviews?.length || 0 }} 条评价）</span>
            </div>
            <div class="detail-actions">
              <el-button type="danger" size="large" @click="detailVisible = false; openCartDialog(currentGoods)">
                <el-icon><ShoppingCart /></el-icon>
                加入购物车
              </el-button>
              <el-button size="large" @click="detailVisible = false; openEditDialog(currentGoods)">
                <el-icon><Edit /></el-icon>
                编辑
              </el-button>
            </div>
          </div>
        </div>

        <!-- 买家评论 -->
        <div class="review-section">
          <h3>
            <el-icon><ChatDotRound /></el-icon>
            买家评论（{{ currentGoods.reviews?.length || 0 }}）
          </h3>
          <div v-if="currentGoods.reviews && currentGoods.reviews.length > 0" class="review-list">
            <div v-for="rv in currentGoods.reviews" :key="rv.reviewCode" class="review-item">
              <div class="review-header">
                <el-avatar :size="32" :icon="UserFilled" />
                <span class="review-user">{{ rv.custName }}</span>
                <el-rate :model-value="rv.reviewRating" disabled size="small" />
                <span class="review-time">{{ formatTime(rv.reviewTime) }}</span>
              </div>
              <p class="review-text">{{ rv.review }}</p>
            </div>
          </div>
          <el-empty v-else description="暂无评论" :image-size="60" />
        </div>
      </div>
    </el-dialog>

    <!-- ===== 加入购物车弹窗 ===== -->
    <el-dialog
      v-model="cartVisible"
      title="加入购物车"
      width="420px"
      :close-on-click-modal="false"
      class="cart-dialog"
    >
      <div v-if="cartGoods" class="cart-content">
        <div class="cart-goods-info">
          <img
            v-if="hasValidImage(cartGoods)"
            :src="getImageUrl(cartGoods.coverImage)"
            :alt="cartGoods.goodsDesc"
            class="cart-goods-img"
            @error="onImgError(cartGoods)"
          />
          <div v-else class="img-placeholder cart-placeholder" :style="placeholderStyle(cartGoods.goodsCode)">
            <el-icon :size="36"><PictureFilled /></el-icon>
            <span>暂无图片</span>
          </div>
          <div>
            <p class="cart-goods-name">{{ cartGoods.goodsDesc }}</p>
            <p class="cart-goods-price">¥{{ cartGoods.unitPrice }}</p>
          </div>
        </div>
        <div class="cart-quantity">
          <span>数量：</span>
          <el-input-number v-model="cartQuantity" :min="1" :max="99" size="large" />
        </div>
        <p class="cart-total">
          小计：<span class="total-price">¥{{ (cartGoods.unitPrice * cartQuantity).toFixed(2) }}</span>
        </p>
      </div>
      <template #footer>
        <el-button size="large" @click="cartVisible = false">取消</el-button>
        <el-button type="primary" size="large" :loading="cartLoading" @click="confirmAddCart">
          确认加入
        </el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script setup>
import { ref, reactive, onMounted } from 'vue'
import { ElMessage, ElMessageBox } from 'element-plus'
import {
  Search, Loading, Shop, ShoppingCart, ChatDotRound, UserFilled, Plus, Edit, Delete, PictureFilled
} from '@element-plus/icons-vue'
import { getCurrentInstance } from 'vue'

const { proxy } = getCurrentInstance()
const $request = proxy.$request

// ========== 查询参数 ==========
const keyword = ref('')
const categoryId = ref('')
const pageNum = ref(1)
const pageSize = ref(8)
const total = ref(0)
const loading = ref(false)

const goodsList = ref([])

// ========== 分类映射 ==========
const categoryMap = {
  'CAT03': '手机通讯', 'CAT04': '电脑办公', 'CAT05': '智能穿戴',
  'CAT06': '厨房电器', 'CAT07': '生活电器', 'CAT08': '空调'
}
function getCategoryName(id) {
  return categoryMap[id] || '电子产品'
}

// ========== 图片处理 ==========
// 记录每个商品图片是否加载失败
const imgErrors = reactive({})

function hasValidImage(goods) {
  if (!goods) return false
  if (!goods.coverImage) return false
  if (imgErrors[goods.goodsCode]) return false
  return true
}

function getImageUrl(url) {
  if (!url) return ''
  if (url.startsWith('http')) return url
  return `http://localhost:9999${url}`
}

function onImgError(goods) {
  imgErrors[goods.goodsCode] = true
}

// 占位图配色（不同编码不同颜色，避免千篇一律）
const placeholderColors = [
  { bg: '#f0f9ff', icon: '#0369a1' },
  { bg: '#fef2f2', icon: '#dc2626' },
  { bg: '#f0fdf4', icon: '#16a34a' },
  { bg: '#fff7ed', icon: '#ea580c' },
  { bg: '#fdf4ff', icon: '#a21caf' },
  { bg: '#ecfeff', icon: '#0891b2' },
  { bg: '#fefce8', icon: '#ca8a04' },
  { bg: '#f5f3ff', icon: '#7c3aed' },
]
function placeholderStyle(code) {
  // 根据商品编码取模选色
  let hash = 0
  for (let i = 0; i < (code || '').length; i++) {
    hash = (hash * 31 + code.charCodeAt(i)) >>> 0
  }
  const c = placeholderColors[hash % placeholderColors.length]
  return { backgroundColor: c.bg, color: c.icon }
}

// ========== 加载商品 ==========
async function loadGoods() {
  loading.value = true
  try {
    const res = await $request.get('/goods/page', {
      pageNum: pageNum.value,
      pageSize: pageSize.value,
      keyword: keyword.value,
      categoryId: categoryId.value,
    })
    if (res.data) {
      goodsList.value = res.data.records || []
      total.value = res.data.total || 0
    }
  } catch (e) {
    console.error('[加载商品]', e)
    ElMessage.error('加载商品失败：' + (e.message || '网络错误'))
  } finally {
    loading.value = false
  }
}

function handleSearch() {
  pageNum.value = 1
  loadGoods()
}

// ========== 新增 / 编辑弹窗 ==========
const formVisible = ref(false)
const isEdit = ref(false)
const formLoading = ref(false)
const formRef = ref(null)

const defaultForm = {
  goodsCode: '',
  manuCode: '',
  categoryId: '',
  goodsDesc: '',
  unitPrice: 0.01,
}
const form = reactive({ ...defaultForm })

const formRules = {
  goodsCode: [
    { required: true, message: '请输入商品编码', trigger: 'blur' },
  ],
  manuCode: [
    { required: true, message: '请选择厂家', trigger: 'change' },
  ],
  categoryId: [
    { required: true, message: '请选择分类', trigger: 'change' },
  ],
  goodsDesc: [
    { required: true, message: '请输入商品描述', trigger: 'blur' },
  ],
}

function openAddDialog() {
  isEdit.value = false
  Object.assign(form, { ...defaultForm })
  formVisible.value = true
}

function openEditDialog(goods) {
  isEdit.value = true
  // 从已有数据填充表单
  form.goodsCode = goods.goodsCode
  form.manuCode = goods.manuCode
  form.categoryId = goods.categoryId
  form.goodsDesc = goods.goodsDesc
  form.unitPrice = Number(goods.unitPrice) || 0.01
  formVisible.value = true
}

function resetForm() {
  formRef.value?.resetFields()
  Object.assign(form, { ...defaultForm })
}

async function handleFormSubmit() {
  if (!formRef.value) return
  try {
    await formRef.value.validate()
  } catch {
    return
  }

  formLoading.value = true
  try {
    const payload = {
      goodsCode: form.goodsCode,
      manuCode: form.manuCode,
      categoryId: form.categoryId,
      goodsDesc: form.goodsDesc,
      unitPrice: form.unitPrice,
    }

    if (isEdit.value) {
      await $request.put('/goods/update', payload)
      ElMessage.success('商品修改成功')
    } else {
      await $request.post('/goods/add', payload)
      ElMessage.success('商品新增成功')
    }
    formVisible.value = false
    loadGoods()
  } catch (e) {
    ElMessage.error((isEdit.value ? '修改' : '新增') + '失败：' + (e.message || '网络错误'))
  } finally {
    formLoading.value = false
  }
}

// ========== 删除 ==========
function handleDelete(goods) {
  ElMessageBox.confirm(
    `确定要删除商品「${goods.goodsDesc}」(编码: ${goods.goodsCode}) 吗？此操作不可恢复。`,
    '删除确认',
    { confirmButtonText: '确定删除', cancelButtonText: '取消', type: 'warning' }
  ).then(async () => {
    try {
      await $request.delete('/goods/delete/' + goods.goodsCode)
      ElMessage.success('删除成功')
      loadGoods()
    } catch (e) {
      ElMessage.error('删除失败：' + (e.message || '网络错误'))
    }
  }).catch(() => {})
}

// ========== 详情弹窗 ==========
const detailVisible = ref(false)
const currentGoods = ref(null)

function openDetail(goods) {
  currentGoods.value = goods
  detailVisible.value = true
}

// ========== 购物车弹窗 ==========
const cartVisible = ref(false)
const cartGoods = ref(null)
const cartQuantity = ref(1)
const cartLoading = ref(false)

function openCartDialog(goods) {
  cartGoods.value = goods
  cartQuantity.value = 1
  cartVisible.value = true
}

async function confirmAddCart() {
  cartLoading.value = true
  try {
    await $request.post('/goods/cart/add', {
      custCode: 'C001',
      goodsCode: cartGoods.value.goodsCode,
      quantity: cartQuantity.value,
      unitPrice: cartGoods.value.unitPrice,
    })
    ElMessage.success(`已将「${cartGoods.value.goodsDesc}」×${cartQuantity.value} 加入购物车`)
    cartVisible.value = false
  } catch (e) {
    ElMessage.error('添加到购物车失败：' + (e.message || '网络错误'))
  } finally {
    cartLoading.value = false
  }
}

// ========== 时间格式化 ==========
function formatTime(timeStr) {
  if (!timeStr) return ''
  return timeStr.replace('T', ' ').substring(0, 16)
}

// ========== 初始化 ==========
onMounted(() => {
  loadGoods()
})
</script>

<style scoped>
.shopping-page {
  width: 85%;
  margin: 0 auto;
  min-height: 90vh;
  padding: 24px 0;
}

/* ===== 搜索栏 ===== */
.search-bar {
  display: flex;
  align-items: center;
  gap: 16px;
  margin-bottom: 28px;
  padding: 20px 24px;
  background: #fff;
  border-radius: 12px;
  box-shadow: 0 2px 12px rgba(0, 0, 0, 0.06);
}

.search-input-wrap {
  display: flex;
  flex: 1;
  gap: 10px;
}

/* ===== 加载 ===== */
.loading-wrap {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  padding: 120px 0;
  color: #909399;
}

.loading-icon {
  animation: spin 1s linear infinite;
}

@keyframes spin {
  from { transform: rotate(0deg); }
  to { transform: rotate(360deg); }
}

/* ===== 商品网格 ===== */
.goods-grid {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 20px;
}

.goods-card {
  background: #fff;
  border-radius: 12px;
  overflow: hidden;
  box-shadow: 0 2px 12px rgba(0, 0, 0, 0.06);
  transition: transform 0.25s, box-shadow 0.25s;
  display: flex;
  flex-direction: column;
  position: relative;
}

.goods-card:hover {
  transform: translateY(-6px);
  box-shadow: 0 8px 25px rgba(0, 0, 0, 0.12);
}

/* 管理按钮 */
.card-actions {
  position: absolute;
  top: 8px;
  right: 8px;
  z-index: 2;
  display: flex;
  gap: 4px;
  opacity: 0;
  transition: opacity 0.2s;
}

.goods-card:hover .card-actions {
  opacity: 1;
}

.card-image {
  position: relative;
  width: 100%;
  height: 220px;
  overflow: hidden;
  cursor: pointer;
  background: #f8fafc;
}

.card-image img {
  width: 100%;
  height: 100%;
  object-fit: cover;
  transition: transform 0.3s;
}

.card-image:hover img {
  transform: scale(1.06);
}

/* ===== 图片占位（Element Plus 图标） ===== */
.img-placeholder {
  width: 100%;
  height: 100%;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  gap: 8px;
  font-size: 13px;
  transition: transform 0.3s;
}

.card-image:hover .img-placeholder {
  transform: scale(1.06);
}

.card-category-tag {
  position: absolute;
  top: 10px;
  left: 10px;
  background: rgba(0, 0, 0, 0.55);
  color: #fff;
  font-size: 12px;
  padding: 2px 10px;
  border-radius: 10px;
}

.card-body {
  padding: 16px;
  flex: 1;
  display: flex;
  flex-direction: column;
}

.card-title {
  margin: 0 0 8px;
  font-size: 14px;
  color: #1f2937;
  cursor: pointer;
  line-height: 1.5;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
  flex-shrink: 0;
}

.card-title:hover {
  color: #ef4444;
}

.card-brand {
  display: flex;
  align-items: center;
  gap: 4px;
  font-size: 12px;
  color: #6b7280;
  margin-bottom: 8px;
}

.card-rating {
  display: flex;
  align-items: center;
  gap: 8px;
  margin-bottom: 10px;
  flex-wrap: wrap;
}

.review-count {
  font-size: 12px;
  color: #9ca3af;
}

.card-bottom {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-top: auto;
}

.card-price {
  font-size: 22px;
  font-weight: 700;
  color: #ef4444;
}

/* ===== 空状态 ===== */
.empty-wrap {
  grid-column: 1 / -1;
  padding: 60px 0;
}

/* ===== 分页 ===== */
.pagination-wrap {
  display: flex;
  justify-content: center;
  margin-top: 36px;
  padding-bottom: 24px;
}

/* ===== 新增/编辑表单弹窗 ===== */
:deep(.form-dialog .el-dialog__body) {
  padding: 16px 28px;
}

/* ===== 详情弹窗 ===== */
.detail-top {
  display: flex;
  gap: 24px;
  margin-bottom: 28px;
}

.detail-image {
  width: 260px;
  height: 260px;
  object-fit: cover;
  border-radius: 10px;
  background: #f8fafc;
}

.detail-placeholder {
  width: 260px;
  height: 260px;
  border-radius: 10px;
}

.detail-info {
  flex: 1;
  display: flex;
  flex-direction: column;
}

.detail-info h2 {
  margin: 0 0 10px;
  font-size: 18px;
  color: #1f2937;
}

.detail-brand {
  font-size: 14px;
  color: #6b7280;
  margin: 0 0 8px;
  display: flex;
  align-items: center;
  gap: 4px;
}

.detail-price {
  font-size: 28px;
  font-weight: 700;
  color: #ef4444;
  margin: 0 0 12px;
}

.detail-rating {
  display: flex;
  align-items: center;
  gap: 8px;
  margin-bottom: 16px;
  font-size: 13px;
  color: #6b7280;
}

.detail-actions {
  display: flex;
  gap: 12px;
}

/* ===== 评论区域 ===== */
.review-section {
  border-top: 1px solid #e5e7eb;
  padding-top: 20px;
}

.review-section h3 {
  display: flex;
  align-items: center;
  gap: 6px;
  margin: 0 0 16px;
  font-size: 16px;
  color: #1f2937;
}

.review-list {
  max-height: 360px;
  overflow-y: auto;
}

.review-item {
  padding: 14px 0;
  border-bottom: 1px solid #f3f4f6;
}

.review-item:last-child {
  border-bottom: none;
}

.review-header {
  display: flex;
  align-items: center;
  gap: 10px;
  margin-bottom: 8px;
}

.review-user {
  font-size: 14px;
  font-weight: 500;
  color: #374151;
}

.review-time {
  font-size: 12px;
  color: #9ca3af;
  margin-left: auto;
}

.review-text {
  margin: 0 0 0 42px;
  font-size: 14px;
  color: #4b5563;
  line-height: 1.6;
}

/* ===== 购物车弹窗 ===== */
.cart-goods-info {
  display: flex;
  gap: 16px;
  margin-bottom: 20px;
  align-items: center;
}

.cart-goods-img {
  width: 100px;
  height: 100px;
  object-fit: cover;
  border-radius: 8px;
  background: #f8fafc;
}

.cart-placeholder {
  width: 100px;
  height: 100px;
  border-radius: 8px;
  font-size: 11px;
  gap: 4px;
  flex-shrink: 0;
}

.cart-goods-name {
  margin: 0 0 6px;
  font-size: 15px;
  color: #1f2937;
}

.cart-goods-price {
  margin: 0;
  font-size: 20px;
  font-weight: 600;
  color: #ef4444;
}

.cart-quantity {
  display: flex;
  align-items: center;
  gap: 12px;
  margin-bottom: 16px;
  font-size: 15px;
}

.cart-total {
  text-align: right;
  font-size: 16px;
  color: #374151;
  margin: 0;
}

.total-price {
  font-size: 22px;
  font-weight: 700;
  color: #ef4444;
}

/* ===== 弹窗全局 ===== */
:deep(.detail-dialog .el-dialog__body),
:deep(.cart-dialog .el-dialog__body) {
  padding: 20px 28px;
}

/* ===== 响应式 ===== */
@media (max-width: 1200px) {
  .goods-grid {
    grid-template-columns: repeat(3, 1fr);
  }
  .shopping-page {
    width: 92%;
  }
}

@media (max-width: 900px) {
  .goods-grid {
    grid-template-columns: repeat(2, 1fr);
  }
  .search-bar {
    flex-direction: column;
  }
  .detail-top {
    flex-direction: column;
    align-items: center;
  }
  .detail-image {
    width: 100%;
    height: 220px;
  }
}

@media (max-width: 560px) {
  .goods-grid {
    grid-template-columns: 1fr;
  }
}
</style>
