# nginx_nexus
Nginx reverse proxy setup for nexus repository

Steps:


    On host:
        docker volume create --name nexus-data && docker network create intranet

        docker run -d --name nexus -v nexus-data:/nexus-data --restart unless-stopped --network intranet sonatype/docker-nexus3

        git clone https://github.com/akailash/nginx_nexus.git
        cd nginx_nexus
        openssl genrsa -aes256 -out ca-key.pem 4096
        openssl req -new -x509 -days 365 -key ca-key.pem -sha256 -out ca.pem
        openssl genrsa -out server-key.pem 4096
        openssl req -subj "/CN=nexus.demo.com" -sha256 -new -key server-key.pem -out server.csr
        echo subjectAltName = DNS:nexus.demo.com,IP:10.40.195.66,IP:127.0.0.1 > extfile.cnf
        openssl x509 -req -days 365 -sha256 -in server.csr -CA ca.pem -CAkey ca-key.pem \\n  -CAcreateserial -out server-cert.pem -extfile extfile.cnf

        docker stop nginx
        docker rm nginx
        docker build -t nginx-img .
        docker run -d -p 80:80 -p 443:443 --name nginx --restart unless-stopped --network intranet nginx-img

    On Client:

           Copy the "ca.pem" file to client machines

           Edit /etc/hosts to link nexus.demo.com to IP address of host
           For Linux:

           sudo mkdir /etc/docker/certs.d/nexus.demo.com

           sudo cp ca.crt /etc/docker/certs.d/nexus.demo.com
           For Mac:

           sudo security add-trusted-cert -d -r trustRoot -k /Library/Keychains/System.keychain ca.pem

           Restart docker daemon to use the added certificate.


