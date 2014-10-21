name             'chef-marketplace'
maintainer       'Booz Allen Hamilton'
maintainer_email 'jellyfishopensource@bah.com'
license          'All rights reserved'
description      'Installs/Configures bah-marketplace'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.1'

depends "apache2"
depends "ntp"
depends "php"
depends "fail2ban"
depends "openssl"
depends "mysql"
depends "database"
depends "iptables"
depends "selinux"