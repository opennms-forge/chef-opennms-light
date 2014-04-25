#
# Cookbook Name:: opennms
# Recipe:: default
#
# Copyright 2014, The OpenNMS Group, Inc.
#
# All rights reserved - Do Not Redistribute
#

group node['opennms']['group']

user node['opennms']['user'] do
    group node['opennms']['group']
    system true
    shell '/bin/bash'
end