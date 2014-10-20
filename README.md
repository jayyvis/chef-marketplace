chef-marketplace Cookbook
=================

Pulls down the latest chef-marketplace code, builds the code, installs the dependencies, and then starts the evm processes.

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
Simply add `role[chef-marketplace]` to a run list.


Deploying a chef-marketplace Server
-----------
This section details "quick deployment" steps.

1. Clone this repository from GitHub:

        $ git clone git@github.com:booz-allen-hamilton/chef-marketplace.git

2. Change directory to the repo folder

        $ cd chef-marketplace-cookbook

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
- Author:: Chris Kacerguis ( <jellyfishopensource@bah.com> )
- Author:: Mandeep Bal ( <jellyfishopensource@bah.com> )

```text
Copyright:: 2014, Booz Allen Hamilton

For more information on the license, please refer to the LICENSE.txt file in the repo
```
