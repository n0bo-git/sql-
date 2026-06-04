<template>
  <div class="login-container">
    <el-row
    justify=center
    align=center
    class="login-row">
      <el-col :span="24" class="login-col">
        <div class="welcome-box">
          <h2 class=" text-yellow-200 text-3xl align-top">用户登录</h2>
        </div>
        <div class="login-box" bg-white>
          <div class="account-box">
            <h2 class="leading-relaxed">账号</h2>
          </div>
          <div class="password-box">
            <h2 class="leading-relaxed">密码</h2>
          </div>
        </div>
      </el-col>
    </el-row>
  </div>
</template>

<style scoped>
.login-container {
  width: 100vw;
  min-height: 100vh;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
}
.welcome-box {
  display: flex;
  justify-content: center;
  align-items: center;
  margin-bottom: 500px;
}
/* 关键：让 el-row 占满容器 */
.login-row {
  width: 100% !important;
  min-height: 100vh;
  margin: 0 !important;  /* 覆盖 el-row 默认 margin */
}

/* 关键：让 el-col 内容居中 */
.login-col {
  display: flex;
  justify-content: center;
  align-items: center;
}
.account-box, .password-box {
  width: 420px;
  padding: 40px;
  border-radius: 10px;
  box-shadow: 0 8px 24px rgba(0, 0, 0, 0.15);
}
.login-box {
  width: 500px;
  padding: 50px;
  background: #fff;
  border-radius: 12px;
  box-shadow: 0 8px 24px rgba(0, 0, 0, 0.15);
}
</style>
