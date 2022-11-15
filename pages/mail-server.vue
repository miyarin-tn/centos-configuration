<template>
  <div>
    <div class="head-title">
      <div class="block-inner">
        <h2 class="main-title">{{$t('MAIL_SERVER')}}</h2>
      </div>
    </div>
    <div class="content-inner">
      <div class="block-inner">
        <div class="inner-item">
          <h3 class="sub-title title-anchor" id="config-in-distributor-vps-web">
            <a href="#config-in-distributor-vps-web" class="anchor">
              <span>#</span> {{$t('CONFIG_IN_DISTRIBUTOR_VPS_WEB')}}
            </a>
          </h3>
          <div class="inner-paragraph">
            <div>
              <p>{{$t('SET_REVERSE_DNS')}}</p>
              <p>mail.{domain}</p>
            </div>
            <div>
              <p>{{$t('CONFIG', { name: 'SELINUX' })}}</p><!--Security-Enhanced Linux-->
              <pre class="prefixed command language-bash"><code>sudo nano /etc/selinux/config</code></pre>
              <pre class="language-plain"><code>SELINUX=disabled</code></pre>
            </div>
            <div>
              <p>{{$t('CONFIG', { name: 'HOSTNAME' })}}</p>
              <pre class="prefixed command language-bash"><code>sudo nano /etc/hosts</code></pre>
              <pre class="language-plain"><code>{IP_VPS} mail.{domain} mail</code></pre>
            </div>
            <div>
              <p>{{$t('CONFIG', { name: 'NETWORK' })}}</p>
              <pre class="prefixed command language-bash"><code>sudo nano /etc/sysconfig/network</code></pre>
              <pre class="language-plain"><code>HOSTNAME=mail.{domain}</code></pre>
            </div>
            <div>
              <p>{{$t('RESTART_SERVICE', { service: 'NETWORK' })}}</p>
              <pre class="prefixed command language-bash"><code>sudo systemctl restart network</code></pre>
            </div>
            <div>
              <p>{{$t('CONFIG_DNS_RECORD')}}</p>
              <pre class="language-plain"><code>A        @                    3600        {IP}
A        mail                 3600        {IP}
MX       @                    3600        mail.{domain}
TXT      @                    3600        v=spf1 +a +mx +ip4:{IP} ~all
TXT      _dmarc               3600        v=DMARC1; p=quarantine; pct=100; rua=mailto:{admin_email}; sp=none; aspf=r;
TXT      default._domainkey   3600        ...</code></pre>
            </div>
            <div>
              <p>{{$t('TEST', { name: 'HOST' })}}</p>
              <pre class="prefixed command language-bash"><code>host {domain}
{domain} has address {IP}
{domain} mail is handled by {priority} mail.{domain}</code></pre>
            </div>
            <div>
              <p>{{$t('TEST', { name: 'nslookup' })}}</p>
              <pre class="prefixed command language-bash"><code>nslookup
> mail.{domain}
Name:    mail.{domain}
Address: {IP}
> exit</code></pre>
            </div>
            <div>
              <p>{{$t('TEST', { name: 'dig' })}}</p>
              <pre class="prefixed command language-bash"><code>dig {domain}
{domain}.      {number}      IN      A      {IP}</code></pre>
              <pre class="prefixed command language-bash"><code>dig {domain} MX
{domain}.      {number}      IN      MX     10 mail.{domain}.</code></pre>
            </div>
            <div>
              <p>{{$t('TEST', { name: 'ping' })}}</p>
              <pre class="prefixed command language-bash"><code>ping mail.{domain}</code></pre>
            </div>
          </div>
        </div>
        <div class="inner-item">
          <h3 class="sub-title title-anchor" id="install-postfix">
            <a href="#install-postfix" class="anchor">
              <span>#</span> {{$t('INSTALL', { software: 'Postfix' })}}
            </a>
          </h3>
          <div class="inner-paragraph">
            <div>
              <p>{{$t('INSTALL', { software: 'Postfix' })}}</p>
              <pre class="prefixed command language-bash"><code>sudo dnf install postfix postfix-mysql -y</code></pre>
            </div>
            <div>
              <p>{{$t('ENABLE_AND_START_SERVICE', { service: 'Postfix' })}}</p>
              <pre class="prefixed command language-bash"><code>sudo systemctl enable postfix --now</code></pre>
            </div>
          </div>
        </div>
        <div class="inner-item">
          <h3 class="sub-title title-anchor" id="install-dovecot">
            <a href="#install-dovecot" class="anchor">
              <span>#</span> {{$t('INSTALL', { software: 'Dovecot' })}}
            </a>
          </h3>
          <div class="inner-paragraph">
            <div>
              <p>{{$t('INSTALL', { software: 'Dovecot' })}}</p>
              <pre class="prefixed command language-bash"><code>sudo dnf install dovecot dovecot-mysql -y</code></pre>
            </div>
            <div>
              <p>{{$t('ENABLE_AND_START_SERVICE', { service: 'Dovecot' })}}</p>
              <pre class="prefixed command language-bash"><code>sudo systemctl enable dovecot --now</code></pre>
            </div>
          </div>
        </div>
        <div class="inner-item">
          <h3 class="sub-title title-anchor" id="create-mail-database">
            <a href="#create-mail-database" class="anchor">
              <span>#</span> {{$t('CREATE_MAIL_DATABASE')}}
            </a>
          </h3>
          <div class="inner-paragraph">
            <div>
              <p>{{$t('LOGIN_MYSQL')}}</p>
              <pre class="prefixed command language-bash"><code>mysql -u root -p</code></pre>
            </div>
            <div>
              <p>{{$t('CREATE_USER')}}</p>
              <pre class="prefixed-mariadb language-mysql"><code>CREATE USER {user_db}@localhost IDENTIFIED BY '{password_db}';</code></pre>
            </div>
            <div>
              <p>{{$t('GRAND_PRIVILEGES')}}</p>
              <pre class="prefixed-mariadb language-mysql"><code>GRANT ALL PRIVILEGES ON {db_name}.* TO {user_db}@localhost;</code></pre>
            </div>
            <div>
              <p>{{$t('APPLY_PRIVILEGES')}}</p>
              <pre class="prefixed-mariadb language-bash"><code>FLUSH PRIVILEGES;</code></pre>
            </div>
            <div>
              <p>{{$t('USE_DATABASE')}}</p>
              <pre class="prefixed-mariadb language-bash"><code>USE {db_name};</code></pre>
            </div>
            <div>
              <p>{{$t('CREATE_TABLE', { table: 'domain' })}}</p>
              <pre class="prefixed-mariadb language-bash"><code>CREATE TABLE tbl_domains (
id INT NOT NULL AUTO_INCREMENT,
name VARCHAR(255) NOT NULL,
active INT NOT NULL DEFAULT 1,
PRIMARY KEY (id),
UNIQUE KEY name (name))
ENGINE=InnoDB DEFAULT CHARSET=utf8;</code></pre>
            </div>
            <div>
              <p>{{$t('CREATE_TABLE', { table: 'user' })}}</p>
              <pre class="prefixed-mariadb language-bash"><code>CREATE TABLE tbl_users (
id INT NOT NULL AUTO_INCREMENT,
email VARCHAR(255) NOT NULL,
password VARCHAR(255) NOT NULL,
full_name VARCHAR(255) NOT NULL,
department VARCHAR(255) NOT NULL,
active INT NOT NULL DEFAULT 1,
domain_id INT NOT NULL,
PRIMARY KEY (id),
UNIQUE KEY email (email),
FOREIGN KEY (domain_id) REFERENCES tbl_domains(id) ON DELETE CASCADE)
ENGINE=InnoDB DEFAULT CHARSET=utf8;</code></pre>
            </div>
            <div>
              <p>{{$t('CREATE_TABLE', { table: 'alias' })}}</p>
              <pre class="prefixed-mariadb language-bash"><code>CREATE TABLE tbl_aliases (
id INT NOT NULL AUTO_INCREMENT,
source VARCHAR(255) NOT NULL,
destination TEXT NOT NULL,
active INT NOT NULL default 1,
domain_id INT NOT NULL,
PRIMARY KEY (id),
UNIQUE KEY source (source),
FOREIGN KEY (domain_id) REFERENCES tbl_domains (id))
ENGINE=InnoDB DEFAULT CHARSET=utf8;</code></pre>
            </div>
            <div>
              <p>{{$t('INSERT_DATA_TO_TABLE')}}</p>
              <pre class="prefixed-mariadb language-bash"><code>INSERT INTO tbl_domains (name, active) VALUES ('{domain}', '1');</code></pre>
              <pre class="prefixed-mariadb language-bash"><code>INSERT INTO tbl_users (email, password, full_name, department, domain_id) VALUES ('{email}', ENCRYPT('{password}'), '{full_name}', '{department}', '1');</code></pre>
              <pre class="prefixed-mariadb language-bash"><code>INSERT INTO tbl_aliases (source, destination, domain_id) VALUES ('{alias}@{domain}', '{email}', '1');</code></pre>
            </div>
            <div>
              <p>{{$t('TEST_DATABASE')}}</p>
              <pre class="prefixed-mariadb language-bash"><code>SELECT * FROM tbl_domains;</code></pre>
              <pre class="prefixed-mariadb language-bash"><code>SELECT * FROM tbl_users;</code></pre>
              <pre class="prefixed-mariadb language-bash"><code>SELECT * FROM tbl_aliases;</code></pre>
              <pre class="prefixed-mariadb language-bash"><code>exit;</code></pre>
            </div>
          </div>
        </div>
        <div class="inner-item">
          <h3 class="sub-title title-anchor" id="config-postfix">
            <a href="#config-postfix" class="anchor">
              <span>#</span> {{$t('CONFIG', { name: 'Postfix' })}}
            </a>
          </h3>
          <div class="inner-paragraph">
            <div>
              <p>main.cf</p>
              <pre class="prefixed command language-bash"><code>sudo nano /etc/postfix/main.cf</code></pre>
              <pre class="language-plain"><code>myhostname = mail.{domain}

mydomain = {domain}

myorigin = $mydomain

inet_interfaces = all

mydestination = localhost, localhost.localdomain

mynetworks = 127.0.0.0/8

relayhost = 

recipient_delimiter = +

smtpd_banner = $myhostname ESMTP $mail_name

biff = no</code></pre>
              <p>{{$t('MOVE_END_OF_FILE')}}</p>
              <pre class="language-plain"><code># Config SASL Authentication
# Enabling SMTP for authenticated users, and handing off authentication to Dovecot 
smtpd_sasl_type = dovecot
smtpd_sasl_path = private/auth
smtpd_sasl_auth_enable = yes
broken_sasl_auth_clients = yes
smtpd_sasl_authenticated_header = yes
virtual_transport = lmtp:unix:private/dovecot-lmtp
smtpd_relay_restrictions = permit_mynetworks permit_sasl_authenticated permit_inet_interfaces reject_unauth_destination

# Config Virtual mailbox settings 
# Virtual domains, users, and aliases
virtual_alias_domains =
virtual_alias_maps = proxy:mysql:/etc/postfix/mysql-virtual_forwardings.cf, mysql:/etc/postfix/mysql-virtual_email2email.cf
virtual_mailbox_domains = proxy:mysql:/etc/postfix/mysql-virtual_domains.cf
virtual_mailbox_maps = proxy:mysql:/etc/postfix/mysql-virtual_mailboxes.cf
virtual_mailbox_base = /home/{user_mail}
virtual_uid_maps = static:5000
virtual_gid_maps = static:5000
virtual_create_maildirsize = yes
virtual_maildir_extended = yes
proxy_read_maps = $local_recipient_maps $mydestination $virtual_alias_maps $virtual_alias_domains $virtual_mailbox_maps $virtual_mailbox_domains $relay_recipient_maps $relay_domains $canonical_maps $sender_canonical_maps $recipient_canonical_maps $relocated_maps $transport_maps $mynetworks $virtual_mailbox_limit_maps

# SSL-TLS parameters
smtpd_use_tls = yes
smtpd_tls_auth_only = yes
smtp_tls_security_level = may
smtpd_tls_security_level = may
smtpd_tls_cert_file = /etc/letsencrypt/live/{domain}/fullchain.pem
smtpd_tls_key_file = /etc/letsencrypt/live/{domain}/privkey.pem
smtpd_sasl_security_options = noanonymous, noplaintext
smtpd_sasl_tls_security_options = noanonymous

# Integrate OpenDKIM with Postfix
smtpd_milters = inet:127.0.0.1:8891
non_smtpd_milters = $smtpd_milters
milter_default_action = accept

# Integrate Amavis-new with Postfix
content_filter=smtp-amavis:[127.0.0.1]:10024</code></pre>
            </div>
            <div>
              <p>mysql-virtual_domains.cf</p>
              <pre class="prefixed command language-bash"><code>sudo nano /etc/postfix/mysql-virtual_domains.cf</code></pre>
              <pre class="language-plain"><code>user = {user_db}
password = {password_db}
dbname = {db_name}
query = SELECT name FROM tbl_domains WHERE name='%s' AND active=1
hosts = 127.0.0.1</code></pre>
            </div>
            <div>
              <p>mysql-virtual_forwardings.cf</p>
              <pre class="prefixed command language-bash"><code>sudo nano /etc/postfix/mysql-virtual_forwardings.cf</code></pre>
              <pre class="language-plain"><code>user = {user_db}
password = {password_db}
dbname = {db_name}
query = SELECT destination FROM tbl_aliases WHERE source='%s' AND active=1
hosts = 127.0.0.1</code></pre>
            </div>
            <div>
              <p>mysql-virtual_mailboxes.cf</p>
              <pre class="prefixed command language-bash"><code>sudo nano /etc/postfix/mysql-virtual_mailboxes.cf</code></pre>
              <pre class="language-plain"><code>user = {user_db}
password = {password_db}
dbname = {db_name}
query = SELECT CONCAT(SUBSTRING_INDEX(email, '@', -1), '/', SUBSTRING_INDEX(email, '@', 1), '/') FROM tbl_users WHERE email='%s' AND active=1
hosts = 127.0.0.1</code></pre>
            </div>
            <div>
              <p>mysql-virtual_email2email.cf</p>
              <pre class="prefixed command language-bash"><code>sudo nano /etc/postfix/mysql-virtual_email2email.cf</code></pre>
              <pre class="language-plain"><code>user = {user_db}
password = {password_db}
dbname = {db_name}
query = SELECT email FROM tbl_users WHERE email='%s' AND active=1
hosts = 127.0.0.1</code></pre>
            </div>
            <div>
              <p>{{$t('ASSIGN_PERMISSION_FOR', { item: 'mysql-virtual_*' })}}</p>
              <pre class="prefixed command language-bash"><code>sudo chmod o= /etc/postfix/mysql-virtual_*</code></pre>
              <pre class="prefixed command language-bash"><code>sudo chgrp postfix /etc/postfix/mysql-virtual_*</code></pre>
            </div>
            <div>
              <p>{{$t('TEST_CONNECTION')}}</p>
              <pre class="prefixed command language-bash"><code>sudo postmap -q {domain} mysql:/etc/postfix/mysql-virtual_domains.cf
{domain}</code></pre>
              <pre class="prefixed command language-bash"><code>sudo postmap -q {email} mysql:/etc/postfix/mysql-virtual_mailboxes.cf
{domain}/{email_name}</code></pre>
              <pre class="prefixed command language-bash"><code>sudo postmap -q {alias}@{domain} mysql:/etc/postfix/mysql-virtual_forwardings.cf
{email}</code></pre>
            </div>
            <div>
              <p>{{$t('CREATE_GROUP_AND_ASSIGN_PERMISSION')}}</p>
              <pre class="prefixed command language-bash"><code>sudo groupadd -g 5000 {user_mail}</code></pre>
              <pre class="prefixed command language-bash"><code>sudo useradd -g {user_mail} -u 5000 {user_mail} -d /home/{user_mail} -m</code></pre>
            </div>
            <div>
              <p>master.cf</p>
              <pre class="prefixed command language-bash"><code>sudo nano /etc/postfix/master.cf</code></pre>
              <pre class="language-plain"><code>smtp       inet  n       -       n       -       -       smtpd
  -o content_filter=spamassassin
submission inet  n       -       n       -       -       smtpd
  -o syslog_name=postfix/submission
  -o smtpd_tls_security_level=encrypt
  -o smtpd_sasl_auth_enable=yes
  -o smtpd_sasl_type=dovecot
  -o smtpd_sasl_path=private/auth
  -o smtpd_reject_unlisted_recipient=no
  -o smtpd_client_restrictions=permit_sasl_authenticated,reject
  -o milter_macro_daemon_name=ORIGINATING</code></pre>
              <pre class="language-plain"><code>smtps      inet  n       -       n       -       -       smtpd
  -o syslog_name=postfix/smtps
  -o smtpd_tls_wrappermode=yes
  -o smtpd_sasl_auth_enable=yes
  -o smtpd_sasl_type=dovecot
  -o smtpd_sasl_path=private/auth
  -o smtpd_client_restrictions=permit_sasl_authenticated,reject
  -o milter_macro_daemon_name=ORIGINATING
  -o content_filter=spamassassin</code></pre>
              <p>{{$t('MOVE_END_OF_FILE')}}</p>
              <pre class="language-plain"><code>dovecot      unix  -       n       n       -       -       pipe     flags=DRhu user={user_mail}:{user_mail} argv=/usr/libexec/dovecot/deliver -f ${sender} -d ${recipient}
spamassassin unix  -       n       n       -       -       pipe     flags=R    user=spamd                   argv=/usr/bin/spamc -e /usr/sbin/sendmail -oi -f ${sender} ${recipient}
smtp-amavis  unix  -       -       n       -       2       smtp
  -o smtp_data_done_timeout=1200
  -o smtp_send_xforward_command=yes
  -o disable_dns_lookups=yes
127.0.0.1:10025 inet n     -       n      -        -       smtpd
  -o content_filter=
  -o local_recipient_maps=
  -o relay_recipient_maps=
  -o smtpd_restriction_classes=
  -o smtpd_client_restrictions=
  -o smtpd_helo_restrictions=
  -o smtpd_sender_restrictions=
  -o smtpd_recipient_restrictions=permit_mynetworks,reject
  -o mynetworks=127.0.0.0/8
  -o strict_rfc821_envelopes=yes
  -o smtpd_error_sleep_time=0
  -o smtpd_soft_error_limit=1001
  -o smtpd_hard_error_limit=1000</code></pre>
            </div>
            <div>
              <p>{{$t('RESTART_SERVICE', { service: 'Postfix' })}}</p>
              <pre class="prefixed command language-bash"><code>sudo systemctl restart postfix</code></pre>
            </div>
            <div>
              <p>{{$t('ADD_SERVICE_TO_FIREWALL')}}</p>
              <pre class="prefixed command language-bash"><code>sudo firewall-cmd --permanent --add-service=smtp</code></pre>
              <pre class="prefixed command language-bash"><code>sudo firewall-cmd --permanent --add-service=smtps</code></pre>
            </div>
            <div>
              <p>{{$t('RELOAD', { service: 'Firewall' })}}</p>
              <pre class="prefixed command language-bash"><code>sudo firewall-cmd --reload</code></pre>
            </div>
          </div>
        </div>
        <div class="inner-item">
          <h3 class="sub-title title-anchor" id="config-dovecot">
            <a href="#config-dovecot" class="anchor">
              <span>#</span> {{$t('CONFIG', { name: 'Dovecot' })}}
            </a>
          </h3>
          <div class="inner-paragraph">
            <div>
              <p>dovecot.cf</p>
              <pre class="prefixed command language-bash"><code>sudo nano /etc/dovecot/dovecot.conf</code></pre>
              <pre class="language-plain"><code>protocols = imap pop3 lmtp

listen = *</code></pre>
            </div>
            <div>
              <p>10-mail.conf</p>
              <pre class="prefixed command language-bash"><code>sudo nano /etc/dovecot/conf.d/10-mail.conf</code></pre>
              <pre class="language-plain"><code>mail_location = maildir:/home/{user_mail}/%d/%n/maildir

mail_privileged_group = mail</code></pre>
            </div>
            <div>
              <p>10-auth.conf</p>
              <pre class="prefixed command language-bash"><code>sudo nano /etc/dovecot/conf.d/10-auth.conf</code></pre>
              <pre class="language-plain"><code>disable_plaintext_auth = no (SMTP) yes (TLS)

auth_mechanisms = plain login

!include auth-sql.conf.ext</code></pre>
            </div>
            <div>
              <p>auth-sql.conf.ext</p>
              <pre class="prefixed command language-bash"><code>sudo nano /etc/dovecot/conf.d/auth-sql.conf.ext</code></pre>
              <pre class="language-plain"><code>userdb {
  driver = static
  args = uid=5000 gid=5000 home=/home/{user_mail}/%d/%n allow_all_users=yes
}</code></pre>
            </div>
            <div>
              <p>dovecot-sql.conf.ext</p>
              <pre class="prefixed command language-bash"><code>sudo nano /etc/dovecot/dovecot-sql.conf.ext</code></pre>
              <pre class="language-plain"><code>driver = mysql
connect = host=127.0.0.1 dbname={db_name} user={user_db} password={password_db}
default_pass_scheme = SHA512-CRYPT
password_query = SELECT email AS user, password FROM tbl_users WHERE email='%u' AND active=1;</code></pre>
            </div>
            <div>
              <p>{{$t('ASSIGN_PERMISSION_FOR', { item: 'dovecot-sql.conf.ext' })}}</p>
              <pre class="prefixed command language-bash"><code>sudo chgrp dovecot /etc/dovecot/dovecot-sql.conf.ext</code></pre>
              <pre class="prefixed command language-bash"><code>sudo chmod o= /etc/dovecot/dovecot-sql.conf.ext</code></pre>
            </div>
            <div>
              <p>10-master.conf</p>
              <pre class="prefixed command language-bash"><code>sudo nano /etc/dovecot/conf.d/10-master.conf</code></pre>
              <pre class="language-plain"><code>service imap-login {
  inet_listener imap {
    port = 143
  }
  inet_listener imaps {
    port = 993
    ssl = yes
  }
}</code></pre>
              <pre class="language-plain"><code>service pop3-login {
  inet_listener pop3 {
    port = 110
  }
  inet_listener pop3s {
    port = 995
    ssl = yes
  }
}</code></pre>
              <pre class="language-plain"><code>service lmtp {
  unix_listener /var/spool/postfix/private/dovecot-lmtp {
    mode = 0660
    user = postfix
    group = postfix
  }
}</code></pre>
              <pre class="language-plain"><code>service auth {
  unix_listener auth-userdb {
    mode = 0600
    user = {user_mail}
  }
  unix_listener /var/spool/postfix/private/auth {
    mode = 0660
    user = postfix
    group = postfix
  }
  user = dovecot
}</code></pre>
              <pre class="language-plain"><code>service auth-worker {
  user = {user_mail}
}</code></pre>
            </div>
            <div>
              <p>10-ssl.conf</p>
              <p>{{$t('MAIL_NO_TLS')}}</p>
              <pre class="prefixed command language-bash"><code>sudo nano /etc/dovecot/conf.d/10-ssl.conf</code></pre>
              <pre class="language-plain"><code>ssl = no
#ssh_cert = ...
#ssh_key = ...</code></pre>
              <p>{{$t('MAIL_WITH_TLS')}}</p>
              <pre class="prefixed command language-bash"><code>sudo nano /etc/dovecot/conf.d/10-ssl.conf</code></pre>
              <pre class="language-plain"><code>ssl = required
ssh_cert = &lt;/etc/letsencrypt/live/{domain}/fullchain.pem
ssh_key = &lt;/etc/letsencrypt/live/{domain}/privkey.pem</code></pre>
            </div>
            <div>
              <p>{{$t('RESTART_SERVICE', { service: 'Dovecot' })}}</p>
              <pre class="prefixed command language-bash"><code>sudo systemctl restart dovecot</code></pre>
            </div>
            <div>
              <p>{{$t('RESTART_SERVICE', { service: 'Postfix' })}}</p>
              <pre class="prefixed command language-bash"><code>sudo systemctl restart postfix</code></pre>
            </div>
            <div>
              <p>{{$t('ADD_SERVICE_TO_FIREWALL')}}</p>
              <pre class="prefixed command language-bash"><code>sudo firewall-cmd --permanent --add-service=pop3</code></pre>
              <pre class="prefixed command language-bash"><code>sudo firewall-cmd --permanent --add-service=pop3s</code></pre>
            </div>
            <div>
              <p>{{$t('RELOAD', { service: 'Firewall' })}}</p>
              <pre class="prefixed command language-bash"><code>sudo firewall-cmd --reload</code></pre>
            </div>
          </div>
        </div>
        <div class="inner-item">
          <h3 class="sub-title title-anchor" id="test-postfix">
            <a href="#test-postfix" class="anchor">
              <span>#</span> {{$t('TEST', { name: 'Postfix' })}}
            </a>
          </h3>
          <div class="inner-paragraph">
            <div>
              <p>{{$t('TEST', { name: 'SMTP' })}}</p>
              <pre class="prefixed command language-bash"><code>telnet mail.{domain} smtp
220 mail.{domain} ESMTP Postfix
ehlo mail.{domain}
250 mail.{domain}
...
quit</code></pre>
            </div>
            <div>
              <p>{{$t('TEST', { name: 'POP3' })}}</p>
              <pre class="prefixed command language-bash"><code>telnet mail.{domain} pop3
+OK Dovecot ready
quit</code></pre>
            </div>
            <div>
              <p>{{$t('VIEW_LOG_MAIL')}}</p>
              <pre class="prefixed command language-bash"><code>sudo tail -f /var/log/maillog</code></pre>
            </div>
          </div>
        </div>
        <div class="inner-item">
          <h3 class="sub-title title-anchor" id="install-roundcube">
            <a href="#install-roundcube" class="anchor">
              <span>#</span> Roundcube
            </a>
          </h3>
          <div class="inner-paragraph">
            <div>
              <p>{{$t('DOWNLOAD_CURRENT_RELEASE')}}</p>
              <pre class="prefixed command language-bash"><code>wget https://github.com/roundcube/roundcubemail/releases/download/1.6.0/roundcubemail-1.6.0-complete.tar.gz</code></pre>
            </div>
            <div>
              <p>{{$t('EXTRACT_FILE')}}</p>
              <pre class="prefixed command language-bash"><code>tar xvf roundcubemail-1.6.0-complete.tar.gz</code></pre>
            </div>
            <div>
              <p>{{$t('RENAME_FOLDER')}}</p>
              <pre class="prefixed command language-bash"><code>mv roundcubemail-1.6.0 webmail</code></pre>
            </div>
            <div>
              <p>{{$t('COPY_TO_APACHE')}}</p>
              <pre class="prefixed command language-bash"><code>sudo cp -rf webmail /var/www/html</code></pre>
            </div>
            <div>
              <p>{{$t('LOGIN_MYSQL')}}</p>
              <pre class="prefixed command language-bash"><code>mysql -u root -p</code></pre>
            </div>
            <div>
              <p>{{$t('CREATE_USER')}}</p>
              <pre class="prefixed-mariadb language-mysql"><code>CREATE USER {user_roundcube}@localhost IDENTIFIED BY '{password_roundcube}';</code></pre>
            </div>
            <div>
              <p>{{$t('GRAND_PRIVILEGES')}}</p>
              <pre class="prefixed-mariadb language-mysql"><code>GRANT ALL PRIVILEGES ON {db_roundcube}.* TO {user_roundcube}@localhost;</code></pre>
            </div>
            <div>
              <p>{{$t('APPLY_PRIVILEGES')}}</p>
              <pre class="prefixed-mariadb language-bash"><code>FLUSH PRIVILEGES;</code></pre>
              <pre class="prefixed-mariadb language-bash"><code>exit;</code></pre>
            </div>
            <div>
              <p>{{$t('INIT_DATABASE')}}</p>
              <pre class="prefixed command language-bash"><code>mysql -u {user_roundcube} -p roundcubemail &lt; /var/www/webmail/SQL/mysql.initial.sql</code></pre>
            </div>
            <div>
              <p>{{$t('CHANGE_TIMEZONE')}}</p>
              <pre class="prefixed command language-bash"><code>sudo nano /etc/php.ini</code></pre>
              <pre class="language-plain"><code>date.timezone = Asia/Ho_Chi_Minh</code></pre>
            </div>
            <div>
              <p>{{$t('ACCESS_INSTALLER')}}</p>
              <pre class="language-plain"><code>https://mail.{domain}/installer</code></pre>
            </div>
            <div>
              <p>{{$t('IMAP_HOST')}}</p>
              <pre class="language-plain"><code>ssl://mail.{domain}
Port: 993</code></pre>
            </div>
            <div>
              <p>{{$t('SMTP_SERVER')}}</p>
              <pre class="language-plain"><code>tls://mail.{domain}
Port: 587</code></pre>
              <pre class="language-plain"><code>ssl://mail.{domain}
Port: 465</code></pre>
            </div>
            <div>
              <p>{{$t('CHECK_PLUGIN_AND_SAVE_CONFIG')}}</p>
              <p>{{$t('SAVE_AS_UNDER_DIRECTORY', { name: 'config.inc.php', directory: '/var/www/webmail/config/' })}}</p>
              <p>{{$t('TEST_AND_REMOVE_INSTALLER_DIRECTORY')}}</p>
            </div>
          </div>
        </div>
        <div class="inner-item">
          <h3 class="sub-title title-anchor" id="install-spamassassin">
            <a href="#install-spamassassin" class="anchor">
              <span>#</span> SpamAssassin
            </a>
          </h3>
          <div class="inner-paragraph">
            <div>
              <p>{{$t('INSTALL', { software: 'SpamAssassin' })}}</p>
              <pre class="prefixed command language-bash"><code>sudo dnf install spamassassin -y</code></pre>
            </div>
            <div>
              <p>{{$t('CONFIG', { name: 'SpamAssassin' })}}</p>
              <pre class="prefixed command language-bash"><code>sudo nano /etc/mail/spamassassin/local.cf</code></pre>
              <pre class="language-plain"><code>required_score 5</code></pre>
            </div>
            <div>
              <p>{{$t('ASSIGN_PERMISSION_FOR', { item: 'SpamAssassin' })}}</p>
              <pre class="prefixed command language-bash"><code>sudo groupadd -g 5555 spamd</code></pre>
              <pre class="prefixed command language-bash"><code>sudo useradd -u 5555 -g spamd -s /bin/false -d /var/log/spamassassin spamd</code></pre>
              <pre class="prefixed command language-bash"><code>sudo chown spamd:spamd /var/log/spamassassin</code></pre>
            </div>
            <div>
              <p>{{$t('ENABLE_AND_START_SERVICE', { service: 'SpamAssassin' })}}</p>
              <pre class="prefixed command language-bash"><code>sudo systemctl enable spamassassin --now</code></pre>
            </div>
            <div>
              <p>{{$t('RESTART_SERVICE', { service: 'Dovecot' })}}</p>
              <pre class="prefixed command language-bash"><code>sudo systemctl restart dovecot</code></pre>
            </div>
            <div>
              <p>{{$t('RESTART_SERVICE', { service: 'Postfix' })}}</p>
              <pre class="prefixed command language-bash"><code>sudo systemctl restart postfix</code></pre>
            </div>
          </div>
        </div>
        <div class="inner-item">
          <h3 class="sub-title title-anchor" id="install-opendkim">
            <a href="#install-opendkim" class="anchor">
              <span>#</span> OpenDKIM
            </a>
          </h3>
          <div class="inner-paragraph">
            <div>
              <p>{{$t('INSTALL', { software: 'OpenDKIM' })}}</p>
              <pre class="prefixed command language-bash"><code>sudo dnf install opendkim -y</code></pre>
            </div>
            <div>
              <p>{{$t('CREATE_PUBLIC_AND_PRIVATE_KEY')}}</p>
              <pre class="prefixed command language-bash"><code>sudo opendkim-default-keygen</code></pre>
              <pre class="prefixed command language-bash"><code>ls -la /etc/opendkim/keys</code></pre>
            </div>
            <div>
              <p>{{$t('CONFIG', { name: 'OpenDKIM' })}}</p>
              <pre class="prefixed command language-bash"><code>sudo nano /etc/opendkim.conf</code></pre>
              <pre class="language-plain"><code>Mode sv

Socket inet:8891@127.0.0.1

Umask 022

Canonicalization relaxed/simple

Domain {domain}

# KeyFile ...

KeyTable refile:/etc/opendkim/KeyTable

SigningTable refile:/etc/opendkim/SigningTable

ExternalIgnoreList refile:/etc/opendkim/TrustedHosts

InternalHosts refile:/etc/opendkim/TrustedHosts</code></pre>
              <pre class="prefixed command language-bash"><code>ls -la /etc/opendkim</code></pre>
              <pre class="prefixed command language-bash"><code>sudo nano /etc/opendkim/KeyTable</code></pre>
              <pre class="language-plain"><code>default._domainkey.{domain} {domain}:default:/etc/opendkim/keys/default.private</code></pre>
              <pre class="prefixed command language-bash"><code>sudo nano /etc/opendkim/SigningTable</code></pre>
              <pre class="language-plain"><code>*@{domain} default._domainkey.{domain}</code></pre>
              <pre class="prefixed command language-bash"><code>sudo nano /etc/opendkim/TrustedHosts</code></pre>
              <pre class="language-plain"><code># ::1
{domain}
mail.{domain}</code></pre>
            </div>
            <div>
              <p>{{$t('RESTART_SERVICE', { service: 'Dovecot' })}}</p>
              <pre class="prefixed command language-bash"><code>sudo systemctl restart dovecot</code></pre>
            </div>
            <div>
              <p>{{$t('RESTART_SERVICE', { service: 'Postfix' })}}</p>
              <pre class="prefixed command language-bash"><code>sudo systemctl restart postfix</code></pre>
            </div>
            <div>
              <p>{{$t('ENABLE_AND_START_SERVICE', { service: 'OpenDKIM' })}}</p>
              <pre class="prefixed command language-bash"><code>sudo systemctl enable opendkim --now</code></pre>
            </div>
            <div>
              <p>{{$t('COPY_OPENDKIM_KEY_IN_CONFIG')}}</p>
              <pre class="prefixed command language-bash"><code>sudo nano /etc/opendkim/keys/default.txt</code></pre>
            </div>
            <div>
              <p>{{$t('SEND_EMAIL_TO_VERIFY')}}</p>
              <pre class="language-plain"><code>check-auth@verifier.port25.com</code></pre>
            </div>
          </div>
        </div>
        <div class="inner-item">
          <h3 class="sub-title title-anchor" id="install-check-virus">
            <a href="#install-check-virus" class="anchor">
              <span>#</span> {{$t('CHECK_VIRUS')}}
            </a>
          </h3>
          <div class="inner-paragraph">
            <div>
              <p>{{$t('INSTALL', { software: 'Amavisd' })}}</p>
              <pre class="prefixed command language-bash"><code>sudo dnf install clamav clamav-update amavisd-new -y</code></pre>
            </div>
            <div>
              <p>{{$t('CONFIG', { name: 'Amavisd' })}}</p>
              <pre class="prefixed command language-bash"><code>sudo nano /etc/amavisd/amavisd.conf</code></pre>
              <pre class="language-plain"><code>$mydomain = '{domain}';
$myhostname = 'mail.{domain}';
$notify_method  = 'smtp:[127.0.0.1]:10025';
$forward_method = 'smtp:[127.0.0.1]:10025';</code></pre>
            </div>
            <div>
              <p>{{$t('ENABLE_AND_START_SERVICE', { service: 'Amavisd' })}}</p>
              <pre class="prefixed command language-bash"><code>sudo systemctl enable amavisd --now</code></pre>
            </div>
            <div>
              <p>{{$t('RESTART_SERVICE', { service: 'Postfix' })}}</p>
              <pre class="prefixed command language-bash"><code>sudo systemctl restart postfix</code></pre>
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
