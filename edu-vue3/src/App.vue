<script setup>


</script>

<template>
  <button class = "btn">
    按钮
  </button>
 <!-- <div class="button-example">
    <div class="button-row">
      <el-button>Default</el-button>
      <el-button type="primary">Primary</el-button>
      <el-button type="success">Success</el-button>
      <el-button type="info">Info</el-button>
      <el-button type="warning">Warning</el-button>
      <el-button type="danger">Danger</el-button>
    </div>
 </div> -->
</template>

<style>
  .btn{
    @apply
   bg-indigo-500
   text-white
    px-4
    py-4
    rounded-full
    transition
    duration-500
    hover:(bg-yellow-500 text-green-500)
    focus:(ring-6 ring-yellow-600);
  }
</style>
