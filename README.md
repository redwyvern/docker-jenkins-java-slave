Redwyvern Jenkins - Java Slave 
==============================

This is the Jenkins Docker slave image for Redwyvern software.

This slave contains software to build the following type of projects:
* Java 8
* Maven

Once a container from this image is running it is ready run as a Jenkins slave without further configuration.

Example YAML file:
```
version: '3'

services:
  java-slave:
    image:  docker.artifactory.weedon.org.au/redwyvern/jenkins-java-slave
    container_name: java-slave
    hostname: java-slave
    restart: always
    dns: 192.168.1.50
    networks:
      - dev_nw

networks:
  dev_nw:
```
