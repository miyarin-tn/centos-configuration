<template>
  <header class="header">
    <div class="header-box">
      <NuxtLink to="/"><nuxt-img src="/icon.png" width="60" height="60" /></NuxtLink>
      <div class="info">
        <select
          v-model="currentLanguage"
          class="c-lang"
          @change="setLocale"
        >
          <option v-for="lng in allLanguages" :key="lng">{{ lng }}</option>
        </select>
        <div class="version">v{{version}}</div>
        <div class="external-links">
          <a href="" target="_blank" title="Github">
            <i class="bx bxl-github"></i>
          </a>
          <a href="" target="_blank" title="Twitter">
            <i class="bx bxl-twitter"></i>
          </a>
        </div>
        <!-- <div class="search-box">
          <div class="search-input">
            <input type="search" autocomplete="off" spellcheck="false" placeholder="Search">
            <i class="bx bx-search"></i>
          </div>
        </div> -->
        <div class="menu" @click="toggleMenu">
          <i v-if="!openedMenu" class='bx bx-menu'></i>
          <i v-else class='bx bx-x'></i>
        </div>
      </div>
    </div>
  </header>
</template>

<script lang="ts">
import { version } from '@/package.json';

export default {
  props: {
    openedMenu: { type: Boolean, default: () => false },
  },
  // @ts-ignore
  data() {
    return {
      version: version,
      // @ts-ignore
      currentLanguage: this.$i18n.locale,
    };
  },
  computed: {
    allLanguages(): readonly string[] {
      // @ts-ignore
      return this.$i18n.localeCodes;
    },
  },
  methods: {
    setLocale(event: Event): void {
      // @ts-ignore
      this.$i18n.setLocale(event.target.value);
    },
    toggleMenu(): void {
      // @ts-ignore
      this.$emit('toggle-menu', !this.openedMenu);
    },
  }
}
</script>

<style lang="scss" scoped>
header {
  background-color: #fff;
  border-bottom: 1px solid #dcdfe6;
  min-height: 80px;
  display: flex;
  align-items: center;

  .header-box {
    flex: 1;
    display: flex;
    justify-content: space-between;
    padding-left: 15px;
    padding-right: 15px;
  }

  .info {
    display: flex;
    align-items: center;
    justify-content: center;
  }

  .version {
    opacity: 0.5;
    padding: 10px;
    margin-top: -4px;
  }

  .external-links {
    display: flex;
    // margin-right: 10px;
    a {
      padding: 4px;
    }
  }

  .search-box {
    position: relative;
    .search-input {
      input {
        background: rgba(0, 0, 0, 0.05);
        color: var(--vs-theme-color);
        width: 15rem;
        padding: 4px 40px 4px 20px;
        border-radius: 14px 5px 14px 14px;
        border: 0;
        cursor: text;
        font-size: .85rem;
        line-height: 2rem;
        outline: none;
      }
    }
    i {
      position: absolute;
      right: 0;
      padding: 12px;
    }
  }
}

.menu {
  font-size: 25px;
  margin-left: 10px;
  @media (min-width: 993px) {
    display: none;
  }
}
</style>
