#
# Cookbook Name:: learn_chef_apache2
# Recipe:: default
#
# Copyright (C) 2014
#
#
#
#by default it will install apache2 package
package 'apache2'

#It will start the apache2 service and enable it while booting the machine
service 'apache2' do
  action [:start, :enable]
end

#template directive 
template '/var/www/index.html' do
  source 'index.html.erb'
end

msg=node['learn_chef_apache2']['msg']
msg1=node['learn_chef_apache2']['msg1']

file '/var/www/html/text.txt'
content " hey wats up mate"
end
