#
# Cookbook Name:: opennms
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
end

package 'opennms' do
  action :install
end

# Install preconfigured configuration files for database connection
# and OpenNMS
template "#{node[:opennms][:home]}/etc/opennms-datasources.xml" do
  source 'opennms-datasources.xml.erb'
  owner 'root'
  group 'root'
  mode '0640'
end

# Configure start timeout and Java heap size
template "#{node[:opennms][:home]}/etc/opennms.conf" do
  source 'opennms.conf.erb'
  owner 'root'
  group 'root'
  mode '0640'
end

# Set Java environment for OpenNMS
execute 'Setup opennms java' do
  command "#{node[:opennms][:home]}/bin/runjava -s"
  action :run
end

# Install OpenNMS database schema
execute 'Initialize OpenNMS database and libraries' do
  command "#{node[:opennms][:home]}/bin/install -dis"
  action :run
end

template "#{node[:opennms][:home]}/etc/opennms.properties" do
  source 'opennms.properties.erb'
  owner 'root'
  group 'root'
  mode '0640'
end

# Configure Pollerd
template "#{node[:opennms][:home]}/etc/poller-configuration.xml" do
  source 'poller-configuration.xml.erb'
  owner 'root'
  group 'root'
  mode '0640'
end

# Configure Collectd
template "#{node[:opennms][:home]}/etc/collectd-configuration.xml" do
  source 'collectd-configuration.xml.erb'
  owner 'root'
  group 'root'
  mode '0640'
end

# Configure Provisiond
template "#{node[:opennms][:home]}/etc/provisiond-configuration.xml" do
  source 'provisiond-configuration.xml.erb'
  owner 'root'
  group 'root'
  mode '0640'
end

# Configure Timeseries data hanlding
template "#{node[:opennms][:home]}/etc/rrd-configuration.properties" do
  source 'rrd-configuration.properties.erb'
  owner 'root'
  group 'root'
  mode '0640'
end

# Install opennms as service and set runlevel
service 'opennms' do
  if node[:opennms][:jpda]
    start_command 'service opennms -t start'
  end
  action [:enable, :start]
end
