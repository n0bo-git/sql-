import { ref } from 'vue'
import { defineStore } from 'pinia'

export const useUserStore = defineStore('user', () => {
  const email = ref(localStorage.getItem('userEmail') || '')
  const token = ref(localStorage.getItem('token') || '')
  const balance = ref(0)
  const showBalance = ref(false)

  /** 登录成功：保存邮箱和 token */
  function login(userEmail, userToken) {
    email.value = userEmail
    token.value = userToken || ''
    balance.value = 0
    // 持久化到 localStorage
    localStorage.setItem('userEmail', userEmail)
    if (userToken) {
      localStorage.setItem('token', userToken)
    }
  }

  /** 登出：清除全部状态 */
  function logout() {
    email.value = ''
    token.value = ''
    balance.value = 0
    showBalance.value = false
    localStorage.removeItem('userEmail')
    localStorage.removeItem('token')
  }

  function toggleBalance() {
    showBalance.value = !showBalance.value
  }

  function recharge(amount) {
    balance.value += amount
  }

  return { email, token, balance, showBalance, login, logout, toggleBalance, recharge }
})
