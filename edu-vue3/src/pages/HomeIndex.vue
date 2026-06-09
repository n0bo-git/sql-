<template>
  <div class="layout">
    <AsideMenu class="asidemenu"/>
    <div class="main-area">
      <router-view />
    </div>
  </div>
</template>

<script setup>
  import AsideMenu from './AsideMenu.vue'
</script>

<style>
/* 内容区所有页面撑满 */
.main-area .page-wrap {
  min-height: 100%;
  box-sizing: border-box;
}
</style>
<style scoped>
.layout {
  display: flex;
  min-height: 100vh;
}
.asidemenu {
  width: 200px;
  flex-shrink: 0;
  background: #fff;
  box-shadow: 1px 0 8px rgba(0,0,0,0.06);
}
.main-area {
  flex: 1;
  min-height: 100vh;
  background: #f5f7fa;
  overflow-y: auto;
}
</style>
