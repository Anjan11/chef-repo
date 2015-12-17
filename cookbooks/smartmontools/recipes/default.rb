#
# Cookbook Name:: smartmontools
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package "smartmontools" do
  action :install
end


package "smartmontools" do
  action :upgrade
end

service "smartmontools" do
  supports :status => true, :reload => true, :restart => true
  action [:enable,:start]
end

template "/etc/default/smartmontools" do
  source "smartmontools.default.erb"
  owner "root"
  group "root"
  mode 0644
  notifies :reload, "service[smartmontools]"
end

template "/etc/smartd.conf" do
  source "smartd.conf.erb"
  owner "root"
  group "root"
  mode 0644
  notifies :reload, "service[smartmontools]"
end


