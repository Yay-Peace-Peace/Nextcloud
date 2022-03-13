# Nextcloud
Docker and Docker Compose configuration procedure for deploying Nextcloud on production environment

Whats is ready:
- Database;
- Redis;
- Nextcloud (Only in HTTP).

What needs to be done:
- NGINX reverse HTTP and HTTPS proxy (the "nc_nginx" container);
- Let's Encrypt certificate renovation (maybe do it on the "nc_nginx" container).


Procedure to install to the folder /docker on a linux machine
<pre>
wget https://codeload.github.com/YayPeace/Nextcloud/zip/refs/heads/main
unzip ./Nextcloud-main.zip
mv ./Nextcloud-main /docker
cd /docker
docker-compode up -d
</pre>
