# Set the OpenNMS release: stable, testing, unstable, snapshot
default['opennms']['release'] = 'stable'

# Allow Java remote debugging on port 8001: true / false
default['opennms']['home'] = '/opt/opennms'
default['opennms']['log'] = '/var/log/opennms/opennms-remote-poller.log'
default['opennms']['baseurl'] = 'http://192.168.0.1:8900/opennms-remoting'
default['opennms']['location'] = 'Default'
default['opennms']['gui'] = 'false'
default['opennms']['runas'] = 'root'
default['opennms']['start_poller'] = '1'

# Start service and Java environment
default['opennms']['java-heap-space'] = '384'
default['opennms']['start-timeout'] = '0'

