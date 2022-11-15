<template>
  <div>
    <div class="head-title">
      <div class="block-inner">
        <h2 class="main-title">PHP</h2>
      </div>
    </div>
    <div class="content-inner">
      <div class="block-inner">
        <div class="inner-item">
          <h3 class="sub-title title-anchor" id="install-php">
            <a href="#install-php" class="anchor">
              <span>#</span> {{$t('INSTALL', { software: 'PHP' })}}
            </a>
          </h3>
          <div class="inner-paragraph">
            <div>
              <p>{{$t('ENABLE_CONFIG_MANAGER', { name: 'crb' })}}</p>
              <pre class="prefixed command language-bash"><code>sudo dnf config-manager --set-enabled crb</code></pre>
            </div>
            <div>
              <p>{{$t('INSTALL_REPOSITORY', { repo: 'EPEL' })}}</p>
              <pre class="prefixed command language-bash"><code>sudo dnf install \
https://dl.fedoraproject.org/pub/epel/epel-release-latest-9.noarch.rpm \
https://dl.fedoraproject.org/pub/epel/epel-next-release-latest-9.noarch.rpm</code></pre>
            </div>
            <div>
              <p>{{$t('ENABLE_REPOSITORY', { repo: 'Remi' })}}</p>
              <pre class="prefixed command language-bash"><code>sudo dnf install dnf-utils http://rpms.remirepo.net/enterprise/remi-release-9.rpm -y</code></pre>
            </div>
            <div>
              <p>{{$t('UPGRADE_SYSTEM')}}</p>
              <pre class="prefixed command language-bash"><code>sudo dnf upgrade --refresh -y</code></pre>
            </div>
            <div>
              <p>{{$t('SHOW_LIST_MODULE_OF', { name: 'PHP' })}}</p>
              <pre class="prefixed command language-bash"><code>sudo dnf module php</code></pre>
            </div>
            <div>
              <p>{{$t('ENABLE_A_MODULE_FROM_LIST')}}</p>
              <pre class="prefixed command language-bash"><code>sudo dnf module enable php:remi-8.1 -y</code></pre>
            </div>
            <div>
              <p>{{$t('INSTALL_SERVICE', { service: 'PHP' })}}</p>
              <pre class="prefixed command language-bash"><code>sudo dnf install php -y</code></pre>
            </div>
            <div>
              <p>{{$t('INSTALL_EXTENSION_FOR', { name: 'PHP' })}}</p>
              <pre class="prefixed command language-bash"><code>sudo dnf install php-cli php-curl php-mysqlnd php-gd php-opcache php-zip php-intl php-common php-bcmath php-imap php-imagick php-xmlrpc php-json php-readline php-memcached php-redis php-mbstring php-apcu php-xml php-dom php-redis php-memcached php-memcache -y</code></pre>
            </div>
            <div>
              <p>{{$t('CHECK_VERSION', { name: 'PHP' })}}</p>
              <pre class="prefixed command language-bash"><code>php -v</code></pre>
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
      title: 'PHP',
      meta: [
        // @ts-ignore
        { hid: 'description', name: 'description', content: 'PHP' },
        // @ts-ignore
        { hid: 'og:title', property: 'og:title', content: 'PHP' },
        // @ts-ignore
        { hid: 'og:description', property: 'og:description', content: 'PHP' },
        { hid: 'og:url', property: 'og:url', content: url },
      ],
    };
    return meta;
  },
}
</script>
  
<style lang="scss" scoped>
</style>
