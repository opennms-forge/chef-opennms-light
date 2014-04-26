#
# Cookbook Name:: opennms
# Recipe:: default
#
# Copyright 2014, The OpenNMS Group, Inc.
#
# All rights reserved - Do Not Redistribute
#

if platform?("redhat", "centos", "fedora")
    bash "Install opennms-repo" do
        user "root"
        cwd "/tmp"
        code <<-EOH
          rpm -Uvh http://yum.opennms.org/repofiles/opennms-repo-#{node[:opennms][:release]}-rhel6.noarch.rpm
          yum update
        EOH
    end
end

package "opennms" do
  action :install
end

# Set Java environment for OpenNMS
execute "Setup opennms java" do
  command "/opt/opennms/bin/runjava -s"
  action :run
end

# Install OpenNMS database schema
execute "Initialize OpenNMS database and libraries" do
  command "/opt/opennms/bin/install -dis"
  action :run
end

# Install opennms as service and set runlevel
service "opennms" do
  supports :status => true, :restart => true, :reload => true
  if node[:opennms][:jpda]
    start_command "service opennms -t start"
  end
  action [ :enable, :start ]
end
