<b>
<h3>
Observação: é necesário alterar alguns aquivos antes de iniciar o container:
 </h3>
  <pre>
- .env -> alterar MYSQL_PASSWORD, MYSQL_ROOT_PASSWORD, DOMAIN_NAME, OVERWRITEHOST, domain
- Após a instalação, seguir o procedimento do arquivo POST_INSTALL.txt
</pre>
    
</b>
Procedimento para instalação:
<pre>
# Primeiramente instalar o docker, docker-compose e git

mkdir /Nextcloud
cd /Nextcloud
git clone --branch v3.0 https://github.com/YayPeace/Nextcloud.git
cp -rf /Nextcloud/Nextcloud/ /
rm -rf /Nextcloud/Nextcloud/

cd /Nextcloud
docker-compose up -d

#Aguardar alguns minutos antes de acessar o Nextcloude e se guir os procedimentos do arquivo POST_INSTALL.txt
</pre>
