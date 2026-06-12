import { createRouter, createWebHistory } from 'vue-router'

import HomeIndex from '@/pages/HomeIndex.vue'
import UserLogin from '@/pages/UserLogin.vue'
import UserShopping from '@/pages/UserShopping.vue'
import GoodsList from '@/pages/GoodsList.vue'
import UserList from '@/pages/UserList.vue'
import ReviewList from '@/pages/ReviewList.vue'
import Profile from '@/pages/Profile.vue'
import Cart from '@/pages/Cart.vue'
import ProductDetail from '@/pages/ProductDetail.vue'
import NotFound from '@/pages/NotFound.vue'
import TestPage from '@/pages/TestPage.vue'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    { path: '/',                   name: 'shopping',       component: UserShopping },
    { path: '/login',              name: 'login',          component: UserLogin },
    { path: '/product/:goodsCode', name: 'productDetail',  component: ProductDetail },
    { path: '/test',               name: 'test',           component: TestPage },
    {
      path: '/home',
      component: HomeIndex,
      children: [
        { path: '',                  name: 'home',         component: UserShopping },
        { path: 'goods/list',        name: 'goodsList',    component: GoodsList },
        { path: 'user/list',         name: 'userList',     component: UserList },
        { path: 'review/list',       name: 'reviewList',   component: ReviewList },
        { path: 'profile',           name: 'profile',      component: Profile },
        { path: 'cart',              name: 'cart',         component: Cart },
      ],
    },
    { path: '/:pathMatch(.*)*', name: 'not-found', component: NotFound },
  ],
})

export default router
