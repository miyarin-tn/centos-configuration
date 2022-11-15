<template>
  <div>
    <div class="head-title">
      <div class="block-inner">
        <h2 class="main-title">{{ $t('WEB_SERVER') }}</h2>
      </div>
    </div>
    <div class="content-inner">
      <div class="block-inner">
        <div class="inner-item">
          <h3 class="sub-title title-anchor" id="web-server">
            <a href="#web-server" class="anchor">
              <span>#</span> {{$t('WEB_SERVER')}}
            </a>
          </h3>
          <div class="inner-paragraph">
            <ul>
              <li>
                <p>Apache</p>
              </li>
              <li>
                <p>Nginx</p>
              </li>
              <li>
                <p>{{$t('OTHER')}}</p>
              </li>
            </ul>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script lang="ts">

export default {
  name: 'IndexPage',
  // @ts-ignore
  head() {
    // @ts-ignore
    const fullPath = this.$nuxt.$route.fullPath.replace(/\/+$/, '')
    const url = `${process.env.DOMAIN}${fullPath ? '/' + fullPath : ''}`;
    let meta: any = {
      // @ts-ignore
      title: this.$t('WEB_SERVER'),
      meta: [
        // @ts-ignore
        { hid: 'description', name: 'description', content: this.$t('WEB_SERVER') },
        // @ts-ignore
        { hid: 'og:title', property: 'og:title', content: this.$t('WEB_SERVER') },
        // @ts-ignore
        { hid: 'og:description', property: 'og:description', content: this.$t('WEB_SERVER') },
        { hid: 'og:url', property: 'og:url', content: url },
      ],
    };
    return meta;
  },
}
</script>
