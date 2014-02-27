#
# Cookbook Name:: windows_server_rdsh
# Recipe:: w2k8r2
#
# Copyright (C) 2014 Todd Pigram
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#    http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
include_recipe "windows::reboot_handler"

# install RDS
powershell node[:w2k8][:rds] do
  code <<-EOH
  Import-Module ServerManager
  Add-WindowsFeature RDS-RD-Server
  EOH
  not_if {reboot_pending?}
end


# Install desktop experience
powershell node[:w2k8][:deskexp] do
  code <<-EOH
  Import-Module ServerManager
  Add-WindowsFeature Desktop-Experience
  EOH
  not_if {reboot_pending?}
end

powershell node[:w2k8][:xps] do
  code <<-EOH
  Import-Module ServerManager
  Add-WindowsFeature XPS-Viewer
  EOH
  not_if {reboot_pending?}
end

windows_reboot 60 do 
  reason 'Chef Pigram said to'
  only_if {reboot_pending?}
end
