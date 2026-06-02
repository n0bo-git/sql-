<template>
  <div>
    <el-col :sm="12" :lg="6" :xl="4">
        <el-result
          icon="error"
          title="404提示"
          sub-title="您的页面走丢了~"
        >
        <template #extra>
          <el-button type="primary" @click="$router.push('/')">Back</el-button>
        </template>
      </el-result>
    </el-col>
  </div>
</template>
