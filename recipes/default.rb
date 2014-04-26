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
    command "rpm -Uvh http://yum.opennms.org/repofiles/opennms-repo-#{node[:opennms][:release]}-rhel6.noarch.rpm"
    not_if { ::File.exist?("/etc/yum.repos.d/opennms-#{node[:opennms][:release]}-rhel6.repo")}
  end

  execute "Update yum repostory" do
    command "yum -y update"
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
    :opennms_dbhost => node['opennms']['dbhost'],
    :opennms_dbport => node['opennms']['dbport'],
    :opennms_dbname => node['opennms']['dbname'],
    :opennms_dbuser => node['opennms']['dbuser'],
    :opennms_dbpass => node['opennms']['dbpass'],
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

template "#{node[:opennms][:home]}/etc/opennms.properties" do
  source "opennms.properties.erb"
  owner "root"
  group "root"
  mode "0640"
  variables({
    :snmp_strategyClass => node['opennms']['snmp']['strategyClass'],
    :snmp4j_forwardRuntimeExceptions => node['opennms']['snmp4j']['forwardRuntimeExceptions'],
    :storeByGroup => node['opennms']['storeByGroup'],
    :storeByForeignSource => node['opennms']['storeByForeignSource'],
    :opennms_home => node['opennms']['home'],
    :datacollection_reloadCheckInterval => node['opennms']['datacollection']['reloadCheckInterval'],
    :enableCheckFileModified => node['opennms']['propertiesCache']['enableCheckFileModified'],
    :ksc_graphsPerLine => node['opennms']['ksc']['graphsPerLine'],
    :rtc_event_proxy_host => node['opennms']['rtc']['event']['proxyHost'],
    :rtc_event_proxy_port => node['opennms']['rtc']['event']['proxyPort'],
    :rtc_event_proxy_timeout => node['opennms']['rtc']['event']['proxyTimeout'],
    :rtc_client_httpPost_baseUrl => node['opennms']['rtc']['client']['httpPostBaseUrl'],
    :rtc_client_httpPost_username => node['opennms']['rtc']['client']['httpPostUsername'],
    :rtc_client_httpPost_password => node['opennms']['rtc']['client']['httpPostPassword'],
    :map_client_httpPost_baseUrl => node['opennms']['map']['client']['httpPostBaseUrl'],
    :map_client_httpPost_username => node['opennms']['map']['client']['httpPostUsername'],
    :map_client_httpPost_password => node['opennms']['map']['client']['httpPostPassword'],
    :jetty_port => node['opennms']['jetty']['port'],
    :requestHeaderSize => node['opennms']['jetty']['requestHeaderSize'],
    :maxFormKeys => node['opennms']['jetty']['maxFormKeys'],
    :web_baseurl => node['opennms']['web']['baseurl'] ,
    :assets_allowHtmlFields => node['opennms']['assets']['allowHtmlFields'],
    :forceResan => node['opennms']['snmpCollector']['forceRescan'],
    :limitCollectionToInstances => node['opennms']['snmpCollector']['limitCollectionToInstances'],
    :web_aclsEnabled => node['opennms']['webaclsEnabled'],
    :provisiond_enableDiscovery => node['opennms']['provisiond']['enableDiscovery'],
    :provisiond_enableDeletionOfRequisitionedEntities => node['opennms']['provisiond']['enableDeletionOfRequisitionedEntities'],
    :provisiond_scheduleRescanForExistingNodes => node['opennms']['provisiond']['scheduleRescanForExistingNodes'],
    :provisiond_scheduleRescanForUpdatedNodes => node['opennms']['provisiond']['scheduleRescanForUpdatedNodes'],
    :gwt_maptype => node['opennms']['maptype'],
    :gwt_apikey => node['opennms']['apikey'],
    :geocoder_class => node['opennms']['geocoder']['class'],
    :geocoder_rate => node['opennms']['geocoder']['rate'],
    :geocoder_referer => node['opennms']['geocoder']['referer'],
    :geocoder_minimumQuality => node['opennms']['geocoder']['minimumQuality'],
    :geocoder_nominatimEmail => node['opennms']['geocoder']['nominatimEmail'],
    :openlayers_url => node['opennms']['openlayersUrl'],
    :eventlist_acknowledge => node['opennms']['eventlist']['acknowledge'],
    :eventlist_showCount => node['opennms']['eventlist']['showCount'],
    :nodesWithOutages_count => node['opennms']['nodesWithOutages']['count'],
    :nodesWithOutages_show => node['opennms']['nodesWithOutages']['show'],
    :nodesWithProblems_count => node['opennms']['nodesWithProblems']['count'],
    :nodesWithProblems_show => node['opennms']['nodesWithProblems']['show'],
    :nodesStatusBar_show => node['opennms']['nodeStatusBar']['show'],
    :disableLoginSuccessEvent => node['opennms']['disableLoginSuccessEvent'],
    :minimumConfigurationReloadInterval => node['opennms']['minimumConfigurationReloadInterval'],
    :excludeServiceMonitorsFromRemotePoller => node['opennms']['excludeServiceMonitorsFromRemotePoller']
  })
end

# Configure Pollerd
template "#{node[:opennms][:home]}/etc/poller-configuration.xml" do
  source "poller-configuration.xml.erb"
  owner "root"
  group "root"
  mode "0640"
  variables({
    :poller_threads => node['opennms']['poller']['threads'],
    :poller_unresponsiveEnabled => node['opennms']['poller']['unresponsiveEnabled'],
    :poller_nodeOutageStatus => node['opennms']['poller']['nodeOutageStatus'],
    :poller_criticalService => node['opennms']['poller']['criticalService']
  })
end

# Configure Collectd
template "#{node[:opennms][:home]}/etc/collectd-configuration.xml" do
  source "collectd-configuration.xml.erb"
  owner "root"
  group "root"
  mode "0640"
  variables({
    :collectd_threads => node['opennms']['collectd']['threads']
  })
end

# Configure Provisiond
template "#{node[:opennms][:home]}/etc/provisiond-configuration.xml" do
  source "provisiond-configuration.xml.erb"
  owner "root"
  group "root"
  mode "0640"
  variables({
    :opennms_home => node['opennms']['home'],
    :provisiond_importThreads => node['opennms']['provisiond']['importThreads'],
    :provisiond_scanThreads => node['opennms']['provisiond']['scanThreads'],
    :provisiond_rescanThreads => node['opennms']['provisiond']['rescanThreads'],
    :provisiond_writeThreads => node['opennms']['provisiond']['writeThreads']
  })
end

# Configure Timeseries data hanlding
template "#{node[:opennms][:home]}/etc/rrd-configuration.properties" do
  source "rrd-configuration.properties.erb"
  owner "root"
  group "root"
  mode "0640"
  variables({
    :opennms_home => node['opennms']['home'],
    :rrd_strategyClass => node['opennms']['rrd']['strategyClass'],
    :usequeue => node['opennms']['rrd']['usequeue'],
    :writethreads => node['opennms']['rrd']['queuing']['writethreads'],
    :queuecreates => node['opennms']['rrd']['queuing']['queuecreates'],
    :prioritizeSignificantUpdates => node['opennms']['rrd']['queuing']['prioritizeSignificantUpdates'],
    :maxInsigUpdateSeconds => node['opennms']['rrd']['queuing']['maxInsigUpdateSeconds'],
    :modulus => node['opennms']['rrd']['queuing']['modulus'],
    :inSigHighWaterMark => node['opennms']['rrd']['queuing']['inSigHighWaterMark'],
    :sigHighWaterMark => node['opennms']['rrd']['queuing']['sigHighWaterMark'],
    :queueHighWaterMark => node['opennms']['rrd']['queuing']['queueHighWaterMark'],
    :writethread_sleeptime => node['opennms']['rrd']['queuing']['writethread']['sleepTime'],
    :writethread_exitDelay => node['opennms']['rrd']['queuing']['writethread']['exitDelay'],
    :rrdBackendFactory => node['opennms']['jrobin']['rrdBackendFactory'],
    :usetcp => node['opennms']['rrd']['usetcp'],
    :tcp_host => node['opennms']['rrd']['tcp']['host'],
    :tcp_port => node['opennms']['rrd']['tcp']['port']
  })
end

# Install opennms as service and set runlevel
service "opennms" do
  supports :status => true, :restart => true, :reload => true
  if node[:opennms][:jpda]
    start_command "service opennms -t start"
  end
  action [ :enable, :start ]
end
