[client]
host= localhost
user = debian-sys-maint
password = <%= node['mysql']['server_debian_password'] %>   #--> which is above parameter in attributes file
socket = <%= node['mysql']['socket'] %>

[mysql_upgrade]
host = localhost
user = debian-sys-maint
password = <%= node['mysql']['server_debian_password'] %>   #--> which is above parameter in attributes file
socket = <%= node['mysql']['socket'] %>
basedir = usr
