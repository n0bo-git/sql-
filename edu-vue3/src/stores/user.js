import { ref } from 'vue'
import { defineStore } from 'pinia'

export const useUserStore = defineStore('user', () => {
  const email = ref('')
  const balance = ref(0)
  const showBalance = ref(false)

  function login(userEmail) {
    email.value = userEmail
    balance.value = 0
  }

  function logout() {
    email.value = ''
    balance.value = 0
    showBalance.value = false
  }

  function toggleBalance() {
    showBalance.value = !showBalance.value
  }

  function recharge(amount) {
    balance.value += amount
  }

  return { email, balance, showBalance, login, logout, toggleBalance, recharge }
})
