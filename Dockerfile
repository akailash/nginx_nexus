FROM nginx
COPY ./nginx.conf /etc/nginx/nginx.conf
COPY ./server-cert.pem /etc/nginx/ssl/nginx.crt
COPY ./server-key.pem /etc/nginx/ssl/nginx.key
