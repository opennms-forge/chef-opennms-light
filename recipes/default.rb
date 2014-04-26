#
# Cookbook Name:: opennms
# Recipe:: default
#
# Copyright 2014, The OpenNMS Group, Inc.
#
# All rights reserved - Do Not Redistribute
#

case node[:platform]
when "redhat", "centos", "fedora"
  execute "Install OpenNMS yum repository" do
    command "rpm -Uvh http://yum.opennms.org/repofiles/opennms-repo-#{node[:opennms][:release]}-rhel6.noarch.rpm && yum update"
  end
end

package "opennms" do
  action :install
end

# Install preconfigured configuration files for database connection
# and OpenNMS
template "#{node[:opennms][:home]}/etc/opennms-datasources.xml" do
  source "opennms-datasources.xml.erb"
  owner "root"
  group "root"
  mode "0640"
  variables({
    :postgres_pass => node['postgresql']['password']['postgres']
  })
end

# Configure start timeout and Java heap size
template "#{node[:opennms][:home]}/etc/opennms.conf" do
  source "opennms.conf.erb"
  owner "root"
  group "root"
  mode "0640"
  variables({
    :java_heap_space => node['opennms']['java-heap-space'],
    :start_timeout => node['opennms']['start-timeout']
  })
end

# Set Java environment for OpenNMS
execute "Setup opennms java" do
  command "#{node[:opennms][:home]}/bin/runjava -s"
  action :run
end

# Install OpenNMS database schema
execute "Initialize OpenNMS database and libraries" do
  command "#{node[:opennms][:home]}/bin/install -dis"
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
