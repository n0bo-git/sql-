import './assets/main.css'

import { createApp } from 'vue'
import ElementPlus from 'element-plus'
import 'element-plus/dist/index.css'
import { createPinia } from 'pinia'
import 'virtual:windi.css'

import App from './App.vue'
import router from './router'
import request from './utils/request'

const app = createApp(App)

app.use(ElementPlus)
app.use(createPinia())
app.use(router)

// 全局挂载请求工具
app.config.globalProperties.$request = request

app.mount('#app')
