# See http://docs.chef.io/config_rb_knife.html for more information on knife configuration options

current_dir = File.dirname(__FILE__)
log_level                :info
log_location             STDOUT
node_name                "anjan"
client_key               "#{current_dir}/anjan.pem"
validation_client_name   "anjan_chef-validator"
validation_key           "#{current_dir}/anjan_chef-validator.pem"
chef_server_url          "https://api.chef.io/organizations/anjan_chef"
cookbook_path            ["#{current_dir}/../cookbooks"]
knife[:editor] = "vi"
