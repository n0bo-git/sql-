<template>
  <div class="login-container">
    <el-row class="login-row" type="flex" justify="center" align="middle">
      <el-col :xs="20" :sm="16" :md="12" :lg="8" :xl="6">
        <div class="login-box">
          <!-- 这里放置你的登录表单 -->
          <h2 style="text-align: center; margin-bottom: 20px;">用户登录</h2>
          <el-form>
            <el-form-item label="用户名">
              <el-input placeholder="请输入用户名"></el-input>
            </el-form-item>
            <el-form-item label="密码">
              <el-input type="password" placeholder="请输入密码"></el-input>
            </el-form-item>
            <el-form-item>
              <el-button type="primary" style="width: 100%;">登录</el-button>
            </el-form-item>
          </el-form>
        </div>
      </el-col>
    </el-row>
  </div>
</template>

<style scoped>
/* 确保容器占满全屏 */
.login-container {
  height: 100vh;
  width: 100%;
  background-color: #f0f2f5; /* 可选：背景色 */
  display: flex;
  justify-content: center;
  align-items: center;
}

.login-row {
  width: 100%;
}

.login-box {
  padding: 30px;
  background-color: #fff;
  border-radius: 8px;
  box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1);
}
</style>
