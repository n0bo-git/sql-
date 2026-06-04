<template>
  <div class="layout">
    <el-container>
      <AsideMenu class="asidemenu bg-green-500" />
      <el-container>
        <el-header>
          <HeadMenu class="headmenu bg-blue-500 " />
        </el-header>
        <el-main>
          <ActualContent class="content bg-yellow-200" />
        </el-main>

      </el-container>
    </el-container>
  </div>
</template>

<script setup>
  import AsideMenu from './AsideMenu.vue'
  import ActualContent from './ActualContent.vue'
  import  HeadMenu from './HeadMenu.vue';
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
.headmenu {
  position: fixed;
  width: 100%;
  min-height: 20vh;
  margin-left: 10vw;
  margin-top: 0;
}
.content {
  position: fixed;
  width: 100%;
  min-height: 80vh;
  margin-left: 10vw;
  margin-top: 15vh;
}
</style>
