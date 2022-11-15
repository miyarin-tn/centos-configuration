<template>
  <div>
    <div class="head-title">
      <div class="block-inner">
        <h2 class="main-title">{{ $t('GETTING_STARTED') }}</h2>
      </div>
    </div>
    <div class="content-inner">
      <div class="block-inner">
        <div class="inner-item">
          <h3 class="sub-title title-anchor" id="update-system">
            <a href="#update-system" class="anchor">
              <span>#</span> {{$t('UPDATE_SYSTEM')}}
            </a>
          </h3>
          <div class="inner-paragraph">
            <div>
              <p>{{$t('CHECK_UPDATE_SYSTEM')}}</p>
              <pre class="prefixed command language-bash root"><code>dnf -y update</code></pre>
            </div>
          </div>
        </div>
        <div class="inner-item">
          <h3 class="sub-title title-anchor" id="sshd-config">
            <a href="#sshd-config" class="anchor">
              <span>#</span> {{$t('LOGIN_BY_PUBLICKEY')}}
            </a>
          </h3>
          <div class="inner-paragraph">
            <div>
              <p>{{$t('EDIT_SSH_CONFIG_FILE')}}</p>
              <pre class="prefixed command language-bash root"><code>nano /etc/ssh/sshd_config</code></pre>
            </div>
            <div>
              <p>{{$t('ADD_LOGIN_BY_PUBLICKEY')}}</p>
              <pre class="language-plain"><code>PubkeyAuthentication yes
AuthorizedKeysFile .ssh/authorized_keys</code></pre>
            </div>
            <div>
              <p>{{$t('RESTART_SERVICE', { service: 'sshd' })}}</p>
              <pre class="prefixed command language-bash root"><code>systemctl restart sshd</code></pre>
            </div>
            <div>
              <p>{{$t('CREATE_AUTHORIZED_FILE')}}</p>
              <pre class="prefixed command language-bash root"><code>touch ~/.ssh/authorized_keys</code></pre>
            </div>
            <div>
              <p>{{$t('ADD_CONTENT_SSH')}}</p>
              <pre class="language-plain"><code>ssh-ed25519 {public key content}</code></pre>
            </div>
            <div>
              <p>{{$t('ASSIGN_PERMISSION_FOR', { item: 'ssh' })}}</p>
              <pre class="prefixed command language-bash root"><code>chmod 700 -R ~/.ssh</code></pre>
              <pre class="prefixed command language-bash root"><code>chmod 600 ~/.ssh/authorized_keys</code></pre>
            </div>
          </div>
        </div>
        <div class="inner-item">
          <h3 class="sub-title title-anchor" id="config-language">
            <a href="#config-language" class="anchor">
              <span>#</span> {{$t('SET_LANGUAGE_FOR_SERVER')}}
            </a>
          </h3>
          <div class="inner-paragraph">
            <div>
              <p>{{$t('CHECK_CURRENT_LANGUAGE')}}</p>
              <pre class="prefixed command language-bash root"><code>localectl</code></pre>
            </div>
            <div>
              <p>{{$t('CHECK_LIST_LANGUAGE_SUPPORTED')}}</p>
              <pre class="prefixed command language-bash root"><code>localectl list-locales</code></pre>
            </div>
            <div>
              <p>{{$t('SET_MAIN_LANGUAGE')}}</p>
              <pre class="prefixed command language-bash root"><code>localectl set-locale LANG=en_US.UTF-8</code></pre>
            </div>
          </div>
        </div>
        <div class="inner-item">
          <h3 class="sub-title title-anchor" id="add-user">
            <a href="#add-user" class="anchor">
              <span>#</span> {{$t('ADD_USER')}}
            </a>
          </h3>
          <div class="inner-paragraph">
            <div>
              <p>{{$t('ADD_A_NEW_USER')}}</p>
              <pre class="prefixed command language-bash root"><code>adduser {user}</code></pre>
            </div>
            <div>
              <p>{{$t('SET_PASSWORD_USER')}}</p>
              <pre class="prefixed command language-bash root"><code>passwd {user}</code></pre>
            </div>
            <div>
              <p>{{$t('ADD_USER_TO_SUDOERS')}}</p>
              <pre class="prefixed command language-bash root"><code>usermod -aG wheel {user}</code></pre>
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
      title: this.$t('GETTING_STARTED'),
      meta: [
        // @ts-ignore
        { hid: 'description', name: 'description', content: this.$t('GETTING_STARTED') },
        // @ts-ignore
        { hid: 'og:title', property: 'og:title', content: this.$t('GETTING_STARTED') },
        // @ts-ignore
        { hid: 'og:description', property: 'og:description', content: this.$t('GETTING_STARTED') },
        { hid: 'og:url', property: 'og:url', content: url },
      ],
    };
    return meta;
  },
}
</script>
  
<style lang="scss" scoped>
</style>
