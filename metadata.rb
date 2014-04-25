name             'opennms'
maintainer       'The OpenNMS Group, Inc.'
maintainer_email 'ronny@opennms.org'
license          'All rights reserved'
description      'Installs/Configures opennms'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

recipe 'opennms', 'Installs open source enterprise network management platform OpenNMS'

depends 'apt'
depends 'yum'
depends 'java'
depends 'postgresql'
