# Set the OpenNMS release: stable, testing, unstable, snapshot
default['opennms']['release'] = 'stable'

# Allow Java remote debugging on port 8001: true / false
default['opennms']['home'] = '/opt/opennms'

# Start service and Java environment
default['opennms']['java-heap-space'] = '512'
default['opennms']['start-timeout'] = '0'

