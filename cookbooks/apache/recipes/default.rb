#
# Cookbook Name:: apache
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# Cookbook Name:: apache
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
# Install httpd package but don’t start it
package "apache2" do
        action [:install]
end
# Install mod_ssl package to enable ssl module in apache
#package "mod_ssl" do
#        action [:install]
#end
# Stop iptables service permanently
service "iptables" do
        action [:disable,:stop]
end
# Create /etc/httpd/ssl directory on chef client

directory "/var/www/html" do

action :create
recursive true
mode 0755
end

cookbook_file "/var/www/html/index.html" do
  source "index.html"
  mode "0644"
end

directory "#{node['apache']['dir']}/ssl" do
        action :create
        recursive true
        mode 0755
end
# Copy ssl certificates from certificates folder to client’s /etc/httpd/ssl folder
remote_directory "#{node['apache']['dir']}/ssl" do
        source "ssl"
        files_owner "root"
        files_group "root"
        files_mode 00644
        owner "root"
        group "root"
        mode 0755
end
# This will make changes to ssl.conf 
template "/etc/apache2/sites-available/default-ssl" do
        source "default-ssl.erb"
        mode 0644
        owner "root"
        group "root"
        variables(
                :sslcertificate => "#{node['apache']['sslpath']}/apache.crt",
                :sslkey => "#{node['apache']['sslpath']}/apache.key"
#                :sslcacertificate => "#{node['apache']['sslpath']}/chef_sanketdangi_com.ca-bundle",
#                :servername => "#{node['apache']['servername']}"
        )
#reloads the apache2 service if above variables changes in .erb file
notifies :reload, "service[apache2]"
end
# change selinux security context for ssl certificates
#execute "change_for_selinux" do
#        command "chcon -Rv --type=httpd_sys_content_t /etc/httpd/ssl/"
#        action :run
#end
# start httpd service
service "apache2" do
    action [:start, :enable]
supports :reload => true
end

