FROM nginx:stable

ARG DOMAIN_NAME



RUN apt-get update
RUN apt-get install -y certbot python3-certbot-nginx

RUN echo $DOMAIN_NAME

RUN echo 'upstream frontend_server{' > /etc/nginx/conf.d/default.conf
RUN echo '      server 127.0.0.1:80;' >> /etc/nginx/conf.d/default.conf
RUN echo ' }' >> /etc/nginx/conf.d/default.conf
RUN echo '' >> /etc/nginx/conf.d/default.conf
RUN echo 'server{' >> /etc/nginx/conf.d/default.conf
RUN echo '   listen 80;' >> /etc/nginx/conf.d/default.conf
RUN echo '' >> /etc/nginx/conf.d/default.conf
RUN echo '   location /.well-known/acme-challenge/ {' >> /etc/nginx/conf.d/default.conf
RUN echo '       root /var/www/certbot;' >> /etc/nginx/conf.d/default.conf
RUN echo '   }' >> /etc/nginx/conf.d/default.conf
RUN echo '   location / {' >> /etc/nginx/conf.d/default.conf
RUN echo '       return 301 https://$host$request_uri;' >> /etc/nginx/conf.d/default.conf
RUN echo '   }' >> /etc/nginx/conf.d/default.conf
RUN echo '  } ' >> /etc/nginx/conf.d/default.conf
RUN cat /etc/nginx/conf.d/default.conf
RUN certbot --nginx --agree-tos -d $DOMAIN_NAME --register-unsafely-without-email
