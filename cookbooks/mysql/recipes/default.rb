#
# Cookbook Name:: mysql
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

execute 'update apt' do
command "apt-get update"
action :run
end

group 'mysql' do 
action :create
end

user 'mysql' do 
comment 'Mysql server'
gid 'mysql'
system true
home  node['mysql']['data_dir'] # --> which is above parameter in attributes file
shell '/sbin/nologin'
end

node['mysql']['server']['packages'].each do |name|  #--> which is above parameter in attributes file and installs, start, notifies
package name do
action :install
notifies :start, 'service[mysql]', :immediately
end
end

package 'mysql-server' do
action :install
notifies :start, 'service[mysql]', :immediately
end

package 'apache2' do
action :install
notifies :start, 'service[apache2]', :delayed 
end

package 'php5' do
action :install
notifies :reload, 'service[apache2]', :delayed
end
