<template>
  <main class="main">
    <YuuSidebar />
    <YuuContent />
  </main>
</template>

<script lang="ts">
export default {
  data() {
    return {
    };
  },
}
</script>

<style lang="scss" scoped>
.main {
  min-height: calc(100vh - 80px);
  display: flex;
  flex-direction: row;
  @media (max-width: 992px) {
    width: calc(100vw + 255px);
    margin-left: -255px;
    transition: all 0.2s linear;
  }
}
</style>
