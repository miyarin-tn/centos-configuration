<template>
  <div>
    <div class="head-title">
      <div class="block-inner">
        <h2 class="main-title">Apache</h2>
      </div>
    </div>
    <div class="content-inner">
      <div class="block-inner">
        <div class="inner-item">
          <h3 class="sub-title title-anchor" id="install-apache">
            <a href="#install-apache" class="anchor">
              <span>#</span> {{$t('INSTALL', { software: 'Apache' })}}
            </a>
          </h3>
          <div class="inner-paragraph">
            <div>
              <p>{{$t('UPGRADE_SYSTEM')}}</p>
              <pre class="prefixed command language-bash"><code>sudo dnf upgrade --refresh -y</code></pre>
            </div>
            <div>
              <p>{{$t('INSTALL_SERVICE', { service: 'httpd' })}}</p>
              <pre class="prefixed command language-bash"><code>sudo dnf install httpd -y</code></pre>
            </div>
            <div>
              <p>{{$t('SET_SERVER_NAME')}}</p>
              <pre class="prefixed command language-bash"><code>sudo nano /etc/httpd/conf/httpd.conf</code></pre>
              <pre class="language-plain"><code>ServerName 127.0.0.1</code></pre>
            </div>
            <div>
              <p>{{$t('CHECK_CONFIG', { name: 'Apache' })}}</p>
              <pre class="prefixed command language-bash"><code>apachectl configtest</code></pre>
            </div>
            <div>
              <p>{{$t('ENABLE_AND_START_SERVICE', { service: 'httpd' })}}</p>
              <pre class="prefixed command language-bash"><code>sudo systemctl enable httpd --now</code></pre>
            </div>
            <div>
              <p>{{$t('ADD_SERVICE_TO_FIREWALL')}}</p>
              <pre class="prefixed command language-bash"><code>sudo firewall-cmd --permanent --add-service=http</code></pre>
              <pre class="prefixed command language-bash"><code>sudo firewall-cmd --permanent --add-service=https</code></pre>
            </div>
            <div>
              <p>{{$t('RELOAD', { service: 'Firewall' })}}</p>
              <pre class="prefixed command language-bash"><code>sudo firewall-cmd --reload</code></pre>
            </div>
          </div>
        </div>
        <div class="inner-item">
          <h3 class="sub-title title-anchor" id="config-virtual-host">
            <a href="#config-virtual-host" class="anchor">
              <span>#</span> {{$t('CONFIG', { name: 'Gzip'})}}
            </a>
          </h3>
          <div class="inner-paragraph">
            <div>
              <p>{{$t('CONFIG', { name: 'Gzip'})}}</p>
              <pre class="prefixed command language-bash"><code>sudo nano /etc/httpd/httpd.conf</code></pre>
              <pre class="language-plain"><code># Enable gzip with mod_deflate configuration
&lt;IfModule mod_deflate.c&gt;
    # Restrict compression to these MIME types
    AddOutputFilterByType DEFLATE text/plain
    AddOutputFilterByType DEFLATE text/html
    AddOutputFilterByType DEFLATE application/xhtml+xml
    AddOutputFilterByType DEFLATE text/xml
    AddOutputFilterByType DEFLATE application/xml
    AddOutputFilterByType DEFLATE application/x-javascript
    AddOutputFilterByType DEFLATE text/javascript
    AddOutputFilterByType DEFLATE text/css

    # Level of compression (Highest 9 - Lowest 1)
    DeflateCompressionLevel 9

    # Netscape 4.x has some problems.
    BrowserMatch ^Mozilla/4 gzip-only-text/html

    # Netscape 4.06-4.08 have some more problems
    BrowserMatch ^Mozilla/4\.0[678] no-gzip

    # MSIE masquerades as Netscape, but it is fine
    BrowserMatch \bMSI[E] !no-gzip !gzip-only-text/html
&lt;/IfModule&gt;</code></pre>
            </div>
          </div>
        </div>
        <div class="inner-item">
          <h3 class="sub-title title-anchor" id="config-virtual-host">
            <a href="#config-virtual-host" class="anchor">
              <span>#</span> {{$t('CONFIG_VIRTUAL_HOST')}}
            </a>
          </h3>
          <div class="inner-paragraph">
            <div>
              <p>{{$t('CREATE_VIRTUAL_HOST_CONFIG_FILE')}}</p>
              <pre class="prefixed command language-bash"><code>sudo touch /etc/httpd/conf.d/{domain}.conf</code></pre>
              <pre class="language-plain"><code>&lt;VirtualHost *:80&gt;
    DocumentRoot "/var/www/{domain}/build"
    ServerAdmin admin@{domain}
    ServerName {domain}
    ServerAlias www.{domain}
    ErrorLog logs/{domain}-error_log
    CustomLog logs/{domain}-access_log common
#    &lt;Directory "/var/www/{domain}/build"&gt;
#        Options FollowSymLinks
#        AllowOverride All
#        DirectoryIndex index.html index.php
#        Require all granted
#    &lt;/Directory&gt;
&lt;/VirtualHost&gt;</code></pre>
            </div>
            <div>
              <p>{{$t('CONFIG_PROXY_PASS')}}</p>
              <pre class="language-plain"><code>ProxyPreserveHost On
&lt;Proxy *&gt;
    Order allow,deny
    Allow from all
&lt;/Proxy&gt;
ProxyPass / http://localhost:{port}/
ProxyPassReverse / http://localhost:{port}/</code></pre>
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
      title: 'Apache',
      meta: [
        // @ts-ignore
        { hid: 'description', name: 'description', content: 'Apache' },
        // @ts-ignore
        { hid: 'og:title', property: 'og:title', content: 'Apache' },
        // @ts-ignore
        { hid: 'og:description', property: 'og:description', content: 'Apache' },
        { hid: 'og:url', property: 'og:url', content: url },
      ],
    };
    return meta;
  },
}
</script>
  
<style lang="scss" scoped>
</style>
