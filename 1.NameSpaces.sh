#!/bin/bash

docker run -it --rm -p 8888:8080 tomcat:9.0
docker run -d --rm -p 8888:8080 tomcat:9.0

docker exec 39c78aea5ca6 ps -aux

ps -aux | grep tomcat

~/Docker/Advance$ docker exec 39c78aea5ca6 ps -aux
USER         PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root           1  2.2  0.7 8379048 114512 ?      Ssl  16:50   0:02 /opt/java/openjdk/bin/java -Djava.util.logging.config.file=/usr/local/tomcat/conf/logging.properties -Djava.util.logging.manager=org.apache.juli.ClassLoaderLogManager -Djdk.tls.ephemeralDHKeySize=2048 -Djava.protocol.handler.pkgs=org.apache.catalina.webresources -Dorg.apache.catalina.security.SecurityListener.UMASK=0027 -Dignore.endorsed.dirs= -classpath /usr/local/tomcat/bin/bootstrap.jar:/usr/local/tomcat/bin/tomcat-juli.jar -Dcatalina.base=/usr/local/tomcat -Dcatalina.home=/usr/local/tomcat -Djava.io.tmpdir=/usr/local/tomcat/temp org.apache.catalina.startup.Bootstrap start
root          51  0.0  0.0  10068  1584 ?        Rs   16:52   0:00 ps -aux
~/Docker/Advance$ ps -aux | grep tomcat
root       51388  1.2  0.7 8379048 115220 ?      Ssl  20:50   0:02 /opt/java/openjdk/bin/java -Djava.util.logging.config.file=/usr/local/tomcat/conf/logging.properties -Djava.util.logging.manager=org.apache.juli.ClassLoaderLogManager -Djdk.tls.ephemeralDHKeySize=2048 -Djava.protocol.handler.pkgs=org.apache.catalina.webresources -Dorg.apache.catalina.security.SecurityListener.UMASK=0027 -Dignore.endorsed.dirs= -classpath /usr/local/tomcat/bin/bootstrap.jar:/usr/local/tomcat/bin/tomcat-juli.jar -Dcatalina.base=/usr/local/tomcat -Dcatalina.home=/usr/local/tomcat -Djava.io.tmpdir=/usr/local/tomcat/temp org.apache.catalina.startup.Bootstrap start
timeline   51741  0.0  0.0   9044   724 pts/0    S+   20:54   0:00 grep --color=auto tomcat