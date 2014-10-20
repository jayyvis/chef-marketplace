bah-marketplace Cookbook
=================
[![Build Status](https://secure.travis-ci.org/jellyfish/bah-marketplace.png?branch=master)](http://travis-ci.org/jellyfish/bah-marketplace)

Pulls down the latest bah-marketplace code, builds the code, installs the dependencies, and then starts the evm processes.

Requirements
------------
### Platforms
Tested on RHEL 6.5 and CentOS 6.5. Should work on any Red Hat family distributions.

### Cookbooks
- apache2
- mysql
- php
- apache2
- fail2ban
- database

Attributes
----------
######Attributes specifically for bah-marketplace, HTTP Server
- `default["bah-marketplace"]["path"]` - Path for the website files (default: "/var/www/html")

######Attributes specifically for bah-marketplace, MySQL Database
- `default["bah-marketplace"]["db_host"]` - Host of the database server (default: "127.0.0.1")
- `default["bah-marketplace"]["db_name"]` - Name of the database schema (default: "marketplace")
- `default["bah-marketplace"]["db_user"]` - Username for the database user (default: "root")
- `default["bah-marketplace"]["db_pass"]` - Password for the database user
- `default["bah-marketplace"]["db_prefix"]` - Username for the bah-marketplace database user (default: "", no prefix by default)

Usage
-----
Simply add `role[bah-marketplace]` to a run list.


Deploying a bah-marketplace Server
-----------
This section details "quick deployment" steps.

1. Clone this repository from GitHub:

        $ git clone git@github.com:jellyfish/bah-marketplace-cookbook.git

2. Change directory to the repo folder

        $ cd bah-marketplace-cookbook

3. Create a solo.rb file

    $ vim solo.rb

      file_cache_path "/root/dpi-chef"
      cookbook_path "/root/dpi-chef/cookbooks"


3. Install dependencies:

        Download the dependent cookbooks from Chef Supermarket

4. Install Chef Client

    $ curl -L https://www.opscode.com/chef/install.sh | sudo bash

5. Run Chef-solo:

    $ chef-solo -c solo.rb -j roles/bahmarketplace.json


License & Authors
-----------------
- Author:: Chris Kacerguis ( <Kacerguis_Christopher@bah.com> )
- Author:: Mandeep Bal ( <bal_mandeep@bah.com> )

```text
Copyright:: 2014, Booz Allen Hamilton

For more information on the license, please refer to the LICENSE.txt file in the repo
```
