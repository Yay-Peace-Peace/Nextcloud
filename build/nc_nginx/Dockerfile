FROM nginx

#ENV DOMAIN_NAME tsukihi.duckdns.org

#COPY ./default.conf /etc/nginx/conf.d/default.conf
#COPY ./nginx.conf /etc/nginx/nginx.conf

#RUN mv /etc/nginx/conf.d/default.conf /etc/nginx/conf.d/$DOMAIN_NAME.conf

RUN apt update && apt install -y vim certbot python3-certbot-nginx

#RUN certbot --nginx -d $DOMAIN_NAME --register-unsafely-without-email --agree-tos

#RUN sed -i '$ d' /etc/cron.d/certbot && echo '0 */23 * * * root certbot -q renew --nginx' >> /etc/cron.d/certbot
