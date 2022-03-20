# Nextcloud
Docker and Docker Compose configuration for deploying Nextcloud on production environment

Whats is ready:
- Database;
- Redis;
- Nextcloud (Only in HTTP).

What needs to be done:
- NGINX reverse HTTP and HTTPS proxy (the "nc_nginx" container);
- Let's Encrypt certificate renovation (maybe do it on the "nc_nginx" container).


Procedure to install to the folder /docker on a linux machine
<pre>
rm -rf /docker
cd
rm -rf ./mai* ./Nextcloud-main/
docker system prune -f
docker image prune -f
mkdir /docker
wget https://codeload.github.com/YayPeace/Nextcloud/zip/refs/heads/main -o main.zip
unzip ./main
mv ./Nextcloud-main/* /docker
chmod -R 777 /docker/nc_nginx/
cd /docker
docker-compose up -d
</pre>
