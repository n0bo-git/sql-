<template>
  <div class="bg-dark-50">
  <el-skeleton />
  <br />
  <el-skeleton style="--el-skeleton-circle-size: 100px">
    <template #template>
      <el-skeleton-item variant="circle" />
    </template>
  </el-skeleton>
  </div>
</template>

<script setup>

</script>

<style scoped>
  .bg-dark-50 {
    background-color: #f5f5f5;
  }
</style>

