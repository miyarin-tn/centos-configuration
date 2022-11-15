<template>
  <div>
    <div class="head-title">
      <div class="block-inner">
        <h2 class="main-title">Docker compose</h2>
      </div>
    </div>
    <div class="content-inner">
      <div class="block-inner">
        <div class="inner-item">
          <h3 class="sub-title title-anchor" id="install-docker-compose">
            <a href="#install-docker-compose" class="anchor">
              <span>#</span> {{$t('INSTALL', { software: 'Docker compose' })}}
            </a>
          </h3>
          <div class="inner-paragraph">
            <div>
              <p>{{$t('DOWNLOAD_CURRENT_RELEASE')}}</p>
              <pre class="prefixed command language-bash"><code>sudo curl -L "https://github.com/docker/compose/releases/download/v{2.12.2}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose</code></pre>
            </div>
            <div>
              <p>{{$t('ASSIGN_PERMISSION_FOR', { item: 'Docker compose' })}}</p>
              <pre class="prefixed command language-bash"><code>sudo chmod +x /usr/local/bin/docker-compose</code></pre>
            </div>
            <div>
              <p>{{$t('CHECK_VERSION', { name: 'Docker compose' })}}</p>
              <pre class="prefixed command language-bash"><code>docker-compose --version</code></pre>
            </div>
          </div>
        </div>
        <div class="inner-item">
          <h3 class="sub-title title-anchor" id="how-to-use-docker-compose">
            <a href="#how-to-use-docker-compose" class="anchor">
              <span>#</span> {{$t('HOW_TO_USE')}}
            </a>
          </h3>
          <div class="inner-paragraph">
            <div>
              <p>{{$t('DOCKER_RUN_IMAGE')}}</p>
              <pre class="prefixed command language-bash"><code>docker-compose up [service_name]</code></pre>
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
      title: 'Docker compose',
      meta: [
        // @ts-ignore
        { hid: 'description', name: 'description', content: 'Docker compose' },
        // @ts-ignore
        { hid: 'og:title', property: 'og:title', content: 'Docker compose' },
        // @ts-ignore
        { hid: 'og:description', property: 'og:description', content: 'Docker compose' },
        { hid: 'og:url', property: 'og:url', content: url },
      ],
    };
    return meta;
  },
}
</script>
  
<style lang="scss" scoped>
</style>
