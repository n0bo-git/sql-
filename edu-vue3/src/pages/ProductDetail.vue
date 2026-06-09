<template>
  <div class="detail-page" v-loading="loading">
    <div v-if="errorMsg" style="text-align:center;padding:60px;color:#ef4444">
      {{ errorMsg }}<br/><el-button style="margin-top:16px" @click="load">重试</el-button>
    </div>
    <template v-else-if="goods">
      <div class="top-bar">
        <el-button text @click="$router.push('/')"><el-icon><ArrowLeft /></el-icon> 返回首页</el-button>
      </div>
      <div class="goods-section">
        <div class="goods-image">
          <img v-if="hasImage" :src="imgUrl" @error="hasImage=false" />
          <div v-else class="img-placeholder"><el-icon :size="64"><PictureFilled /></el-icon></div>
        </div>
        <div class="goods-info">
          <h1>{{ goods.goodsDesc }}</h1>
          <div class="price">¥{{ goods.unitPrice }}</div>
          <div class="rating" v-if="goods.avgRating > 0">
            <el-rate :model-value="goods.avgRating" disabled show-score /> ({{ goods.reviews?.length || 0 }}条)
          </div>
          <div style="margin-top:16px">
            <el-button type="danger" size="large" @click="addToCart"><el-icon><ShoppingCart /></el-icon>加入购物车</el-button>
          </div>
        </div>
      </div>

      <div class="merchant-section" v-if="manufacturer">
        <h2><el-icon><Shop /></el-icon>厂家信息</h2>
        <el-descriptions :column="2" border>
          <el-descriptions-item label="厂家名称">{{ manufacturer.manuName }}</el-descriptions-item>
          <el-descriptions-item label="联系电话">{{ manufacturer.manuPhone }}</el-descriptions-item>
        </el-descriptions>
      </div>

      <div class="review-section">
        <h2><el-icon><ChatDotRound /></el-icon>商品评论（{{ goods.reviews?.length || 0 }}）</h2>
        <div v-if="userStore.isLoggedIn" class="write-review">
          <el-rate v-model="myRating" />
          <el-input v-model="myReview" type="textarea" :rows="3" placeholder="写下你的评价..." style="margin:8px 0" />
          <el-button type="primary" :loading="submitting" @click="submitReview">发表评论</el-button>
        </div>
        <p v-else style="color:#909399">请<a href="/login" style="color:#7c3aed">登录</a>后发表评论</p>
        <div v-if="goods.reviews?.length > 0" class="review-list">
          <div v-for="rv in goods.reviews" :key="rv.reviewCode" class="review-card">
            <div class="review-hd">
              <el-avatar :size="28" :icon="UserFilled" />
              <span class="reviewer">{{ rv.custName }}</span>
              <el-rate :model-value="rv.reviewRating" disabled size="small" />
              <span class="time">{{ fmt(rv.reviewTime) }}</span>
            </div>
            <p class="review-text">{{ rv.review }}</p>
          </div>
        </div>
        <el-empty v-else description="暂无评论" />
      </div>
    </template>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'
import { useRoute } from 'vue-router'
import { ElMessage } from 'element-plus'
import { Shop, ChatDotRound, UserFilled, PictureFilled, ShoppingCart, ArrowLeft } from '@element-plus/icons-vue'
import { getCurrentInstance } from 'vue'
import { useUserStore } from '@/stores/user'

const { proxy } = getCurrentInstance(); const $ = proxy.$request
const route = useRoute(); const userStore = useUserStore()

const goods = ref(null); const manufacturer = ref(null)
const loading = ref(false); const errorMsg = ref(''); const hasImage = ref(true)
const myRating = ref(5); const myReview = ref(''); const submitting = ref(false)

const imgUrl = computed(() => {
  const url = goods.value?.coverImage
  if (!url) { hasImage.value = false; return '' }
  return url.startsWith('http') ? url : `http://localhost:9999${url}`
})

async function load() {
  loading.value = true; errorMsg.value = ''
  const code = route.params.goodsCode
  try {
    const r = await $.get('/goods/detail/' + code)
    if (r.data && r.data.goods) {
      goods.value = r.data.goods
      manufacturer.value = r.data.manufacturer
      if (!goods.value.coverImage) hasImage.value = false
    } else { errorMsg.value = '商品不存在' }
  } catch(e) { errorMsg.value = '加载失败: ' + (e.message||'网络错误') }
  finally { loading.value = false }
}

async function submitReview() {
  if (!myReview.value.trim()) { ElMessage.warning('请输入评论'); return }
  submitting.value = true
  try {
    await $.post('/review/add', { userId:userStore.userId, goodsCode:goods.value.goodsCode, review:myReview.value, reviewRating:myRating.value })
    ElMessage.success('评论发表成功'); myReview.value = ''; load()
  } catch(e) { ElMessage.error(e.message) }
  finally { submitting.value = false }
}

async function addToCart() {
  if (!userStore.isLoggedIn) { ElMessage.warning('请先登录'); return }
  try {
    await $.post('/goods/cart/add', { userId:userStore.userId, goodsCode:goods.value.goodsCode, quantity:1, unitPrice:goods.value.unitPrice })
    ElMessage.success('已加入购物车')
  } catch(e) { ElMessage.error(e.message) }
}

function fmt(t) {
  if (!t) return ''
  if (typeof t === 'string') return t.replace('T',' ').substring(0,16)
  if (Array.isArray(t) && t.length >= 5) return `${t[0]}-${String(t[1]).padStart(2,'0')}-${String(t[2]).padStart(2,'0')} ${String(t[3]).padStart(2,'0')}:${String(t[4]).padStart(2,'0')}`
  return String(t).substring(0,16)
}

onMounted(load)
</script>
<style scoped>
.detail-page{max-width:960px;margin:0 auto;padding:24px}
.top-bar{margin-bottom:16px}
.goods-section{display:flex;gap:32px;margin-bottom:32px;background:#fff;border-radius:12px;padding:24px}
.goods-image{width:360px;height:360px;border-radius:8px;overflow:hidden;background:#f8fafc;flex-shrink:0}
.goods-image img{width:100%;height:100%;object-fit:cover}
.img-placeholder{width:100%;height:100%;display:flex;align-items:center;justify-content:center;color:#cbd5e1}
.goods-info h1{font-size:22px;color:#1f2937;margin:0 0 12px}
.price{font-size:32px;font-weight:700;color:#ef4444;margin-bottom:8px}
.rating{margin-bottom:12px}
.merchant-section,.review-section{background:#fff;border-radius:12px;padding:24px;margin-bottom:24px}
.merchant-section h2,.review-section h2{font-size:18px;margin:0 0 16px;display:flex;align-items:center;gap:8px}
.review-card{border-bottom:1px solid #f3f4f6;padding:14px 0}
.review-card:last-child{border:none}
.review-hd{display:flex;align-items:center;gap:10px;margin-bottom:6px}
.reviewer{font-weight:500;color:#374151}
.time{font-size:12px;color:#9ca3af;margin-left:auto}
.review-text{margin:4px 0 0 38px;color:#4b5563;line-height:1.6}
.write-review{background:#f8fafc;padding:16px;border-radius:8px;margin-bottom:16px}
@media(max-width:768px){.goods-section{flex-direction:column}.goods-image{width:100%;height:260px}}
</style>
