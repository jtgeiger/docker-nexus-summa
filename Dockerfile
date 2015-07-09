FROM ubuntu:14.04

MAINTAINER Joel Geiger "jgeiger@summa-tech.com"


RUN adduser --system --no-create-home --group nexus

ENV NEXUS_VERSION 2.11.3-01

ADD http://download.sonatype.com/nexus/oss/nexus-${NEXUS_VERSION}-bundle.tar.gz /opt/
ADD http://download.sonatype.com/nexus/oss/nexus-${NEXUS_VERSION}-bundle.tar.gz.asc /opt/

RUN gpg --keyserver pgp.mit.edu --recv-keys 8DD1BDFD && \
    gpg --verify /opt/nexus-${NEXUS_VERSION}-bundle.tar.gz.asc /opt/nexus-${NEXUS_VERSION}-bundle.tar.gz && \
    tar xvzf /opt/nexus-${NEXUS_VERSION}-bundle.tar.gz --directory /opt && \
    rm /opt/nexus-${NEXUS_VERSION}-bundle.tar.gz && \
    rm /opt/nexus-${NEXUS_VERSION}-bundle.tar.gz.asc

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y openjdk-7-jre-headless && \
    rm -rf /var/lib/apt/lists/*

RUN chown -R nexus:nexus /opt/nexus-${NEXUS_VERSION}/
RUN chown -R nexus:nexus /opt/sonatype-work/

USER nexus

EXPOSE 8081

#Using the 'shell' form here so that the env variable will be expanded:
CMD /opt/nexus-${NEXUS_VERSION}/bin/nexus console
