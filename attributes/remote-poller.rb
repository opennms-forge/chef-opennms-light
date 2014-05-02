# Set the OpenNMS release: stable, testing, unstable, snapshot
default['opennms']['release'] = 'stable'

# Allow Java remote debugging on port 8001: true / false
default['opennms']['home'] = '/usr/share/opennms'
default['opennms']['log'] = '/var/log/opennms/opennms-remote-poller.log'
default['opennms']['baseurl'] = 'https://opennms.opennms-edu.net/opennms-remoting'
default['opennms']['location'] = 'Host-Europe'
default['opennms']['gui'] = 'false'
default['opennms']['runas'] = 'root'
default['opennms']['start_poller'] = '1'

# Start service and Java environment
default['opennms']['java-heap-space'] = '384'
default['opennms']['start-timeout'] = '0'

