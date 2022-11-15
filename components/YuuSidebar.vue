<template>
  <aside class="sidebar">
    <section class="sidebar-group">
      <p class="sidebar-heading">
        <span>{{$t('GUIDE')}}</span>
        <i class="bx bx-chevron-right"></i>
      </p>
      <ul class="sidebar-links sidebar-group-items">
        <li class="">
          <NuxtLink to="/" exact class="sidebar-link">{{$t('INTRODUCTION')}}</NuxtLink>
        </li>
        <li>
          <NuxtLink to="/getting-started" class="sidebar-link">{{$t('GETTING_STARTED')}}</NuxtLink>
        </li>
        <li>
          <NuxtLink to="/web-server" class="sidebar-link">{{$t('WEB_SERVER')}}</NuxtLink>
          <ul>
            <li>
              <NuxtLink to="/web-server/apache" class="sidebar-link">Apache</NuxtLink>
            </li>
          </ul>
        </li>
        <li>
          <NuxtLink to="/php" class="sidebar-link">PHP</NuxtLink>
        </li>
        <li>
          <NuxtLink to="/mariadb" class="sidebar-link">MariaDB</NuxtLink>
        </li>
        <li>
          <NuxtLink to="/docker" class="sidebar-link">Docker</NuxtLink>
          <ul>
            <li>
              <NuxtLink to="/docker/docker-compose" class="sidebar-link">Docker compose</NuxtLink>
            </li>
          </ul>
        </li>
        <li>
          <NuxtLink to="/mail-server" class="sidebar-link">{{$t('MAIL_SERVER')}}</NuxtLink>
        </li>
      </ul>
    </section>
  </aside>
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
.sidebar {
  width: 255px;
  padding: 1.5rem 0;
}

.sidebar-group {
  overflow: auto;
  .sidebar-heading {
    color: var(--vs-theme-color);
    font-size: 1em;
    font-weight: 700;
    padding: 0.35rem 1.5rem 0.35rem 1.25rem;
    margin: 0;
    display: flex;
    align-items: center;
    cursor: pointer;
    transition: color .15s ease;
  }
  ul ul {
    padding-left: 1rem;
  }
  .sidebar-link {
    padding-left: 2rem;
  }
}

.sidebar-link {
  font-size: .95rem;
  color: var(--vs-theme-color);
  display: block;
  padding: 0.3rem 1rem 0.3rem 2rem;
  opacity: .5;
  transition: all .25s ease;
  font-weight: 400;
  position: relative;
  &:hover,
  &.sidebar-link-active {
    opacity: 1;
  }
}
</style>
