import { createRouter, createWebHistory } from 'vue-router'

import HomeIndex from '@/pages/HomeIndex.vue'
import UserLogin from '@/pages/UserLogin.vue'
import UserShopping from '@/pages/UserShopping.vue'
import GoodsList from '@/pages/GoodsList.vue'
import SupplierList from '@/pages/SupplierList.vue'
import UserList from '@/pages/UserList.vue'
import ReviewList from '@/pages/ReviewList.vue'
import MerchantList from '@/pages/MerchantList.vue'
import MerchantReview from '@/pages/MerchantReview.vue'
import Profile from '@/pages/Profile.vue'
import Cart from '@/pages/Cart.vue'
import OrderList from '@/pages/OrderList.vue'
import NotFound from '@/pages/NotFound.vue'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    // 商品页（独立布局）
    { path: '/',       name: 'shopping', component: UserShopping },
    { path: '/login',  name: 'login',    component: UserLogin },

    // 主页（侧边栏布局）—— 所有功能在内容区显示
    {
      path: '/home',
      component: HomeIndex,
      children: [
        { path: '',                  name: 'home',           component: UserShopping },
        { path: 'goods/list',        name: 'goodsList',      component: GoodsList },
        { path: 'supplier/list',     name: 'supplierList',   component: SupplierList },
        { path: 'user/list',         name: 'userList',       component: UserList },
        { path: 'review/list',       name: 'reviewList',     component: ReviewList },
        { path: 'merchant/list',     name: 'merchantList',   component: MerchantList },
        { path: 'merchant/review',   name: 'merchantReview', component: MerchantReview },
        { path: 'profile',           name: 'profile',        component: Profile },
        { path: 'cart',              name: 'cart',           component: Cart },
        { path: 'order/list',        name: 'orderList',      component: OrderList },
      ],
    },

    { path: '/:pathMatch(.*)*', name: 'not-found', component: NotFound },
  ],
})

export default router
