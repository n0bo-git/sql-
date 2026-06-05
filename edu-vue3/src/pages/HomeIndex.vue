<template>
  <div class="layout">
    <el-container>
      <AsideMenu class="asidemenu"/>
      <el-container>
        <el-main>
          <ActualContent class="content" />
        </el-main>
      </el-container>
    </el-container>
  </div>
</template>

<script setup>
  import AsideMenu from './AsideMenu.vue'
  import ActualContent from './ActualContent.vue'
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
}
.content {
  position: fixed;
  left: 10vw;
  right: 0;
  min-height: 100vh;
  margin-top: 0;
}
</style>
