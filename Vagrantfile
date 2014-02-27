# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.require_plugin "vagrant-berkshelf"
Vagrant.require_plugin "vagrant-omnibus"
Vagrant.require_plugin "vagrant-windows"

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.omnibus.chef_version = :latest
  config.vm.box = "chef-w2012r2"
  config.vm.box_url = "/Users/toddpigram/veewee/chef-w2012r2.box"
  config.vm.boot_timeout = 500
  config.vm.network :forwarded_port, guest: 80, host: 8080
  config.vm.network :forwarded_port, guest: 3389, host: 3390 
  config.vm.network :forwarded_port, guest: 5985, host: 5985
  config.vm.network :private_network, ip: "192.168.33.10"
  # config.vm.network :public_network
  # config.ssh.forward_agent = true
  #config.vm.synced_folder "../data", "/vagrant_data"
  config.vm.provider :virtualbox do |vb|
    vb.gui = true
    vb.customize ["modifyvm", :id, "--memory", "2048"]
  end
  #config.berkshelf.berksfile_path = "./Berksfile"
  #config.berkshelf.enabled = true
  # config.berkshelf.only = []
  # config.berkshelf.except = []
  # config.vm.provision :chef_solo do |chef|
  #   chef.cookbooks_path = "../my-recipes/cookbooks"
  #   chef.roles_path = "../my-recipes/roles"
  #   chef.data_bags_path = "../my-recipes/data_bags"
  #   chef.add_recipe "mysql"
  #   chef.add_role "web"
  #
  #   # You may also specify custom JSON attributes:
  #   chef.json = { :mysql_password => "foo" }
  # end
  config.vm.provision :chef_client do |chef|
   chef.chef_server_url = "https://api.opscode.com/organizations/pigram"
   chef.validation_key_path = ".chef/pigram-validator.pem"
  end
  #  chef.validation_client_name = "pigram-validator"
end
