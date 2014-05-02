#
# Cookbook Name:: remote-poller
# Recipe:: default
#
# Copyright 2014, The OpenNMS Group, Inc.
#
# All rights reserved - Do Not Redistribute
#

case node[:platform]
when 'redhat', 'centos', 'fedora'
  execute 'Install OpenNMS yum repository' do
    command "rpm -Uvh http://yum.opennms.org/repofiles/opennms-repo-#{node[:opennms][:release]}-rhel6.noarch.rpm"
    not_if { ::File.exist?('/etc/yum.repos.d/opennms-#{node[:opennms][:release]}-rhel6.repo') }
  end

  execute 'Update yum repostory' do
    command 'yum -y update'
  end
when 'debian', 'ubuntu'
  package "python-software-properties" do
    action :install
  end

  execute "Install OpenNMS apt repository" do
    command "add-apt-repository 'deb http://debian.opennms.org #{node[:opennms][:release]} main'"
    action :run
  end
  
  
  execute "Install OpenNMS apt GPG-key" do
    command "wget -O - http://debian.opennms.org/OPENNMS-GPG-KEY | sudo apt-key add -"
    action :run
  end
end

package 'opennms-remote-poller' do
  action :install
end

# Install opennms-remote-poller as service and set runlevel
service 'opennms-remote-poller' do
  action [:enable, :start]
end
