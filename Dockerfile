
# Sample Dockerfile for the AppDynamics Java APM Agent
# This is provided for illustration purposes only, for full details 
# please consult the product documentation: https://docs.appdynamics.com/

# Pull base image 
From tomcat:8-jre8 

# Maintainer 
MAINTAINER "tricia.radcliffe@appdynamics.com" 

# Suggested to make sure you are installing specific appd agent versions
# ARG APPD_AGENT_VERSION 
# ARG APPD_AGENT_SHA256

# Copy to images tomcat path 
# ADD web.xml /usr/local/tomcat/conf/ 
# ADD obclient.properties /etc/ 
# ADD WebClient.properties /etc/ 
# ADD yourwarfile.war /usr/local/tomcat/webapps/ 

# To set the username and password to access Tomcat admin page. You can add settings.xml and tomcat-users.xml to the container by adding the following code in the dockerfile after the MAINTAINER line.
# ADD settings.xml /usr/local/tomcat/conf/
# ADD tomcat-users.xml /usr/local/tomcat/conf/

# Run Update and Install unzip
RUN apt-get update && apt-get install -y --no-install-recommends  unzip \
        && apt-get install -y --no-install-recommends procps \
        && rm -rf /var/lib/apt/lists/*
        
# Copy in your application
ADD ./sampleapp/sample.war /usr/local/tomcat/webapps/ 

# Copy AppDynamics Agent and delete zip
COPY ./appdynamics/AppServerAgent.zip /tmp
# RUN echo "${APPD_AGENT_SHA256} *AppServerAgent.zip" >> appd_checksum \
#    && sha256sum -c appd_checksum \
#    && rm appd_checksum \
#    && unzip -oq AppServerAgent.zip -d /tmp 
RUN unzip -oq /tmp/AppServerAgent.zip -d /opt/appdynamics && \
    rm /tmp/AppServerAgent.zip

# Set startup to include AppDynamics Jar
COPY ./appdynamics/setenv.sh ${CATALINA_HOME}/bin/

EXPOSE 8080
