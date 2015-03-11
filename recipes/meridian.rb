#
# Cookbook Name:: opennms
# Recipe:: meridian
#
# Copyright 2015, The OpenNMS Group, Inc.
#
# License GPLv3
#

case node['platform_family']
# Install yum repository on Red Hat family linux
when "rhel"
  template "/etc/yum.repos.d/meridian.repo" do
    source "meridian.yum.repo.erb"
    owner "root"
    group "root"
    mode "0644"
  end

  remote_file "/etc/yum.repos.d/OPENNMS-GPG-KEY" do
    source "http://yum.opennms.org/OPENNMS-GPG-KEY"
  end

  execute "Update yum repostory" do
    command "yum -y update"
  end
end

# Install basic dependencies
include_recipe "java"
include_recipe "postgresql::server"

# Install OpenNMS and Java-RRDtool library
["meridian",
 "jrrd",
 "rrdtool"].each do |package_name|
  package "#{package_name}" do
    action :install
  end
end

# Set Java environment for OpenNMS
execute "Setup opennms java" do
  command "#{node['opennms']['home']}/bin/runjava -s"
  action :run
end

# Install OpenNMS configuration templates
{ "opennms.conf" => "opennms.conf.erb",
  "opennms.properties" => "opennms.properties.erb",
  "rrd-configuration.properties" => "rrd-configuration.properties.erb",
  "opennms-datasources.xml" => "opennms-datasources.xml.erb",
  "provisiond-configuration.xml" => "provisiond-configuration.xml.erb"
}.each do |dest, source|
  template "#{node['opennms']['home']}/etc/#{dest}" do
    source "#{source}"
    owner "root"
    group "root"
    mode "0640"
  end
end

# Install OpenNMS database schema
execute "Initialize OpenNMS database and libraries" do
  command "#{node['opennms']['home']}/bin/install -dis"
  action :run
end

# Install opennms as service and set runlevel
service "meridian" do
  action [:enable, :start]
end
