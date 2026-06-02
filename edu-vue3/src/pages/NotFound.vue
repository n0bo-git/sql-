<template>
  <div>
        <el-result
          icon="error"
          title="404"
          sub-title="您的页面走丢了"
        >
        <template #extra>
          <el-button type="primary" @click="$router.push('/')">Back</el-button>
        </template>
      </el-result>
  </div>
</template>
