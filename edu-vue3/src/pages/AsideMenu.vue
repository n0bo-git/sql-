<template>
  <div class="demo-collapse ">
    <div>
      <h1>后台系统</h1>
    </div>
    <el-collapse accordion>
      <el-collapse-item name="1">
        <template #title="{ isActive }">
          <div :class="['title-wrapper', { 'is-active': isActive }] ">
            首页
            <el-icon class="header-icon">
              <info-filled />
            </el-icon>
          </div>
        </template>
          <div>
            商品管理
          </div>
        </el-collapse-item>
        <el-collapse-item title="Feedback" name="2">
          <div>
            2
          </div>
        </el-collapse-item>
        <el-collapse-item title="Efficiency" name="3">
          <div>
            4
          </div>
        </el-collapse-item>
        <el-collapse-item title="Controllability" name="4">
          <div>
            7
          </div>
        </el-collapse-item>
    </el-collapse>
  </div>
</template>

<script setup>
import { InfoFilled } from '@element-plus/icons-vue'
</script>

<style scoped>
.title-wrapper {
  display: flex;
  align-items: center;
  gap: 4px;
}

.title-wrapper.is-active {
  color: var(--el-color-primary);
}
</style>
