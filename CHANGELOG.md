opennms CHANGELOG
=================

This file is used to list changes made in each version of the opennms cookbook.

0.2.2
-----
- [Ronny Trommer] - Initial release of opennms

0.2.3
-----
- [Ronny Trommer] - Added missing metadata.json

0.2.4
-----
- [Ronny Trommer] - Introducing changelog

0.2.5
-----
- [Ronny Trommer] - Changed receipe dependency from postgresql to postgresql::server
- [Ronny Trommer] - Renamed to opennms-light, aiming for minimal config and working with stable,testing and unstable

1.0.1
-----
- [Alejandro Galue] - Fix rrd-configuration.properties to use rrd.interfaceJar variable

1.0.2
-----
- [Ronny Trommer] - Added support for different Ubuntu mirror settings
- [Ronny Trommer] - Removed recipes for java and postgres in test kitchen, included in the opennms-light repo

1.0.3
-----
- [Ronny Trommer] - Moved postgres cookbook behind apt-get update to prevent unreachable ubuntu repositories
- [Ronny Trommer] - Changed Oracle install package to be compatible with non existing Oracle package in branches

1.0.4
-----
- [Ronny Trommer] - Update configuration files to HORIZON 17

1.0.5   
-----
- [Ronn Trommer] - Changed repository to new mirror servers


- - -
Check the [Markdown Syntax Guide](http://daringfireball.net/projects/markdown/syntax) for help with Markdown.

The [Github Flavored Markdown page](http://github.github.com/github-flavored-markdown/) describes the differences between markdown on github and standard markdown.
