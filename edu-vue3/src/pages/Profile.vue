<template>
  <div class="page-wrap">
    <h2>个人资料</h2>
    <el-card v-if="user" v-loading="loading" style="max-width:600px">
      <el-descriptions :column="2" border>
        <el-descriptions-item label="用户名">{{ user.username }}</el-descriptions-item>
        <el-descriptions-item label="身份">{{ ['管理员','商家','普通用户'][user.role]||'未知' }}</el-descriptions-item>
        <el-descriptions-item label="姓名">{{ msg.name }}</el-descriptions-item>
        <el-descriptions-item label="电话">{{ msg.phone }}</el-descriptions-item>
        <el-descriptions-item label="邮箱">{{ msg.email }}</el-descriptions-item>
        <el-descriptions-item label="地址">{{ msg.address }}</el-descriptions-item>
        <el-descriptions-item label="余额">¥{{ msg.balance }}</el-descriptions-item>
        <el-descriptions-item label="年龄">{{ msg.age }}</el-descriptions-item>
      </el-descriptions>
      <div style="margin-top:20px">
        <el-button type="primary" @click="editVisible=true">编辑资料</el-button>
        <el-button @click="pwdVisible=true">修改密码</el-button>
      </div>
    </el-card>
    <el-empty v-else description="请先登录" />

    <!-- 编辑资料弹窗 -->
    <el-dialog v-model="editVisible" title="编辑资料" width="480px">
      <el-form :model="msg" label-width="80px">
        <el-form-item label="姓名"><el-input v-model="msg.name" /></el-form-item>
        <el-form-item label="电话"><el-input v-model="msg.phone" /></el-form-item>
        <el-form-item label="邮箱"><el-input v-model="msg.email" /></el-form-item>
        <el-form-item label="地址"><el-input v-model="msg.address" /></el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="editVisible=false">取消</el-button>
        <el-button type="primary" @click="handleSaveMsg">保存</el-button>
      </template>
    </el-dialog>

    <!-- 修改密码弹窗 -->
    <el-dialog v-model="pwdVisible" title="修改密码" width="400px">
      <el-form :model="pwdForm" label-width="100px">
        <el-form-item label="原密码"><el-input v-model="pwdForm.oldPwd" type="password" /></el-form-item>
        <el-form-item label="新密码"><el-input v-model="pwdForm.newPwd" type="password" /></el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="pwdVisible=false">取消</el-button>
        <el-button type="primary" @click="handleChangePwd">确认</el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script setup>
import { ref, reactive, onMounted } from 'vue'
import { ElMessage } from 'element-plus'
import { getCurrentInstance } from 'vue'
const { proxy } = getCurrentInstance(); const $ = proxy.$request
const user = ref(null); const msg = reactive({ name:'',phone:'',email:'',address:'',balance:0,age:null })
const loading = ref(false); const editVisible = ref(false); const pwdVisible = ref(false)
const pwdForm = reactive({ oldPwd:'', newPwd:'' })

onMounted(async () => {
  const token = localStorage.getItem('token')
  if (!token) return
  loading.value = true
  try {
    // 从 token 解析 userId 并获取信息
    // 这里先简单处理：从 user list 获取当前用户
    const r = await $.get('/user/selectAll')
    // Try to find user from login store via token
    // For simplicity, use stored user email
    const email = localStorage.getItem('userEmail')
    if (email) {
      // Find user by username in the list
      const users = r.data || []
      const u = users.find(u => u.username === email || u.token === email)
      if (u) {
        user.value = u
        try {
          const mr = await $.get('/usermessage/selectByUserId/' + u.id)
          if (mr.data) Object.assign(msg, mr.data)
        } catch(e) {}
      }
    }
  } finally { loading.value = false }
})

async function handleSaveMsg() {
  try {
    await $.put('/usermessage/update', { userId: user.value.id, ...msg })
    ElMessage.success('保存成功'); editVisible.value = false
  } catch(e) { ElMessage.error(e.message) }
}

async function handleChangePwd() {
  try {
    await $.post('/user/password', { id: user.value.id, password: pwdForm.oldPwd, newPassword: pwdForm.newPwd })
    ElMessage.success('密码修改成功'); pwdVisible.value = false
  } catch(e) { ElMessage.error(e.message) }
}
</script>
<style scoped>.page-wrap{padding:20px}</style>
