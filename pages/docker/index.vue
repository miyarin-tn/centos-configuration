<template>
  <div>
    <div class="head-title">
      <div class="block-inner">
        <h2 class="main-title">Docker</h2>
      </div>
    </div>
    <div class="content-inner">
      <div class="block-inner">
        <div class="inner-item">
          <h3 class="sub-title title-anchor" id="install-docker">
            <a href="#install-docker" class="anchor">
              <span>#</span> {{$t('INSTALL', { software: 'Docker' })}}
            </a>
          </h3>
          <div class="inner-paragraph">
            <div>
              <p>{{$t('CHECK_UPDATE_SYSTEM')}}</p>
              <pre class="prefixed command language-bash"><code>sudo dnf -y update</code></pre>
            </div>
            <div>
              <p>{{$t('INSTALL_REPOSITORY', { repo: 'Docker' })}}</p>
              <pre class="prefixed command language-bash"><code>curl -fsSL https://get.docker.com/ | sh</code></pre>
            </div>
            <div>
              <p>{{$t('ENABLE_AND_START_SERVICE', { service: 'Docker' })}}</p>
              <pre class="prefixed command language-bash"><code>sudo systemctl enable docker --now</code></pre>
            </div>
            <div>
              <p>{{$t('EXECUTE_WITHOUT_SUDO')}}</p>
              <pre class="prefixed command language-bash"><code>sudo usermod -aG docker $(whoami)</code></pre>
            </div>
          </div>
        </div>
        <div class="inner-item">
          <h3 class="sub-title title-anchor" id="how-to-use-docker">
            <a href="#how-to-use-docker" class="anchor">
              <span>#</span> {{$t('HOW_TO_USE')}}
            </a>
          </h3>
          <div class="inner-paragraph">
            <div>
              <p>{{$t('DOCKER_BUILD_IMAGE')}}</p>
              <pre class="prefixed command language-bash"><code>docker build -t {image_name} .</code></pre>
            </div>
            <div>
              <p>{{$t('DOCKER_RUN_IMAGE')}}</p>
              <pre class="prefixed command language-bash"><code>docker run -d -v .:{virtual_path} -p {real_port}:{container_expose_port} {image_name}</code></pre>
            </div>
          </div>
        </div>
        <div class="inner-item">
          <h3 class="sub-title title-anchor" id="remove-something-in-docker">
            <a href="#remove-something-in-docker" class="anchor">
              <span>#</span> {{$t('REMOVE_SOMETHING_IN_DOCKER')}}
            </a>
          </h3>
          <div class="inner-paragraph">
            <ul>
              <li>
                <p class="item-title">{{$t('CONTAINER')}}</p>
                <div>
                  <p>{{$t('DOCKER_REMOVE_A_CONTAINER')}}</p>
                  <pre class="prefixed command language-bash"><code>docker stop {container_id|container_name}</code></pre>
                  <pre class="prefixed command language-bash"><code>docker rm {container_id|container_name}</code></pre>
                </div>
                <div>
                  <p>{{$t('DOCKER_REMOVE_UNUSED_CONTAINERS')}}</p>
                  <pre class="prefixed command language-bash"><code>docker container prune</code></pre>
                </div>
                <div>
                  <p>{{$t('DOCKER_REMOVE_ALL_CONTAINERS')}}</p>
                  <pre class="prefixed command language-bash"><code>docker stop $(docker ps -q)</code></pre>
                  <pre class="prefixed command language-bash"><code>docker rm $(docker ps -a -q)</code></pre>
                </div>
              </li>
              <li>
                <p class="item-title">{{$t('IMAGE')}}</p>
                <div>
                  <p>{{$t('DOCKER_REMOVE_AN_IMAGE')}}</p>
                  <pre class="prefixed command language-bash"><code>docker rmi {image_id|image_name}</code></pre>
                </div>
                <div>
                  <p>{{$t('DOCKER_REMOVE_DANGLING_IMAGES')}}</p>
                  <pre class="prefixed command language-bash"><code>docker image prune</code></pre>
                </div>
                <div>
                  <p>{{$t('DOCKER_REMOVE_ALL_IMAGES')}}</p>
                  <pre class="prefixed command language-bash"><code>docker image prune -a</code></pre>
                </div>
              </li>
              <li>
                <p class="item-title">{{$t('VOLUME')}}</p>
                <div>
                  <p>{{$t('DOCKER_REMOVE_VOLUMES')}}</p>
                  <pre class="prefixed command language-bash"><code>docker volume prune</code></pre>
                </div>
              </li>
              <li>
                <p class="item-title">{{$t('NETWORK')}}</p>
                <div>
                  <p>{{$t('DOCKER_REMOVE_NETWORKS')}}</p>
                  <pre class="prefixed command language-bash"><code>docker network prune</code></pre>
                </div>
              </li>
              <li>
                <p class="item-title">{{$t('EVERYTHING')}}</p>
                <div>
                  <p>{{$t('DOCKER_REMOVE_EVERYTHING')}}</p>
                  <pre class="prefixed command language-bash"><code>docker system prune</code></pre>
                </div>
                <div>
                  <p>{{$t('DOCKER_REMOVE_EVERYTHING_INCLUDE_VOLUMES')}}</p>
                  <pre class="prefixed command language-bash"><code>docker system prune --volumes</code></pre>
                </div>
              </li>
            </ul>
          </div>
        </div>
        <div class="inner-item">
          <h3 class="sub-title title-anchor" id="remove-docker-cache">
            <a href="#remove-docker-cache" class="anchor">
              <span>#</span> {{$t('DOCKER_REMOVE_BUILD_CACHE')}}
            </a>
          </h3>
          <div class="inner-paragraph">
            <div>
              <p>{{$t('DOCKER_REMOVE_BUILD_CACHE')}}</p>
              <pre class="prefixed command language-bash"><code>docker builder prune</code></pre>
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
      title: 'Docker',
      meta: [
        // @ts-ignore
        { hid: 'description', name: 'description', content: 'Docker' },
        // @ts-ignore
        { hid: 'og:title', property: 'og:title', content: 'Docker' },
        // @ts-ignore
        { hid: 'og:description', property: 'og:description', content: 'Docker' },
        { hid: 'og:url', property: 'og:url', content: url },
      ],
    };
    return meta;
  },
}
</script>
  
<style lang="scss" scoped>
</style>
