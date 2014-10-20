#
# Cookbook Name:: chef-marketplace
# Recipe:: default
#
# Copyright 2014, Booz Allen Hamilton
#
# All rights reserved - Do Not Redistribute
#

include_recipe "apache2"
include_recipe "mysql::client"
include_recipe "mysql::server"
include_recipe "php"
include_recipe "php::module_mysql"
include_recipe "chef-marketplace::module_xml"
include_recipe "chef-marketplace::module_ldap"
include_recipe "chef-marketplace::module_gd"
include_recipe "chef-marketplace::module_curl"
include_recipe "chef-marketplace::module_mbstring"
include_recipe "apache2::mod_php5"
include_recipe "fail2ban"
include_recipe "database"
include_recipe "database::mysql"
include_recipe "iptables"
include_recipe "selinux"
include_recipe "selinux::disabled"

mysql_root_pass = 'ilikerandompasswords'

mysql_service 'default' do
  allow_remote_root true
  remove_anonymous_users true
  remove_test_database true
  action :create
end

# Save the root password under /root/my.cnf so people can get it
template '/root/.my.cnf' do   
  source 'root-my.cnf.erb'
  variables({
    :mysql_user => node["chef-marketplace"]["db_user"],
    :mysql_pass => node["chef-marketplace"]["db_pass"],
  })
  action :create_if_missing
end

# Set the MySQL connection info
mysql_connection_info = {
  :host     => node["chef-marketplace"]["db_host"],
  :username => node["chef-marketplace"]["db_user"],
  :password => node["chef-marketplace"]["db_pass"]
}

marketplace_latest = "/tmp/marketplace-latest.tar.gz"
marketplace_webdir = node['apache']['docroot_dir']

# Setup the Virtual Host
web_app "marketplace" do
  template 'web_app.conf.erb'
  allow_override 'All'
  directory_index 'index.php'
  docroot marketplace_webdir
end

# Add a new /etc/my.cnf
template '/etc/my.cnf' do
  owner 'mysql'
  owner 'mysql'      
  source 'my.cnf.erb'
  notifies :restart, 'mysql_service[default]'
end

# Get the Marketplace code
remote_file 'get-marketplace' do
  path marketplace_latest
  source node["chef-marketplace"]["code_url"]
  mode "0644"
end

execute "untar-marketplace" do
  command "tar -zxf " + marketplace_latest + " -C " + marketplace_webdir + " --strip-components=1"
  notifies :create, "template[marketplace-settings]"
  notifies :query, 'mysql_database[marketplace]'
end

template 'marketplace-settings' do
  path marketplace_webdir + "/sites/default/settings.php"
  source "marketplace.settings.php.erb"
  variables({
    :database_host => node["chef-marketplace"]["db_host"],
    :database_name => node["chef-marketplace"]["db_name"],
    :database_user => node["chef-marketplace"]["db_user"],
    :database_pass => node["chef-marketplace"]["db_pass"],
    :database_pref => node["chef-marketplace"]["db_prefix"]
  })
  action :nothing
end

mysql_database 'marketplace' do
  connection mysql_connection_info
  action :create
end

# Query a database from a sql script on disk
mysql_database 'marketplace' do
  connection mysql_connection_info
  sql { ::File.open(marketplace_webdir + "/sql/marketplace.sql").read }
  action :nothing
end

# Setup Marketplace CRON
cron "marketplace_cron" do
  command "curl --silent http://127.0.0.1/cron.php?cron_key=" + node["chef-marketplace"]["cron_key"] + " > /dev/null"
end

execute "chown-data-www" do
  command "chown -R " + node['apache']['user'] + ":" + node['apache']['group'] + " " + marketplace_webdir
  user "root"
  action :run
end

# Setup IPTABLES to allow access via web
iptables_rule "http"
iptables_rule "https"
iptables_rule "ssh"


