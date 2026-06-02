import { createRouter, createWebHistory } from 'vue-router'

//导入网页路径
import HomeIndex from '@/pages/HomeIndex.vue'
import AboutView from '@/pages/AboutView.vue'
import NotFound from '@/pages/NotFound.vue'



const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      name: 'home',
      component: HomeIndex,
    },
    {
      path: '/about',
      name: 'about',
      component: AboutView,
    },
    {
      path: '/:pathMatch(.*)*',
      name: 'not-found',
      component: NotFound,
    },
  ],
})

export default router
