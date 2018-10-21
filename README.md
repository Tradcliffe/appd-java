# appd-java
This is a simple version of tomcat app with AppD agent without user of docker compose.

clone this repo
Download a version of appdynamics app agent.
 & place in ./appdynamics folder then rename to AppServerAgent.zip
modify the appdynamics.env to setup your agent environment variables

Build image
docker build -t someone/sampleapp:2.0 .

Run Image
docker container run -p 8080:8080 -d --name tomcat --env-file appdynamics.env someone/sampleapp:2.0

If you need to inspect the image, logs are under /opt/appdynamics/{version}/logs
docker exec -it tomcat bash
