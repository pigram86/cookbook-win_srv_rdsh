Description
===========
This cookbook is used for install default Roles and Features for the installation RDSH/DesktopExperience/XPS Viwer on Windows Server 2008 R2, Windows Server 2012 and Windows Server 2012 R2.


Supported Platforms
===================

* Windows Server 2008 R2
* Windows Server 2012
* Windows Server 2012 R2


Cookbooks
=========

* windows
* powershell


Recipes
=======

win_srv_rdsh::default.rb
-------------------------------
*case node['platform_version']
*when "6.3.9600"
*  include_recipe "win_srv_rdsh::w2012r2"
*when "6.2.9200"
*  include_recipe "win_srv_rdsh::w2012"
*when "6.1.7601"
*  include_recipe "win_srv_rdsh::w2k8r2"
*end

win_srv_rdsh::w2012.rb
-----------------------------
*%w{ Xps-Foundation-Xps-Viewer Remote-Desktop-Services ServerMediaFoundation AppServer DesktopExperience }.each do |feature|
*  windows_feature feature do
*    action :install
*    not_if {reboot_pending?}
*  end
*end

*windows_reboot 30 do
*  reason 'Chef said to'
*  only_if {reboot_pending?}
*end

win_srv_rdsh::w2012r2.rb
-------------------------------
*%w{ File-Services CoreFileServer  WindowsServerBackup NetFx3ServerFeatures NetFx3 ServerManager-Core-RSAT ServerManager-Core-RSAT-Role-Tools RSAT-AD-Tools-Feature RSAT-ADDS-Tools-Feature }.each do |feature|
*  windows_feature feature do
*    action :install
*    not_if {reboot_pending?}
*  end
*end


*windows_reboot 30 do
*  reason 'Chef said to'
*  only_if {reboot_pending?}
*end

win_srv_rdsh::w2k8r2.rb
------------------------------
*# install RDS
*powershell node['w2k8']['rds'] do
*  code <<-EOH
*  Import-Module ServerManager
*  Add-WindowsFeature RDS-RD-Server
*  EOH
*  not_if {reboot_pending?}
*end


*# Install desktop experience
*powershell node['w2k8']['deskexp'] do
*  code <<-EOH
*  Import-Module ServerManager
*  Add-WindowsFeature Desktop-Experience
*  EOH
*  not_if {reboot_pending?}
*end

*powershell node['w2k8']['xps'] do
*  code <<-EOH
*  Import-Module ServerManager
*  Add-WindowsFeature XPS-Viewer
*  EOH
*  not_if {reboot_pending?}
*end

*windows_reboot 30 do 
*  reason 'Chef said to'
*  only_if {reboot_pending?}
*end

Usage
=====

win_srv_rdsh::default.rb
--------------------------------
* Include `win_srv_rdsh` in your node's `run_list`:

```json
 {
  "run_list": [
    "recipe[win_srv_rdsh::default]"
   ]
 }
 ```


Attributes
==========

win_srv_rdsh::default.rb
-------------------------------
default['w2k8']['rds'] = "RDS"
default['w2k8']['deskexp'] = "desktop_experience"
default['w2k8']['xps'] = "XPS"



Contributing
=============

1. Fork the repository on Github
2. Create a named feature branch (i.e. `add-new-recipe`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request

License and Authors
===================

Author:: Todd Pigram (<todd@toddpigram.com>)

Copyright:: 2013-2014, Todd Pigram

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
