import { createRouter, createWebHistory } from 'vue-router'

//导入网页路径
import HomeIndex from '@/pages/HomeIndex.vue'
import AboutView from '@/pages/AboutView.vue'
import NotFound from '@/pages/NotFound.vue'
import Userlogin from '@/pages/UserLogin.vue'
import UserShopping from '@/pages/UserShopping.vue'
import LoginTest from '@/pages/LoginTest.vue'



const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/home',
      name: 'home',
      component: HomeIndex,
    },
    {
      path: '/logintest',
      name: 'logintest',
      component: LoginTest,
    },
    {
      path: '/',
      name: 'shopping',
      component: UserShopping,
    },
    {
      path: '/about',
      name: 'about',
      component: AboutView,
    },
    {
      path: '/login',
      name: 'login',
      component: Userlogin,
    },
    {
      path: '/:pathMatch(.*)*',
      name: 'not-found',
      component: NotFound,
    },
  ],
})

export default router
