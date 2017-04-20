# nginx_nexus
Nginx reverse proxy setup for nexus repository

Assumption: Nexus repository (docker instance) is already running on same host with default settings and the hosted docker registry HTTP port is selected as 5000. Private network "intranet" is used.

Add the SSL certificate and key files as example.pem and example.key respectively.

    docker build -t nginx-img .

    docker run -d --publish 80:80 -p 443:443 --name nginx --restart unless-stopped --network intranet nginx-img

This will build and run the nginx reverse proxy server to be accessible for nexus configuration as well as private docker registry.
