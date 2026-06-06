<template>
  <div class="min-h-screen flex bg-white overflow-hidden">
    <!-- ===== 左侧：紫色渐变面板 ===== -->
    <div class="left-panel hidden lg:flex lg:w-5/12 xl:w-1/2 flex-col justify-center items-center relative overflow-hidden"
         style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);">
      <!-- 装饰圆形 -->
      <div class="deco-circle deco-circle-1" />
      <div class="deco-circle deco-circle-2" />
      <div class="deco-circle deco-circle-3" />

      <!-- 内容容器：登录/注册 切换不同文案 -->
      <transition name="fade-slide" mode="out-in">
        <div v-if="activeTab === 'login'" key="login" class="z-10 text-center px-8">
          <div class="text-6xl mb-6">
            👋
          </div>
          <h1 class="text-white text-4xl font-bold mb-4 tracking-wide">
            Welcome Back
          </h1>
          <p class="text-purple-200 text-lg leading-relaxed">
            Sign in to access your personal dashboard<br />and continue your learning journey.
          </p>
          <div class="mt-10 flex justify-center gap-4 text-white/70 text-sm">
            <div class="flex items-center gap-2">
              <span class="i-carbon-locked w-5 h-5" /> Secure
            </div>
            <div class="flex items-center gap-2">
              <span class="i-carbon-flash w-5 h-5" /> Fast
            </div>
            <div class="flex items-center gap-2">
              <span class="i-carbon-cloud w-5 h-5" /> Reliable
            </div>
          </div>
        </div>

        <div v-else key="register" class="z-10 text-center px-8">
          <div class="text-6xl mb-6">
            🚀
          </div>
          <h1 class="text-white text-4xl font-bold mb-4 tracking-wide">
            Join Us Today
          </h1>
          <p class="text-purple-200 text-lg leading-relaxed">
            Create your account and start exploring<br />a world of knowledge.
          </p>
          <div class="mt-10 flex justify-center gap-4 text-white/70 text-sm">
            <div class="flex items-center gap-2">
              <span class="i-carbon-checkmark w-5 h-5" /> Free to Start
            </div>
            <div class="flex items-center gap-2">
              <span class="i-carbon-user-multiple w-5 h-5" /> Community
            </div>
            <div class="flex items-center gap-2">
              <span class="i-carbon-cube w-5 h-5" /> Resources
            </div>
          </div>
        </div>
      </transition>
    </div>

    <!-- ===== 右侧：白色表单面板 ===== -->
    <div class="right-panel w-full lg:w-7/12 xl:w-1/2 flex justify-center items-center px-6 py-12 bg-white">
      <div class="w-full max-w-420px">

        <!-- 移动端 logo（仅小屏显示） -->
        <div class="lg:hidden text-center mb-10">
          <div class="text-5xl mb-3">
            🔐
          </div>
          <h2 class="text-3xl font-bold text-gray-800">
            {{ activeTab === 'login' ? 'Welcome Back' : 'Create Account' }}
          </h2>
          <p class="text-gray-400 mt-2">
            {{ activeTab === 'login' ? 'Sign in to continue' : 'Join us to get started' }}
          </p>
        </div>

        <!-- 切换选项卡 -->
        <div class="flex mb-10 bg-gray-100 rounded-xl p-1.5 relative">
          <button
            class="flex-1 py-3 rounded-lg text-sm font-semibold transition-all duration-300 z-10"
            :class="activeTab === 'login'
              ? 'bg-white text-gray-800 shadow-sm'
              : 'text-gray-500 hover:text-gray-700'"
            @click="switchTab('login')"
          >
            Sign In
          </button>
          <button
            class="flex-1 py-3 rounded-lg text-sm font-semibold transition-all duration-300 z-10"
            :class="activeTab === 'register'
              ? 'bg-white text-gray-800 shadow-sm'
              : 'text-gray-500 hover:text-gray-700'"
            @click="switchTab('register')"
          >
            Register
          </button>
        </div>

        <!-- ========== 登录表单 ========== -->
        <transition name="fade-slide" mode="out-in">
          <el-form
            v-if="activeTab === 'login'"
            key="login-form"
            ref="loginFormRef"
            :model="loginForm"
            :rules="loginRules"
            @submit.prevent="handleLogin"
          >
            <el-form-item prop="email">
              <el-input
                v-model="loginForm.email"
                placeholder="Username or Email"
                size="large"
                :prefix-icon="Message"
                clearable
              />
            </el-form-item>

            <el-form-item prop="password">
              <el-input
                v-model="loginForm.password"
                type="password"
                placeholder="Password"
                size="large"
                :prefix-icon="Lock"
                show-password
                @keyup.enter="handleLogin"
              />
            </el-form-item>

            <div class="flex justify-between items-center mb-6 text-sm">
              <el-checkbox v-model="loginForm.remember" class="text-gray-500">
                Remember me
              </el-checkbox>

              <!-- 失败3次后显示忘记密码 -->
              <transition name="fade">
                <a
                  v-if="showForgotPwd"
                  class="text-purple-600 cursor-pointer hover:text-purple-800 font-medium transition-colors"
                  @click="openResetDialog"
                >
                  Forgot Password?
                </a>
              </transition>
            </div>

            <el-button
              type="primary"
              size="large"
              class="submit-btn w-full !rounded-xl !h-48px !text-base !font-semibold !tracking-wide"
              :loading="loginLoading"
              @click="handleLogin"
            >
              {{ loginLoading ? 'Signing in...' : 'Sign In' }}
            </el-button>
          </el-form>

          <!-- ========== 注册表单 ========== -->
          <el-form
            v-else
            key="register-form"
            ref="registerFormRef"
            :model="registerForm"
            :rules="registerRules"
            @submit.prevent="handleRegister"
          >
            <el-form-item prop="email">
              <el-input
                v-model="registerForm.email"
                placeholder="Username or Email"
                size="large"
                :prefix-icon="Message"
                clearable
              />
            </el-form-item>

            <el-form-item prop="password">
              <el-input
                v-model="registerForm.password"
                type="password"
                placeholder="Password"
                size="large"
                :prefix-icon="Lock"
                show-password
              />
            </el-form-item>

            <el-form-item prop="confirmPassword">
              <el-input
                v-model="registerForm.confirmPassword"
                type="password"
                placeholder="Confirm password"
                size="large"
                :prefix-icon="Lock"
                show-password
                @keyup.enter="handleRegister"
              />
            </el-form-item>

            <!-- 密码强度指示器 -->
            <div v-if="registerForm.password" class="mb-6">
              <div class="flex gap-1.5 mb-2">
                <div
                  v-for="i in 4"
                  :key="i"
                  class="h-1.5 flex-1 rounded-full transition-colors duration-300"
                  :class="passwordStrengthClass(i)"
                />
              </div>
              <span class="text-xs" :class="passwordStrengthColor">{{ passwordStrengthText }}</span>
            </div>

            <el-button
              type="primary"
              size="large"
              class="submit-btn w-full !rounded-xl !h-48px !text-base !font-semibold !tracking-wide"
              :loading="registerLoading"
              @click="handleRegister"
            >
              {{ registerLoading ? 'Creating account...' : 'Create Account' }}
            </el-button>

          </el-form>
        </transition>
      </div>
    </div>

    <!-- ========== 忘记密码弹窗 ========== -->
    <el-dialog
      v-model="resetDialogVisible"
      title="Reset Your Password"
      width="440px"
      :close-on-click-modal="false"
      center
      class="reset-dialog"
    >
      <el-form
        ref="resetFormRef"
        :model="resetForm"
        :rules="resetRules"
        label-position="top"
      >
        <p class="text-gray-500 mb-6 text-sm leading-relaxed">
          Enter your registered email address. We'll send you a link to reset your password.
        </p>
        <el-form-item prop="email" label="Email Address">
          <el-input
            v-model="resetForm.email"
            placeholder="your@email.com"
            size="large"
            :prefix-icon="Message"
            clearable
          />
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="resetDialogVisible = false" size="large" class="!rounded-lg">
          Cancel
        </el-button>
        <el-button
          type="primary"
          size="large"
          class="reset-btn !rounded-lg"
          :loading="resetLoading"
          @click="handleResetPassword"
        >
          {{ resetSent ? 'Resend' : 'Send Reset Link' }}
        </el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script setup>
import { ref, reactive, computed, nextTick } from 'vue'
import { useRouter } from 'vue-router'
import { ElMessage } from 'element-plus'
import { Message, Lock } from '@element-plus/icons-vue'
import { useUserStore } from '@/stores/user'
import { getCurrentInstance } from 'vue'

const { proxy } = getCurrentInstance()
const $request = proxy.$request

const router = useRouter()
const userStore = useUserStore()

// ==================== 状态 ====================
const activeTab = ref('login')
const loginLoading = ref(false)
const registerLoading = ref(false)
const resetLoading = ref(false)
const resetSent = ref(false)
const resetDialogVisible = ref(false)

// 登录失败计数 — 持久化到 sessionStorage
const LOGIN_FAIL_KEY = 'login_fail_count'
const loginFailCount = ref(Number(sessionStorage.getItem(LOGIN_FAIL_KEY) || 0))

const showForgotPwd = computed(() => loginFailCount.value >= 3)

// 表单引用
const loginFormRef = ref(null)
const registerFormRef = ref(null)
const resetFormRef = ref(null)

// ==================== 登录表单 ====================
const loginForm = reactive({
  email: '',
  password: '',
  remember: false,
})

const loginRules = {
  email: [
    { required: true, message: 'Please enter your username or email', trigger: 'blur' },
  ],
  password: [
    { required: true, message: 'Please enter your password', trigger: 'blur' },
    { min: 3, message: 'Password must be at least 3 characters', trigger: 'blur' },
  ],
}

// ==================== 注册表单 ====================
const registerForm = reactive({
  email: '',
  password: '',
  confirmPassword: '',
})

const validateConfirmPassword = (_rule, value, callback) => {
  if (!value) {
    callback(new Error('Please confirm your password'))
  } else if (value !== registerForm.password) {
    callback(new Error('Passwords do not match'))
  } else {
    callback()
  }
}

const registerRules = {
  email: [
    { required: true, message: 'Please enter your username or email', trigger: 'blur' },
  ],
  password: [
    { required: true, message: 'Please enter your password', trigger: 'blur' },
    { min: 3, message: 'Password must be at least 3 characters', trigger: 'blur' },
    {
      pattern: /^(?=.*[A-Za-z])(?=.*\d)/,
      message: 'Password must contain at least one letter and one number',
      trigger: 'blur',
    },
  ],
  confirmPassword: [
    { required: true, message: 'Please confirm your password', trigger: 'blur' },
    { validator: validateConfirmPassword, trigger: 'blur' },
  ],
}

// ==================== 密码强度 ====================
const passwordStrengthScore = computed(() => {
  const pwd = registerForm.password
  if (!pwd) return 0
  let score = 0
  if (pwd.length >= 6) score++
  if (pwd.length >= 10) score++
  if (/[A-Z]/.test(pwd) && /[a-z]/.test(pwd)) score++
  if (/\d/.test(pwd)) score++
  if (/[^A-Za-z0-9]/.test(pwd)) score++
  return Math.min(4, score)
})

const passwordStrengthClass = (index) => {
  if (passwordStrengthScore.value >= index) {
    const colors = ['bg-red-400', 'bg-orange-400', 'bg-yellow-400', 'bg-green-400']
    return colors[index - 1]
  }
  return 'bg-gray-200'
}

const passwordStrengthColor = computed(() => {
  const map = ['text-gray-400', 'text-red-500', 'text-orange-500', 'text-yellow-500', 'text-green-500']
  return map[passwordStrengthScore.value]
})

const passwordStrengthText = computed(() => {
  const map = ['', 'Weak', 'Fair', 'Good', 'Strong']
  return map[passwordStrengthScore.value]
})

// ==================== 重置密码表单 ====================
const resetForm = reactive({
  email: '',
})

const resetRules = {
  email: [
    { required: true, message: 'Please enter your email', trigger: 'blur' },
    { type: 'email', message: 'Invalid email format', trigger: 'blur' },
  ],
}

// ==================== 方法 ====================
function switchTab(tab) {
  activeTab.value = tab
}

async function handleLogin() {
  if (!loginFormRef.value) return
  try {
    await loginFormRef.value.validate()
  } catch {
    return
  }

  loginLoading.value = true
  try {
    // 调用后端 /login API（后端用 username 字段，前端用 email 字段传值）
    const res = await $request.post('/login', {
      username: loginForm.email,
      password: loginForm.password,
    })
    // 登录成功 — 保存 token 和邮箱到 store
    const user = res.data
    userStore.login(loginForm.email, user.token, user.role, user.id)
    sessionStorage.removeItem(LOGIN_FAIL_KEY)
    loginFailCount.value = 0
    ElMessage.success('Login successful! Redirecting...')
    setTimeout(() => router.push('/home'), 800)
  } catch (e) {
    loginFailCount.value++
    sessionStorage.setItem(LOGIN_FAIL_KEY, String(loginFailCount.value))
    const remaining = Math.max(0, 3 - loginFailCount.value)
    if (remaining > 0) {
      ElMessage.error(e.message || `Invalid credentials. ${remaining} attempt${remaining > 1 ? 's' : ''} remaining.`)
    } else {
      ElMessage.error('Too many failed attempts. You can now reset your password.')
    }
  } finally {
    loginLoading.value = false
  }
}

async function handleRegister() {
  if (!registerFormRef.value) return
  try {
    await registerFormRef.value.validate()
  } catch {
    return
  }

  registerLoading.value = true
  try {
    // 调用后端 /register API
    await $request.post('/register', {
      username: registerForm.email,
      password: registerForm.password,
    })
    registerLoading.value = false
    ElMessage.success('Registration successful! You can now sign in.')
    registerForm.email = ''
    registerForm.password = ''
    registerForm.confirmPassword = ''
    activeTab.value = 'login'
  } catch (e) {
    registerLoading.value = false
    ElMessage.error(e.message || 'Registration failed')
  }
}

function openResetDialog() {
  resetForm.email = ''
  resetSent.value = false
  resetDialogVisible.value = true
  nextTick(() => resetFormRef.value?.clearValidate())
}

async function handleResetPassword() {
  if (!resetFormRef.value) return
  try {
    await resetFormRef.value.validate()
  } catch {
    return
  }

  resetLoading.value = true
  try {
    // 调用后端 /password 重置密码 API
    await $request.put('/password', {
      username: resetForm.email,
      phone: '', // 演示用，实际需用户填写验证手机号
    })
    resetLoading.value = false
    resetSent.value = true
    ElMessage.success('Password reset to default. Please check and change it.')
    sessionStorage.removeItem(LOGIN_FAIL_KEY)
    loginFailCount.value = 0
    setTimeout(() => {
      resetDialogVisible.value = false
    }, 1500)
  } catch (e) {
    resetLoading.value = false
    ElMessage.error(e.message || 'Password reset failed')
  }
}
</script>

<style scoped>
/* ========== 左侧面板 ========== */
.left-panel {
  position: relative;
}

/* 装饰圆形 */
.deco-circle {
  position: absolute;
  border-radius: 50%;
  background: rgba(255, 255, 255, 0.08);
}
.deco-circle-1 {
  width: 280px;
  height: 280px;
  top: -80px;
  right: -60px;
}
.deco-circle-2 {
  width: 180px;
  height: 180px;
  bottom: -40px;
  left: -50px;
}
.deco-circle-3 {
  width: 100px;
  height: 100px;
  top: 45%;
  right: 15%;
  background: rgba(255, 255, 255, 0.05);
}

/* ========== 右侧面板 ========== */
.right-panel {
  min-height: 100vh;
}

.max-w-420px {
  max-width: 420px;
}

/* ========== 提交按钮主题色 ========== */
.submit-btn,
.reset-btn {
  --el-button-bg-color: #7c3aed;
  --el-button-border-color: #7c3aed;
  --el-button-hover-bg-color: #6d28d9;
  --el-button-hover-border-color: #6d28d9;
  --el-button-active-bg-color: #5b21b6;
  --el-button-active-border-color: #5b21b6;
}

/* ========== Element Plus 覆盖 ========== */
:deep(.el-input__wrapper) {
  border-radius: 12px;
  padding: 6px 12px;
  box-shadow: 0 0 0 1px #e5e7eb inset;
  transition: all 0.3s;
}
:deep(.el-input__wrapper:hover) {
  box-shadow: 0 0 0 1px #a78bfa inset;
}
:deep(.el-input__wrapper.is-focus) {
  box-shadow: 0 0 0 2px #7c3aed inset;
}
:deep(.el-form-item.is-error .el-input__wrapper) {
  box-shadow: 0 0 0 1px #ef4444 inset;
}

:deep(.el-form-item) {
  margin-bottom: 22px;
}

:deep(.el-checkbox__input.is-checked .el-checkbox__inner) {
  background-color: #7c3aed;
  border-color: #7c3aed;
}
:deep(.el-checkbox__input.is-checked + .el-checkbox__label) {
  color: #374151;
}

/* ========== 过渡动画 ========== */
.fade-slide-enter-active,
.fade-slide-leave-active {
  transition: all 0.35s ease;
}
.fade-slide-enter-from {
  opacity: 0;
  transform: translateY(12px);
}
.fade-slide-leave-to {
  opacity: 0;
  transform: translateY(-12px);
}

.fade-enter-active,
.fade-leave-active {
  transition: opacity 0.3s;
}
.fade-enter-from,
.fade-leave-to {
  opacity: 0;
}

/* ========== 弹窗样式 ========== */
:deep(.reset-dialog .el-dialog__header) {
  padding: 24px 28px 0;
}
:deep(.reset-dialog .el-dialog__body) {
  padding: 20px 28px;
}
:deep(.reset-dialog .el-dialog__footer) {
  padding: 0 28px 24px;
}

/* ========== 响应式调整 ========== */
@media (max-width: 1023px) {
  .right-panel {
    min-height: 100vh;
    padding-top: 3rem;
    padding-bottom: 3rem;
  }
}
</style>
