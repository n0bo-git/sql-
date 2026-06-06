import { ref, computed } from 'vue'
import { defineStore } from 'pinia'

const BASE = 'http://localhost:9999'

export const useUserStore = defineStore('user', () => {
  const userId = ref(parseInt(localStorage.getItem('userId') || '0'))
  const email = ref(localStorage.getItem('userEmail') || '')
  const token = ref(localStorage.getItem('token') || '')
  const role = ref(parseInt(localStorage.getItem('userRole') || '2'))
  const balance = ref(parseInt(localStorage.getItem('balance') || '0'))
  const showBalance = ref(false)

  const isLoggedIn = computed(() => !!token.value)
  const isAdmin = computed(() => role.value === 0)
  const isMerchant = computed(() => role.value === 1)
  const isUser = computed(() => role.value === 2)

  // 初始化时自动加载余额
  if (userId.value > 0) { loadBalance() }

  function login(userEmail, userToken, userRole, id) {
    userId.value = id || 0
    email.value = userEmail
    token.value = userToken || ''
    role.value = userRole ?? 2
    balance.value = 0
    localStorage.setItem('userId', String(userId.value))
    localStorage.setItem('userEmail', userEmail)
    localStorage.setItem('userRole', String(role.value))
    if (userToken) localStorage.setItem('token', userToken)
    // 登录后自动加载余额
    loadBalance()
  }

  function logout() {
    email.value = ''; token.value = ''; role.value = 2
    balance.value = 0; showBalance.value = false
    localStorage.removeItem('userId'); localStorage.removeItem('userEmail')
    localStorage.removeItem('token'); localStorage.removeItem('userRole')
    localStorage.removeItem('balance')
  }

  /** 从数据库加载余额 */
  async function loadBalance() {
    if (!userId.value || userId.value <= 0) return
    try {
      const res = await fetch(`${BASE}/usermessage/selectByUserId/${userId.value}`)
      const data = await res.json()
      if (data.code === '200' && data.data) {
        balance.value = data.data.balance || 0
        localStorage.setItem('balance', String(balance.value))
      }
    } catch(e) { console.error('加载余额失败:', e) }
  }

  function toggleBalance() {
    if (!showBalance.value) loadBalance()  // 展开时刷新
    showBalance.value = !showBalance.value
  }

  /** 充值（仅演示：本地加，数据库也加） */
  async function recharge(amount) {
    if (!userId.value) return
    const newBal = balance.value + amount
    try {
      await fetch(`${BASE}/usermessage/update`, {
        method: 'PUT',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ userId: userId.value, balance: newBal })
      })
      balance.value = newBal
      localStorage.setItem('balance', String(newBal))
    } catch(e) { console.error('充值失败:', e) }
  }

  return { userId, email, token, role, balance, showBalance, isLoggedIn, isAdmin, isMerchant, isUser, login, logout, toggleBalance, recharge, loadBalance }
})
