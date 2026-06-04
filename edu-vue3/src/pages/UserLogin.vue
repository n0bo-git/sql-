<template>
  <div class="login-container">
    <el-row
    type="flex"
    justify="center"
    align="middle"
    class="login-row">
      <el-col :span="24" class="login-col">
        <div class="login-box">
          <h2>用户登录</h2>
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

.login-box {
  width: 400px;
  padding: 40px;
  background: #fff;
  border-radius: 12px;
  box-shadow: 0 8px 24px rgba(0, 0, 0, 0.15);
}
</style>
