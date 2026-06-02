//配置网页
<script setup>

</script>

<template>
  <router-view></router-view>
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
