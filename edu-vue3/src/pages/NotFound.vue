<template>
  <div>
    <el-col :sm="12" :lg="6" :xl="4">
        <el-result
          icon="error"
          title="404"
        >
        <template #extra>
          <el-button type="primary" @click="$router.push('/')">Back</el-button>
        </template>
      </el-result>
    </el-col>
  </div>
</template>
