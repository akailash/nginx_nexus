FROM nginx

RUN apt-get update

# Install necessary tools
RUN apt-get install -y nano wget dialog net-tools
RUN apt-get install dnsutils -y

COPY ./nginx.conf /etc/nginx/nginx.conf
COPY ./server-cert.pem /etc/nginx/ssl/nginx.crt
COPY ./server-key.pem /etc/nginx/ssl/nginx.key
