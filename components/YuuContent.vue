<template>
  <section class="content">
    <nuxt />
  </section>
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
.content {
  flex: 1;
  background-color: var(--vs-theme-bg);
  padding-bottom: 100px;
  width: calc(100% - 255px);
}
</style>
