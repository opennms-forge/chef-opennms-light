#
# Cookbook Name:: opennms
# Recipe:: default
#
# Copyright 2014, The OpenNMS Group, Inc.
#
# License GPLv3
#

include_recipe "postgresql::server"

case node['platform_family']
# Install yum repository on Red Hat family linux
when "rhel"
  home_dir = "/opt/opennms"
  template "/etc/yum.repos.d/opennms-rhel6.repo" do
    source "opennms.yum.repo.erb"
    owner "root"
    group "root"
    mode "0644"
  end

  remote_file "/etc/yum.repos.d/OPENNMS-GPG-KEY" do
    source "http://#{node['opennms']['repository']['yum']}/OPENNMS-GPG-KEY"
  end

  execute "Update yum repostory" do
    command "yum -y update"
  end
# Install aptitude repository on Debian family
when "debian"
  home_dir = "/usr/share/opennms"
  template "/etc/apt/sources.list.d/opennms.list" do
    source "opennms.list.erb"
    owner "root"
    group "root"
    mode "0644"
  end

  remote_file "#{Chef::Config['file_cache_path']}/OPENNMS-GPG-KEY" do
    source "http://#{node['opennms']['repository']['apt']}/OPENNMS-GPG-KEY"
  end

  execute "Install OpenNMS apt GPG-key" do
    command "sudo apt-key add #{Chef::Config['file_cache_path']}/OPENNMS-GPG-KEY"
    action :run
  end

  execute "Update apt repository" do
    command "aptitude update"
    action :run
  end
end

# Install OpenNMS and Java RRDtool library
["opennms", "jrrd"].each do |package_name|
  package "#{package_name}" do
    action :install
  end
end

# Set Java environment for OpenNMS
execute "Setup opennms java" do
  command "#{home_dir}/bin/runjava -s"
  action :run
end

# Install OpenNMS configuration templates
{ "opennms.conf" => "opennms.conf.erb",
  "opennms.properties" => "opennms.properties.erb",
  "rrd-configuration.properties" => "rrd-configuration.properties.erb",
  "opennms-datasources.xml" => "opennms-datasources.xml.erb",
  "provisiond-configuration.xml" => "provisiond-configuration.xml.erb"
}.each do |dest, source|
  template "#{home_dir}/etc/#{dest}" do
    source "#{source}"
    owner "root"
    group "root"
    mode "0640"
  end
end

# Install OpenNMS database schema
execute "Initialize OpenNMS database and libraries" do
  command "#{home_dir}/bin/install -dis"
  action :run
end

# Install opennms as service and set runlevel
service "opennms" do
  action [:enable, :start]
end
