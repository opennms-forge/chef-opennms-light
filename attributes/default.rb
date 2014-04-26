# Set the OpenNMS release: stable, testing, unstable, snapshot
default['opennms']['release'] = 'stable'

# Allow Java remote debugging on port 8001: true / false 
default['opennms']['jpda'] = 'false'
default['opennms']['home'] = '/opt/opennms'

# OpenNMS Postgres settings
default['opennms']['dbhost'] = 'localhost'
default['opennms']['dbport'] = '5432'
default['opennms']['dbname'] = 'opennms'
default['opennms']['dbuser'] = 'opennms'
default['opennms']['dbpass'] = 'opennms'

# Configure RRD technology: jrobin / rrdtool
default['opennms']['storeByGroup'] = 'false'
default['opennms']['storeByForeignSource'] = 'false'

default['opennms']['rrd']['strategyClass'] = 'org.opennms.netmgt.rrd.jrobin.JRobinRrdStrategy'
default['opennms']['rrd']['interfaceJar'] = '/usr/share/java/jrrd.jar'
default['opennms']['library']['jrrd'] = '/usr/lib/libjrrd.so'

# Start service and Java environment
default['opennms']['java-heap-space'] = '1024'
default['opennms']['start-timeout'] = '0'

# Jetty options
default['opennms']['jetty']['port'] = '8980'
default['opennms']['web']['baseurl'] = 'http://%x%c/'
default['opennms']['jetty']['requestHeaderSize'] = '4000'
default['opennms']['jetty']['maxFormKeys'] = '2000'

# Web UI display settings
default['opennms']['propertiesCache']['enableCheckFileModified'] = 'false'
default['opennms']['webaclsEnabled'] = 'false'

default['opennms']['assets']['allowHtmlFields'] = 'comments, description'
default['opennms']['eventlist']['acknowledge'] = 'false'
default['opennms']['eventlist']['showCount'] = 'false'

default['opennms']['nodesWithOutages']['count'] = '12'
default['opennms']['nodesWithOutages']['show'] = 'true'

default['opennms']['nodesWithProblems']['count'] = '16'
default['opennms']['nodesWithProblems']['show'] = 'false'

default['opennms']['nodeStatusBar']['show'] = 'false'
default['opennms']['disableLoginSuccessEvent'] = 'false'

# Mapping and Geocoding
default['opennms']['maptype'] = 'OpenLayers'
default['opennms']['apikey'] = ''
default['opennms']['geocoderClass'] = 'org.opennms.features.poller.remote.gwt.server.geocoding.NullGeocoder'
default['opennms']['geocoderRate'] = '10'
default['opennms']['geocoderReferer'] = 'http://localhost'
default['opennms']['geocoderMinimumQuality'] = 'ZIP'
default['opennms']['geocoderNominatimEmail'] = ''
default['opennms']['openlayersUrl'] = 'http://otile1.mqcdn.com/tiles/1.0.0/osm/${z}/${x}/${y}.png'

# Reporting
default['opennms']['ksc']['graphsPerLine'] = '1'

# Eventd IPC
default['opennms']['rtc']['event']['proxyHost'] = '127.0.0.1'
default['opennms']['rtc']['event']['proxyPort'] = '5817'
default['opennms']['rtc']['event']['proxyTimeout'] = '2000'
default['opennms']['rtc']['client']['httpPostBaseUrl'] = 'http://localhost:8980/opennms/rtc/post'
default['opennms']['rtc']['client']['httpPostUsername'] = 'rtc'
default['opennms']['rtc']['client']['httpPostPassword'] = 'rtc'

# Map IPC
default['opennms']['map']['client']['httpPostBaseUrl'] = 'http://localhost:8980/opennms/map/post'
default['opennms']['map']['client']['httpPostUsername'] = 'map'
default['opennms']['map']['client']['httpPostPassword'] = 'map'

# SNMP implementation
default['opennms']['snmp']['strategyClass'] = 'org.opennms.netmgt.snmp.snmp4j.Snmp4JStrategy'
default['opennms']['snmp']['forwardRuntimeExceptions'] = 'false'

# SNMP Collector settings
default['opennms']['snmpCollector']['forceRescan'] = 'false'
default['opennms']['snmpCollector']['limitCollectionToInstances'] = 'false'

# Provisiond settings
default['opennms']['provisiond']['enableDiscovery'] = 'true'
default['opennms']['provisiond']['enableDeletionOfRequisitionedEntities'] = 'false'
default['opennms']['provisiond']['scheduleRescanForExistingNodes'] = 'true'
default['opennms']['provisiond']['scheduleRescanForUpdatedNodes'] = 'true'
default['opennms']['provisiond']['importThreads'] = '8'
default['opennms']['provisiond']['scanThreads'] = '10'
default['opennms']['provisiond']['rescanThreads'] = '10'
default['opennms']['provisiond']['writeThreads'] = '8'

# Remote poller settings
default['opennms']['minimumConfigurationReloadInterval'] = '300000'
default['opennms']['excludeServiceMonitorsFromRemotePoller'] = 'DHCP,NSClient,RadiusAuth,XMP'

# Data collection settings
default['opennms']['datacollection']['reloadCheckInterval'] = '30000'
default['opennms']['collectd']['threads'] = '50'

# Pollerd settings
default['opennms']['pollerd']['threads'] = '30'
default['opennms']['pollerd']['unresponsiveEnabled'] = 'false'
default['opennms']['pollerd']['nodeOutageStatus'] = 'on'
default['opennms']['pollerd']['criticalService'] = 'ICMP'

