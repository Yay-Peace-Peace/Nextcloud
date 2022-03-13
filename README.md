# Nextcloud
Docker and Docker Compose configuration procedure for deploying Nextcloud on production environment

Whats is ready:
- Database;
- Redis;
- Nextcloud (Only in HTTP).

What needs to be done:
- NGINX reverse HTTPS with certbot SSL certificates.

<pre>
wget https://codeload.github.com/YayPeace/Nextcloud/zip/refs/heads/main
unzip ./Nextcloud-main.zip
mv ./Nextcloud-main /docker
cd /docker
docker-compode up -d
</pre>
