<b>
<h3>
Observação: é necesário alterar alguns aquivos antes de iniciar o container:
 </h3>
  <pre>
- nc_nginx/etc/nginx/conf.d/nextcloud.example.com.conf: Alterar o nome para o nome do seu domínio
- nc_nginx/etc/nginx/conf.d/nextcloud.example.com.conf: Dentro do arquivo, alterar todos os locais com nextcloud.example.com para o seu dominio
- docker-compose.yml: Alterar DOMAIN_NAME: nextcloud.example.com para o seu dominio
- docker-compose.yml: Alterar as senhas do sistemas nas linhas que iniciam com MYSQL_ROOT_PASSWORD, MYSQL_PASSWORD e NEXTCLOUD_ADMIN_PASSWORD
- Após a instalação, seguir o procedimento do arquivo POST_INSTALL.txt
</pre>
    
</b>
Procedimento para instalação:
<pre>
mkdir /docker
wget https://codeload.github.com/YayPeace/Nextcloud/zip/refs/heads/main -o main.zip
unzip ./main
mv ./Nextcloud-main/* /docker
chmod -R 777 /docker/nc_nginx/
cd /docker
docker-compose up -d
chmod -R 777 /docker/nc_nginx/
</pre>
