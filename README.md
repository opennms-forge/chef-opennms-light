opennms Cookbook
================
[![Build Status](https://travis-ci.org/indigo423/chef-opennms.svg)](https://travis-ci.org/indigo423/chef-opennms)

[travis]: https://travis-ci.org/indigo423/chef-opennms

This cookbook allows to configure  an install the enterprise network management platform OpenNMS. 

Requirements
------------
- `java`Oracle or OpenJDK in version 7
- `postgresql`

Dependencies
------------
The OpenNMS cookbook depends on the cookbook `java` and `postgresql`. The  cookbook dependencies are handled by `Berkshelf`.  The  Java and Postgres cookbooks are preconfigured to met the requirements for running OpenNMS. The following default attributes are set:

### java
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>[‘java’][‘install_flavor’]</tt></td>
    <td>String</td>
    <td>Set the Java environment used for OpenNMS. Please check the Java cookbook README to see which flavors are valid.</td>
    <td><tt>openjdk</tt></td>
  </tr>
  <tr>
    <td><tt>[‘java’][‘jdk_version’]</tt></td>
    <td>Integer</td>
    <td>Set the Java version used for OpenNMS. Please check the Java cookbook README to see which flavors are valid.</td>
    <td><tt>7</tt></td>
  </tr>
</table>

### postgresql
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>[‘postgresql’][‘password’][‘postgres’]</tt></td>
    <td>String</td>
    <td>Set a password for the Postgres user</td>
    <td><tt>opennms_pg</tt></td>
  </tr>
  <tr>
    <td><tt>[‘postgresql’][‘pg_hba’]</tt></td>
    <td>Array</td>
    <td>Configure access to Postgres using MD5 password authentication</td>
    <td>
      <tt>
        [{:type => 'host', :db => 'all', :user => 'all', :addr => '127.0.0.1/32', :method => 'md5'},
        {:type => 'host', :db => 'all', :user => 'all', :addr => '::1/128', :method => 'md5'}]
      </tt>
  </td>
  </tr>
</table>

Attributes
----------
The default configuration installs latest OpenNMS stable from official OpenNMS repositories with a default configuration. The following attributes can be modified to configure OpenNMS through Chef.

#### Database configuration: opennms::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['opennms’][‘java_heap_space’]</tt></td>
    <td>Integer</td>
    <td>Size for Java heap size in mega bytes.</td>
    <td><tt>1024</tt></td>
  </tr>
  <tr>
    <td><tt>['opennms’][‘start_timeout’’]</tt></td>
    <td>Integer</td>
    <td>Wait time interval in seconds used in OpenNMS init script to evaluate the OpenNMS service status during start and stop OpenNMS.</td>
    <td><tt>0</tt></td>
  </tr>
  <tr>
    <td><tt>['opennms’][‘release’]</tt></td>
    <td>String</td>
    <td>Which version of OpenNMS should be installed: `stable`, `testing`,`unstable`,`snapshot`</td>
    <td><tt>stable</tt></td>
  </tr>
  <tr>
    <td><tt>['opennms’][‘postgres’][‘admin’]</tt></td>
    <td>String</td>
    <td>Postgres user name which has the permission to create and initialize the OpenNMS database scheme.</td>
    <td><tt>postgres</tt></td>
  </tr>
  <tr>
    <td><tt>['opennms’][‘dbhost’]</tt></td>
    <td>String</td>
    <td>Host or IP address for the Postgres database server</td>
    <td><tt>localhost</tt></td>
  </tr>
  <tr>
    <td><tt>['opennms’][‘dbport’]</tt></td>
    <td>Integer</td>
    <td>TCP port where Postgres database is listening</td>
    <td><tt>5432</tt></td>
  </tr>
  <tr>
    <td><tt>['opennms’][‘dbname’]</tt></td>
    <td>String</td>
    <td>Postgres OpenNMS database name.</td>
    <td><tt>opennms</tt></td>
  </tr>
  <tr>
    <td><tt>['opennms’][‘dbuser’]</tt></td>
    <td>String</td>
    <td>Postgres user which allows access to the OpenNMS database.</td>
    <td><tt>opennms</tt></td>
  </tr>
  <tr>
    <td><tt>['opennms’][‘dbpass’]</tt></td>
    <td>String</td>
    <td>Postgres password for OpenNMS database user.</td>
    <td><tt>opennms</tt></td>
  </tr>
</table>

#### Configure RRD time series data technology: opennms::default
In OpenNMS you can choose between two RRD technologies `JRobin` and `RRDtool`. The given attributes allow to switch between the both technologies.

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['opennms’][‘library’][‘jrrd’]</tt></td>
    <td>String</td>
    <td>Full path to `libjrrd.so`. On 32bit machines it is by default installed to `/usr/lib/libjrrd.so`</td>
    <td><tt>/usr/lib64/libjrrd.so</tt></td>
  </tr>
  <tr>
    <td><tt>['opennms’][‘rrd’][‘strategyClass’]</tt></td>
    <td>String</td>
    <td>Set the implementation for the RRD technology. `JRobinRrdStrategy`is for Java RRD implementation with `JRobin`, the `JniRrdStrategy`can be used for running OpenNMS with native `RRDtool`.</td>
    <td><tt>org.opennms.netmgt.rrd.jrobin.JRobinRrdStrategy</tt></td>
  </tr>
  <tr>
    <td><tt>['opennms’][‘rrd’][‘interfaceJar’]</tt></td>
    <td>String</td>
    <td>Full path to `jrrd.jar`.</td>
    <td><tt>/usr/share/java/jrrd.jar</tt></td>
  </tr>
</table>

#### Configure RRD time series tuning parameters: opennms::default
In OpenNMS you can choose between two RRD technologies `JRobin` and `RRDtool`. The given attributes allow to switch between the both technologies.

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['opennms’][‘rrd’][‘usequeue’]</tt></td>
    <td>Boolean</td>
    <td></td>
    <td><tt>true</tt></td>
  </tr>
  <tr>
    <td><tt>['opennms’][‘rrd’][‘queuing’][‘writethreads’]</tt></td>
    <td>Integer</td>
    <td></td>
    <td><tt>2</tt></td>
  </tr>
  <tr>
    <td><tt>['opennms’][‘rrd’][‘queuing’][‘queuecreates’]</tt></td>
    <td>Boolean</td>
    <td></td>
    <td><tt>false</tt></td>
  </tr>
  <tr>
    <td><tt>['opennms’][‘rrd’][‘queuing’][‘prioritizeSignificantUpdates’]</tt></td>
    <td>Boolean</td>
    <td></td>
    <td><tt>false</tt></td>
  </tr>
  <tr>
    <td><tt>['opennms’][‘rrd’][‘queuing’][‘maxInsigUpdateSeconds’]</tt></td>
    <td>Integer</td>
    <td></td>
    <td><tt>0</tt></td>
  </tr>
  <tr>
    <td><tt>['opennms’][‘rrd’][‘queuing’][‘modulus’]</tt></td>
    <td>Integer</td>
    <td></td>
    <td><tt>10000</tt></td>
  </tr>
  <tr>
    <td><tt>['opennms’][‘rrd’][‘queuing’][‘inSigHighWaterMark’]</tt></td>
    <td>Integer</td>
    <td></td>
    <td><tt>0</tt></td>
  </tr>
  <tr>
    <td><tt>['opennms’][‘rrd’][‘queuing’][‘sigHighWaterMark’]</tt></td>
    <td>Integer</td>
    <td></td>
    <td><tt>0</tt></td>
  </tr>
  <tr>
    <td><tt>['opennms’][‘rrd’][‘queuing’][‘queueHighWaterMark’]</tt></td>
    <td>Integer</td>
    <td></td>
    <td><tt>0</tt></td>
  </tr>
  <tr>
    <td><tt>['opennms’][‘rrd’][‘queuing’][‘writethread’][‘sleepTime’]</tt></td>
    <td>Integer</td>
    <td></td>
    <td><tt>50</tt></td>
  </tr>
  <tr>
    <td><tt>['opennms’][‘rrd’][‘queuing’][‘writethread’][‘exitDelay’]</tt></td>
    <td>Integer</td>
    <td></td>
    <td><tt>60000</tt></td>
  </tr>
  <tr>
    <td><tt>['opennms’][‘jrobin’][‘rrdBackendFactory’]</tt></td>
    <td>String</td>
    <td></td>
    <td><tt>FILE</tt></td>
  </tr>
  <tr>
    <td><tt>['opennms’][‘rrd’][‘usetcp’]</tt></td>
    <td>Boolean</td>
    <td></td>
    <td><tt>false</tt></td>
  </tr>
  <tr>
    <td><tt>['opennms’][‘rrd’][‘tcp’][‘host’]</tt></td>
    <td>String</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td><tt>['opennms’][‘rrd’][‘tcp’][‘port’]</tt></td>
    <td>Integer</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td><tt>['opennms’][‘storeByGroup’]</tt></td>
    <td>Boolean</td>
    <td></td>
    <td><tt>false</tt></td>
  </tr>
  <tr>
    <td><tt>['opennms’][‘storeByForeignSource’]</tt></td>
    <td>Boolean</td>
    <td></td>
    <td><tt>false</tt></td>
  </tr>
</table>

#### Configure Jetty application container: opennms::default

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['opennms’][‘jetty’][‘port’]</tt></td>
    <td>Integer</td>
    <td>TCP port for Jetty running the OpenNMS web application.</td>
    <td><tt>8980</tt></td>
  </tr>
  <tr>
    <td><tt>['opennms’][‘web’][‘baseurl’]</tt></td>
    <td>String</td>
    <td>URL schema accessing the OpenNMS web application. If you have OpenNMS running behind a SSL reverse proxy, change this value, e.g. `https://%x%c`.</td>
    <td><tt>http://%x%c/</tt></td>
  </tr>
  <tr>
    <td><tt>['opennms’][‘jetty’][‘requestHeaderSize’]</tt></td>
    <td>Integer</td>
    <td></td>
    <td><tt>4000</tt></td>
  </tr>
  <tr>
    <td><tt>['opennms’][‘jetty’][‘maxFormKeys’]</tt></td>
    <td>Integer</td>
    <td></td>
    <td><tt>2000</tt></td>
  </tr>
</table>

#### Configure OpenNMS web application: opennms::default

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['opennms’][‘propertiesCache’][‘enableCheckFileModified’]</tt></td>
    <td>Boolean</td>
    <td></td>
    <td><tt>false</tt></td>
  </tr>
  <tr>
    <td><tt>['opennms’][‘webaclsEnabled’]</tt></td>
    <td>Boolean</td>
    <td></td>
    <td><tt>false</tt></td>
  </tr>
  <tr>
    <td><tt>['opennms’][‘assets’][‘allowHtmlFields’]</tt></td>
    <td>String</td>
    <td></td>
    <td><tt>comments, description</tt></td>
  </tr>
  <tr>
    <td><tt>['opennms’][‘eventlist’][‘acknowledge’]</tt></td>
    <td>Boolean</td>
    <td></td>
    <td><tt>false</tt></td>
  </tr>
  <tr>
    <td><tt>['opennms’][‘eventlist’][‘showCount’]</tt></td>
    <td>Boolean</td>
    <td></td>
    <td><tt>false</tt></td>
  </tr>
  <tr>
    <td><tt>['opennms’][‘nodesWithOutages’][‘count’]</tt></td>
    <td>Integer</td>
    <td></td>
    <td><tt>12</tt></td>
  </tr>
  <tr>
    <td><tt>['opennms’][‘nodesWithOutages’][‘show’]</tt></td>
    <td>Boolean</td>
    <td></td>
    <td><tt>true</tt></td>
  </tr>
  <tr>
    <td><tt>['opennms’][‘nodesWithProblems’][‘count’]</tt></td>
    <td>Integer</td>
    <td></td>
    <td><tt>16</tt></td>
  </tr>
  <tr>
    <td><tt>['opennms’][‘nodesWithProblems’][‘show’]</tt></td>
    <td>Boolean</td>
    <td></td>
    <td><tt>false</tt></td>
  </tr>
  <tr>
    <td><tt>['opennms’][‘nodeStatusBar’][‘show’]</tt></td>
    <td>Boolean</td>
    <td></td>
    <td><tt>false</tt></td>
  </tr>
  <tr>
    <td><tt>['opennms’][‘disableLoginSuccessEvent’]</tt></td>
    <td>Boolean</td>
    <td></td>
    <td><tt>false</tt></td>
  </tr>
  <tr>
    <td><tt>['opennms’][‘ksc’][‘graphsPerLine’]</tt></td>
    <td>Integer</td>
    <td></td>
    <td><tt>1</tt></td>
  </tr>
</table>

#### Configure geographical map implementation: opennms::default

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['opennms’][‘maptype’]</tt></td>
    <td>String</td>
    <td></td>
    <td><tt>OpenLayers</tt></td>
  </tr>
  <tr>
    <td><tt>['opennms’][‘apikey’]</tt></td>
    <td>String</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td><tt>['opennms’][‘geocoder’][‘’class]</tt></td>
    <td>String</td>
<td><tt>org.opennms.features.poller.remote.gwt.server.geocoding.NullGeocoder</tt></td>
  </tr>
  <tr>
    <td><tt>['opennms’][‘geocoder’][‘rate’]</tt></td>
    <td>Integer</td>
    <td></td>
    <td><tt>10</tt></td>
  </tr>
  <tr>
    <td><tt>['opennms’][‘geocoder’][‘referer’]</tt></td>
    <td>String</td>
    <td></td>
    <td><tt>http://localhost</tt></td>
  </tr>
  <tr>
    <td><tt>['opennms’][‘geocoder’][‘minimumQuality’]</tt></td>
    <td>String</td>
    <td></td>
    <td><tt>ZIP</tt></td>
  </tr>
  <tr>
    <td><tt>['opennms’][‘geocoder’][‘nominatimEmail’]</tt></td>
    <td>String</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td><tt>['opennms’][‘openlayersUrl’]</tt></td>
    <td>String</td>
    <td></td>
    <td><tt>http://otile1.mqcdn.com/tiles/1.0.0/osm/${z}/${x}/${y}.png</tt></td>
  </tr>
</table>

#### Configure RTC for Eventd and geographical map: opennms::default

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['opennms’][‘rtc’][‘event’][‘proxyHost’]</tt></td>
    <td>String</td>
    <td></td>
    <td><tt>127.0.0.1</tt></td>
  </tr>
  <tr>
    <td><tt>['opennms’][‘rtc’][‘event’][‘proxyPort’]</tt></td>
    <td>Integer</td>
    <td></td>
    <td><tt>5817</tt></td>
  </tr>
  <tr>
    <td><tt>['opennms’][‘rtc’][‘event’][‘proxyTimeout’]</tt></td>
    <td>Integer</td>
    <td></td>
    <td><tt>2000</tt></td>
  </tr>
  <tr>
    <td><tt>['opennms’][‘rtc’][‘client’][‘httpPostBaseUrl’]</tt></td>
    <td>String</td>
    <td></td>
    <td><tt>http://localhost:8980/opennms/rtc/post</tt></td>
  </tr>
  <tr>
    <td><tt>['opennms’][‘rtc’][‘client’][‘httpPostUsername’]</tt></td>
    <td>String</td>
    <td></td>
    <td><tt>rtc</tt></td>
  </tr>
  <tr>
    <td><tt>['opennms’][‘rtc’][‘client’][‘httpPostPassword’]</tt></td>
    <td>String</td>
    <td></td>
    <td><tt>rtc</tt></td>
  </tr>
  <tr>
    <td><tt>['opennms’][‘map’][‘client’][‘httpPostBaseUrl’]</tt></td>
    <td>String</td>
    <td></td>
    <td><tt>http://localhost:8980/opennms/map/post'</tt></td>
  </tr>
  <tr>
    <td><tt>['opennms’][‘map’][‘client’][‘httpPostUsername’]</tt></td>
    <td>String</td>
    <td></td>
    <td><tt>map</tt></td>
  </tr>
  <tr>
    <td><tt>['opennms’][‘map’][‘client’][‘httpPostPassword’]</tt></td>
    <td>String</td>
    <td></td>
    <td><tt>map</tt></td>
  </tr>
</table>

#### Configure OpenNMS SNMP  implementation: opennms::default

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['opennms’][‘snmp’][‘strategyClass’]</tt></td>
    <td>String</td>
    <td></td>
    <td><tt>org.opennms.netmgt.snmp.snmp4j.Snmp4JStrategy</tt></td>
  </tr>
  <tr>
    <td><tt>['opennms’][‘snmp4j’][‘forwardRuntimeExceptions’]</tt></td>
    <td>Boolean</td>
    <td></td>
    <td><tt>false</tt></td>
  </tr>
  <tr>
    <td><tt>['opennms’][‘snmpCollector’][‘forceRescan’]</tt></td>
    <td>Boolean</td>
    <td></td>
    <td><tt>false</tt></td>
  </tr>
  <tr>
    <td><tt>['opennms’][‘snmpCollector’][‘limitCollectionToInstances’]</tt></td>
    <td>Boolean</td>
    <td></td>
    <td><tt>false</tt></td>
  </tr>
</table>

#### Configure Provisiond: opennms::default

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['opennms’][‘provisiond’][‘enableDiscovery’]</tt></td>
    <td>Boolean</td>
    <td></td>
    <td><tt>true</tt></td>
  </tr>
  <tr>
    <td><tt>['opennms’][‘provisiond’][‘enableDeletionOfRequisitionedEntities’]</tt></td>
    <td>Boolean</td>
    <td></td>
    <td><tt>false</tt></td>
  </tr>
  <tr>
    <td><tt>['opennms’][‘provisiond’][‘scheduleRescanForExistingNodes’]</tt></td>
    <td>Boolean</td>
    <td></td>
    <td><tt>true</tt></td>
  </tr>
  <tr>
    <td><tt>['opennms’][‘provisiond’][‘scheduleRescanForUpdatedNodes’]</tt></td>
    <td>Boolean</td>
    <td></td>
    <td><tt>true</tt></td>
  </tr>
  <tr>
    <td><tt>['opennms’][‘provisiond’][‘importThreads’]</tt></td>
    <td>Integer</td>
    <td></td>
    <td><tt>8</tt></td>
  </tr>
  <tr>
    <td><tt>['opennms’][‘provisiond’][‘scanThreads’]</tt></td>
    <td>Integer</td>
    <td></td>
    <td><tt>10</tt></td>
  </tr>
  <tr>
    <td><tt>['opennms’][‘provisiond’][‘rescanThreads’]</tt></td>
    <td>Integer</td>
    <td></td>
    <td><tt>10</tt></td>
  </tr>
  <tr>
    <td><tt>['opennms’][‘provisiond’][‘writeThreads’]</tt></td>
    <td>Integer</td>
    <td></td>
    <td><tt>8</tt></td>
  </tr>
</table>

#### Configure remote poller: opennms::default

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['opennms’][‘minimumConfigurationReloadInterval’]</tt></td>
    <td>Integer</td>
    <td></td>
    <td><tt> 300000 </tt></td>
  </tr>
  <tr>
    <td><tt>['opennms’][‘excludeServiceMonitorsFromRemotePoller’]</tt></td>
    <td>String</td>
    <td></td>
    <td><tt>DHCP,NSClient,RadiusAuth,XMP</tt></td>
  </tr>
</table>

#### Configure remote poller and Collectd settings: opennms::default

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['opennms’][‘minimumConfigurationReloadInterval’]</tt></td>
    <td>Integer</td>
    <td></td>
    <td><tt>300000</tt></td>
  </tr>
  <tr>
    <td><tt>['opennms’][‘datacollection’][‘reloadCheckInterval’]</tt></td>
    <td>Integer</td>
    <td></td>
    <td><tt>30000</tt></td>
  </tr>
</table>

Usage
-----
#### opennms::default
This cookbook will install OpenNMS with all default settings. You have just include `opennms` in your node’s `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[opennms]"
  ]
}
```

#### opennms::remote-poller
This cookbook will install OpenNMS with all default settings. You have just include `opennms` in your node’s `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[opennms]"
  ]
}
```


Contributing
------------
TODO: (optional) If this is a public cookbook, detail the process for contributing. If this is a private cookbook, remove this section.

e.g.
1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
Authors: TODO: List authors
