override['postgresql']['password']['postgres'] = 'opennms_pg'
override['postgresql']['pg_hba'] = [
  {:type => 'host', :db => 'all', :user => 'all', :addr => '127.0.0.1/32', :method => 'md5'},
  {:type => 'host', :db => 'all', :user => 'all', :addr => '::1/128', :method => 'md5'}
]

# Set the OpenNMS release: stable, testing, unstable, snapshot
default['opennms']['release'] = 'stable'
default['opennms']['repository']['yum'] = 'yum.opennms.org'
default['opennms']['repository']['apt'] = 'debian.opennms.org'

# Postgres admin settings
default['opennms']['postgres']['admin'] = 'postgres'

# OpenNMS Postgres settings
default['opennms']['dbhost'] = 'localhost'
default['opennms']['dbport'] = '5432'
default['opennms']['dbname'] = 'opennms'
default['opennms']['dbuser'] = 'opennms'
default['opennms']['dbpass'] = 'opennms'

# Configure RRD technology: jrobin / rrdtool
default['opennms']['library']['jrrd'] = '/usr/lib64/libjrrd.so'
default['opennms']['rrd']['strategyClass'] = 'org.opennms.netmgt.rrd.jrobin.JRobinRrdStrategy'
default['opennms']['rrd']['interfaceJar'] = '/usr/share/java/jrrd.jar'

# RRD detail tuning settings
default['opennms']['rrd']['usequeue'] = 'true'
default['opennms']['rrd']['queuing']['writethreads'] = '2'
default['opennms']['rrd']['queuing']['queuecreates'] = 'false'
default['opennms']['rrd']['queuing']['prioritizeSignificantUpdates'] = 'false'
default['opennms']['rrd']['queuing']['maxInsigUpdateSeconds'] = '0'
default['opennms']['rrd']['queuing']['modulus'] = '10000'
default['opennms']['rrd']['queuing']['inSigHighWaterMark'] = '0'
default['opennms']['rrd']['queuing']['sigHighWaterMark'] = '0'
default['opennms']['rrd']['queuing']['queueHighWaterMark'] = '0'
default['opennms']['rrd']['queuing']['writethread']['sleepTime'] = '50'
default['opennms']['rrd']['queuing']['writethread']['exitDelay'] = '60000'
default['opennms']['jrobin']['rrdBackendFactory'] = 'FILE'
default['opennms']['rrd']['usetcp'] = 'false'
default['opennms']['rrd']['tcp']['host'] = ''
default['opennms']['rrd']['tcp']['port'] = ''

## java.conf

# Start service and Java environment
default['opennms']['java_heap_space'] = '1024'
default['opennms']['start_timeout'] = '0'

## opennms.properties

# General
default['opennms']['disableLoginSuccessEvent'] = 'false'
default['opennms']['propertiesCache']['enableCheckFileModified'] = 'false'

# ICMP
# -- unset --

# SNMP
default['opennms']['snmp']['strategyClass'] = 'org.opennms.netmgt.snmp.snmp4j.Snmp4JStrategy'
default['opennms']['snmp4j']['forwardRuntimeExceptions'] = 'false'

# Data Collection
default['opennms']['storeByGroup'] = 'false'
default['opennms']['storeByForeignSource'] = 'false'
default['opennms']['snmpCollector']['forceRescan'] = 'false'
default['opennms']['snmpCollector']['limitCollectionToInstances'] = 'false'

# Trouble Ticketing
# -- unset --

# RTC IPC
default['opennms']['rtc']['client']['httpPostBaseUrl'] = 'http://localhost:8980/opennms/rtc/post'
default['opennms']['rtc']['client']['httpPostUsername'] = 'rtc'
default['opennms']['rtc']['client']['httpPostPassword'] = 'rtc'
default['opennms']['rtc']['event']['proxyHost'] = '127.0.0.1'
default['opennms']['rtc']['event']['proxyPort'] = '5817'
default['opennms']['rtc']['event']['proxyTimeout'] = '2000'

# Map IPC
default['opennms']['map']['client']['httpPostBaseUrl'] = 'http://localhost:8980/opennms/map/post'
default['opennms']['map']['client']['httpPostUsername'] = 'map'
default['opennms']['map']['client']['httpPostPassword'] = 'map'

# Jetty
default['opennms']['jetty']['port'] = '8980'
default['opennms']['jetty']['requestHeaderSize'] = '4000'
default['opennms']['jetty']['maxFormKeys'] = '2000'
default['opennms']['web']['baseurl'] = 'http://%x%c/'

# Jetty HTTPS
# -- unset --

# Provisiond
default['opennms']['provisiond']['enableDiscovery'] = 'true'
default['opennms']['provisiond']['enableDeletionOfRequisitionedEntities'] = 'false'
default['opennms']['provisiond']['scheduleRescanForExistingNodes'] = 'true'
default['opennms']['provisiond']['scheduleRescanForUpdatedNodes'] = 'true'

# Web UI
default['opennms']['assets']['allowHtmlFields'] = 'comments, description'
default['opennms']['webaclsEnabled'] = 'false'
default['opennms']['eventlist']['acknowledge'] = 'false'
default['opennms']['eventlist']['showCount'] = 'false'
default['opennms']['nodesWithOutages']['count'] = '12'
default['opennms']['nodesWithOutages']['show'] = 'true'
default['opennms']['nodesWithProblems']['count'] = '16'
default['opennms']['nodesWithProblems']['show'] = 'true'
default['opennms']['nodeStatusBar']['show'] = 'true'

# Dashboard and Surveillance View
# -- unset --

# Graphing
# -- unset --

# Mapping and Geocoding
default['opennms']['maptype'] = 'OpenLayers'
default['opennms']['apikey'] = ''
default['opennms']['geocoder']['class'] = 'org.opennms.features.poller.remote.gwt.server.geocoding.NullGeocoder'
default['opennms']['geocoder']['rate'] = '10'
default['opennms']['geocoder']['referer'] = 'http://localhost'
default['opennms']['geocoder']['minimumQuality'] = 'ZIP'
default['opennms']['geocoder']['nominatimEmail'] = ''
default['opennms']['openlayersUrl'] = 'http://otile1.mqcdn.com/tiles/1.0.0/osm/${z}/${x}/${y}.png'

# Remote Poller
# -- unset --

# Reporting
default['opennms']['ksc']['graphsPerLine'] = '1'

# Rancid Integration
# -- unset --

# Asterisk AGI Support
# -- unset --

# SMS Gateway Setup
# -- unset --

## provisiond-configuration.xml

# Provisiond settings
default['opennms']['provisiond']['importThreads'] = '8'
default['opennms']['provisiond']['scanThreads'] = '10'
default['opennms']['provisiond']['rescanThreads'] = '10'
default['opennms']['provisiond']['writeThreads'] = '8'

# Remote poller settings
default['opennms']['minimumConfigurationReloadInterval'] = '300000'
default['opennms']['excludeServiceMonitorsFromRemotePoller'] = 'DHCP,NSClient,RadiusAuth,XMP'

# Data collection settings
default['opennms']['datacollection']['reloadCheckInterval'] = '30000'
