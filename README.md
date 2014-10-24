chef-marketplace Cookbook
=================

Pulls down the latest chef-marketplace code, builds the code, installs the dependencies, and then starts the evm processes.

Requirements
------------
### Platforms
Tested on RHEL 6.5 and CentOS 6.5. Should work on any Red Hat family distributions.

### Cookbooks
- apache2
- ntp
- php
- fail2ban
- openssl
- mysql
- database
- iptables
- selinux

Attributes
----------
######Attributes specifically for chef-marketplace, HTTP Server
- `default["chef-marketplace"]["path"]` - Path for the website files (default: "/var/www/html")

######Attributes specifically for chef-marketplace, MySQL Database
- `default["chef-marketplace"]["db_host"]` - Host of the database server (default: "127.0.0.1")
- `default["chef-marketplace"]["db_name"]` - Name of the database schema (default: "marketplace")
- `default["chef-marketplace"]["db_user"]` - Username for the database user (default: "root")
- `default["chef-marketplace"]["db_pass"]` - Password for the database user
- `default["chef-marketplace"]["db_prefix"]` - Database table prefix (default: "")

Usage
-----
Simply add the cookbook to your runlist or add the cookbook to a role you have created.


Deploying a Booz Allen Hamilton Marketplace system
-----------
This section details "quick deployment" steps using chef-solo

1. Install Chef Client


          $ curl -L https://www.opscode.com/chef/install.sh | sudo bash

2. Create a Chef repo folder and a cookbooks folder under the /tmp directory


          $ mkdir -p /tmp/chef/cookbooks
          $ cd /tmp/chef/

3. Create a solo.rb file


          $ vi /tmp/chef/solo.rb
         
               file_cache_path "/tmp/chef/roles"
               cookbook_path "/tmp/chef/cookbooks"

4. Create a marketplace.json file, this will be the attributes file and contains the run_list


          $ vi /tmp/chef/marketplace.json
        
                {
                  "run_list": [
                  "recipe[chef-marketplace]"
                 ]
                }

5. Download and extract the cookbook dependencies:


          $ cd /tmp/chef/cookbooks
          $ knife cookbook site download apache2
          $ tar xvfz apache2-*.tar.gz
          $ rm -f apache2-*.tar.gz
          $ knife cookbook site download ntp
          $ tar xvfz ntp-*.tar.gz
          $ rm -f ntp-*.tar.gz
          $ knife cookbook site download php
          $ tar xvfz php-*.tar.gz
          $ rm -f php-*.tar.gz
          $ knife cookbook site download fail2ban
          $ tar xvfz fail2ban-*.tar.gz
          $ rm -f fail2ban-*.tar.gz
          $ knife cookbook site download openssl
          $ tar xvfz openssl-*.tar.gz
          $ rm -f openssl-*.tar.gz
          $ knife cookbook site download mysql
          $ tar xvfz mysql-*.tar.gz
          $ rm -f mysql-*.tar.gz
          $ knife cookbook site download database
          $ tar xvfz database-*.tar.gz
          $ rm -f database-*.tar.gz
          $ knife cookbook site download iptables
          $ tar xvfz iptables-*.tar.gz
          $ rm -f iptables-*.tar.gz
          $ knife cookbook site download selinux
          $ tar xvfz selinux-*.tar.gz
          $ rm -f selinux-*.tar.gz
          $ knife cookbook site download postgresql
          $ tar xvfz postgresql-*.tar.gz
          $ rm -f postgresql-*.tar.gz
          $ knife cookbook site download aws
          $ tar xvfz aws-*.tar.gz
          $ rm -f aws-*.tar.gz
          $ knife cookbook site download apt
          $ tar xvfz apt-*.tar.gz
          $ rm -f apt-*.tar.gz
          $ knife cookbook site download xfs
          $ tar xvfz xfs-*.tar.gz
          $ rm -f xfs-*.tar.gz
          $ knife cookbook site download mysql-chef_gem
          $ tar xvfz mysql-chef_gem-*.tar.gz
          $ rm -f mysql-chef_gem-*.tar.gz
          $ knife cookbook site download yum-mysql-community
          $ tar xvfz yum-mysql-community-*.tar.gz
          $ rm -f yum-mysql-community-*.tar.gz
          $ knife cookbook site download chef-sugar
          $ tar xvfz chef-sugar-*.tar.gz
          $ rm -f chef-sugar-*.tar.gz
          $ knife cookbook site download yum
          $ tar xvfz yum-*.tar.gz
          $ rm -f yum-*.tar.gz
          $ knife cookbook site download yum-epel
          $ tar xvfz yum-epel-*.tar.gz
          $ rm -f yum-epel-*.tar.gz
          $ knife cookbook site download build-essential
          $ tar xvfz build-essential-*.tar.gz
          $ rm -f build-essential-*.tar.gz
          $ knife cookbook site download xml
          $ tar xvfz xml-*.tar.gz
          $ rm -f xml-*.tar.gz
          $ knife cookbook site download windows
          $ tar xvfz windows-*.tar.gz
          $ rm -f windows-*.tar.gz
          $ knife cookbook site download iis
          $ tar xvfz iis-*.tar.gz
          $ rm -f iis-*.tar.gz
          $ knife cookbook site download logrotate
          $ tar xvfz logrotate-*.tar.gz
          $ rm -f logrotate-*.tar.gz
          $ knife cookbook site download pacman
          $ tar xvfz pacman-*.tar.gz
          $ rm -f pacman-*.tar.gz
          $ knife cookbook site download chef_handler
          $ tar xvfz chef_handler-*.tar.gz
          $ rm -f chef_handler-*.tar.gz


5. Download and extract the cookbook:


          $ cd /tmp/chef/cookbooks
          $ knife cookbook site download chef-marketplace
          $ tar xvfz chef-marketplace-*.tar.gz
          $ rm -f chef-marketplace-*.tar.gz
    
7. Run Chef-solo:


          $ cd /tmp/chef
          $ chef-solo -c solo.rb -j marketplace.json


License & Authors
-----------------
- Author:: Chris Kacerguis
- Author:: Mandeep Bal

```text
Copyright:: 2014, Booz Allen Hamilton

For more information on the license, please refer to the LICENSE.txt file in the repo
```
