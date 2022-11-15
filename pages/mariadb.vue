<template>
  <div>
    <div class="head-title">
      <div class="block-inner">
        <h2 class="main-title">MariaDB</h2>
      </div>
    </div>
    <div class="content-inner">
      <div class="block-inner">
        <div class="inner-item">
          <h3 class="sub-title title-anchor" id="install-mariadb">
            <a href="#install-mariadb" class="anchor">
              <span>#</span> {{$t('INSTALL', { software: 'MariaDB' })}}
            </a>
          </h3>
          <div class="inner-paragraph">
            <div>
              <p>{{$t('UPGRADE_SYSTEM')}}</p>
              <pre class="prefixed command language-bash"><code>sudo dnf upgrade --refresh -y</code></pre>
            </div>
            <div>
              <p>{{$t('INSTALL_SERVICE', { service: 'MariaDB' })}}</p>
              <pre class="prefixed command language-bash"><code>sudo dnf install mariadb-server</code></pre>
            </div>
            <div>
              <p>{{$t('CHECK_VERSION', { name: 'MariaDB' })}}</p>
              <pre class="prefixed command language-bash"><code>mariadb --version</code></pre>
            </div>
            <div>
              <p>{{$t('ENABLE_AND_START_SERVICE', { service: 'MariaDB' })}}</p>
              <pre class="prefixed command language-bash"><code>sudo systemctl enable mariadb --now</code></pre>
            </div>
            <div>
              <p>{{$t('CONFIG_SECURE_MARIADB')}}</p>
              <pre class="prefixed command language-bash"><code>sudo mariadb-secure-installation</code></pre>
            </div>
            <div>
              <p>{{$t('LOGIN_MYSQL')}}</p>
              <pre class="prefixed command language-bash"><code>sudo mysql -u root -p</code></pre>
            </div>
            <div>
              <p>{{$t('CREATE_USER_AND_ADD_PERMISSION_MYSQL')}}</p>
              <pre class="prefixed-mariadb language-bash"><code>GRANT ALL PRIVILEGES ON *.* TO 'username'@'localhost' IDENTIFIED BY 'password' WITH GRANT OPTION;</code></pre>
            </div>
            <div>
              <p>{{$t('APPLY_PRIVILEGES')}}</p>
              <pre class="prefixed-mariadb language-bash"><code>FLUSH PRIVILEGES;</code></pre>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>
  
<script lang="ts">
export default {
  data() {
    return {
    };
  },
  // @ts-ignore
  head() {
    // @ts-ignore
    const fullPath = this.$nuxt.$route.fullPath.replace(/\/+$/, '')
    const url = `${process.env.DOMAIN}${fullPath ? '/' + fullPath : ''}`;
    let meta: any = {
      // @ts-ignore
      title: 'MariaDB',
      meta: [
        // @ts-ignore
        { hid: 'description', name: 'description', content: 'MariaDB' },
        // @ts-ignore
        { hid: 'og:title', property: 'og:title', content: 'MariaDB' },
        // @ts-ignore
        { hid: 'og:description', property: 'og:description', content: 'MariaDB' },
        { hid: 'og:url', property: 'og:url', content: url },
      ],
    };
    return meta;
  },
}
</script>
  
<style lang="scss" scoped>
</style>
