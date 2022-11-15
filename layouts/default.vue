<template>
  <div class="wrapper" :class="{'menu-opened': openedMenu}">
    <YuuHeader :opened-menu="openedMenu" @toggle-menu="toggleMenu" />
    <YuuMain />
    <YuuFooter />
  </div>
</template>
  
<script lang="ts">
export default {
  name: 'DefaultLayout',
  // @ts-ignore
  head() {
    // @ts-ignore
    const i18nHead = this.$nuxtI18nHead({ addSeoAttributes: true });
    return {
      htmlAttrs: {
        ...i18nHead.htmlAttrs
      },
      meta: [
        ...i18nHead.meta,
        { hid: 'og:type', property: 'og:type', content: 'website' },
        { hid: 'og:image', property: 'og:image', content: `${process.env.DOMAIN}/yuudachi.jpg` },
      ],
      link: [...i18nHead.link],
    };
  },
  data() {
    return {
      openedMenu: false,
    };
  },
  created() {
    if (process.client) {
      window.addEventListener('click', (e) => {
        console.log(e.target);
        // @ts-ignore
        if (!e.target.closest('.menu') && (!e.target.closest('.sidebar') || (e.target.closest('.sidebar') && e.target.classList.contains('sidebar-link')))) {
          // @ts-ignore
          this.toggleMenu(false);
        }
      });
    }
  },
  methods: {
    toggleMenu(val: boolean): void {
      // @ts-ignore
      this.openedMenu = val;
    },
  },
}
</script>

<style lang="scss" scoped>
.wrapper {
  position: relative;
  overflow: hidden;
  &.menu-opened {
    .main {
      margin-left: 0;
    }
    .footer {
      width: 100vw;
      margin-left: 255px;
    }
  }
}
</style>
  