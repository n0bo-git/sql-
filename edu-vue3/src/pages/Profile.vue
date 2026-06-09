<template>
  <div class="page-wrap">
    <h2>个人资料</h2>
    <el-card v-if="user" v-loading="loading" style="max-width:600px">
      <div style="display:flex;align-items:center;gap:24px;margin-bottom:20px">
        <el-avatar :size="72" :src="msg.avatar" :icon="UserFilled" />
        <div>
          <h3 style="margin:0">{{ msg.name || user.username }}</h3>
          <span style="color:#909399;font-size:13px">{{ ['管理员','用户'][user.role]||'用户' }}</span>
        </div>
      </div>
      <el-descriptions :column="2" border>
        <el-descriptions-item label="用户名">{{ user.username }}</el-descriptions-item>
        <el-descriptions-item label="电话">{{ msg.phone }}</el-descriptions-item>
        <el-descriptions-item label="邮箱">{{ msg.email }}</el-descriptions-item>
        <el-descriptions-item label="地址">{{ msg.address }}</el-descriptions-item>
        <el-descriptions-item label="余额">¥{{ msg.balance }}</el-descriptions-item>
        <el-descriptions-item label="年龄">{{ msg.age }}</el-descriptions-item>
      </el-descriptions>
      <div style="margin-top:20px">
        <el-button type="primary" @click="openEdit">编辑资料</el-button>
        <el-button @click="pwdVisible=true">修改密码</el-button>
      </div>
    </el-card>
    <el-empty v-else description="请先登录" />

    <el-dialog v-model="editVisible" title="编辑资料" width="480px">
      <el-form :model="msg" label-width="80px">
        <el-form-item label="头像">
          <div style="display:flex;align-items:center;gap:12px">
            <el-avatar :size="56" :src="msg.avatar" :icon="UserFilled" />
            <el-upload :action="uploadUrl" :show-file-list="false" :on-success="onAvatarSuccess" accept="image/*">
              <el-button size="small">上传头像</el-button>
            </el-upload>
          </div>
        </el-form-item>
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
import { UserFilled } from '@element-plus/icons-vue'
import { getCurrentInstance } from 'vue'

const { proxy } = getCurrentInstance(); const $ = proxy.$request
const user = ref(null); const msg = reactive({ name:'',phone:'',email:'',address:'',balance:0,age:null,avatar:'' })
const loading = ref(false); const editVisible = ref(false); const pwdVisible = ref(false)
const pwdForm = reactive({ oldPwd:'', newPwd:'' })
const uploadUrl = 'http://localhost:9999/file/upload'

onMounted(async () => {
  const token = localStorage.getItem('token')
  if (!token) return
  loading.value = true
  try {
    const email = localStorage.getItem('userEmail')
    const r = await $.get('/user/selectAll')
    const users = r.data || []
    const u = users.find(u => u.username === email || u.token === email)
    if (u) {
      user.value = u
      try {
        const mr = await $.get('/usermessage/selectByUserId/' + u.id)
        if (mr.data) Object.assign(msg, mr.data)
      } catch {}
    }
  } finally { loading.value = false }
})

function onAvatarSuccess(response) {
  msg.avatar = response.data
  ElMessage.success('头像上传成功')
}

function openEdit() { editVisible.value = true }

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
