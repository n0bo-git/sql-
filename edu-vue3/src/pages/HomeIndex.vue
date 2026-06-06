<template>
  <div class="layout">
    <el-container>
      <AsideMenu class="asidemenu"/>
      <el-container>
        <el-main>
          <router-view />
        </el-main>
      </el-container>
    </el-container>
  </div>
</template>

<script setup>
  import AsideMenu from './AsideMenu.vue'
</script>

<style scoped>
.layout {
  display: flex;
  flex-direction: row;
  height: 100%;
}
.asidemenu {
  width: 10vw;
  height: 100%;
  position: fixed;
  left: 0;
  top: 0;
  bottom: 0;
  z-index: 100;
}
.el-main {
  position: fixed;
  left: 10vw;
  right: 0;
  min-height: 100vh;
  margin-top: 0;
  padding: 0;
}
</style>
