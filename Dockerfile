FROM nginx
COPY ./nginx.conf /etc/nginx/nginx.conf
COPY ./example.pem /etc/nginx/ssl/nginx.crt
COPY ./example.key /etc/nginx/ssl/nginx.key
