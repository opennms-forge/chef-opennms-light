# Set the OpenNMS release: stable, testing, unstable, snapshot
default['opennms']['release'] = 'stable'

default['opennms']['user'] = 'opennms'
default['opennms']['group'] = 'opennms'

# Allow Java remote debugging on port 8001: true / false 
default['opennms']['jpda'] = 'false'

# Configure RRD technology: jrobin / rrdtool
default['opennms']['rrd-tech'] = 'jrobin'
default['opennms']['storeByGroup'] = 'false'
default['opennms']['storeByForeignId'] = 'false'

# Start service and Java environment
default['opennms']['start-timeout'] = '0'
default['opennms']['java-heap-space'] = '1024'

# Web UI display options
default['opennms']['eventlist']['acknowledge'] = 'false'
default['opennms']['eventlist']['showCount'] = 'false'

default['opennms']['nodesWithOutages']['count'] = '12'
default['opennms']['nodesWithOutages']['show'] = 'true'

default['opennms']['nodesWithProblems']['count'] = '16'
default['opennms']['nodesWithProblems']['show'] = 'false'

default['opennms']['nodeStatusBar']['show'] = 'false'

