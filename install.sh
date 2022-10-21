#Executar o script apenas com o usuario root
if [ $(whoami) != "root" ]
    then  
        echo "" 
        echo "Execute o script com o usuario root apenas!"
        echo ""
        exit 0
fi

dataInicioScript=$(date +"%d-%m-%Y_%H-%M-%S")
nextcloudTempDir="/root/nextcloud_temp_dir_$dataInicioScript"
temporaryConfigFile="$nextcloudTempDir/Nextcloud/.env"
temporaryComposeConfiguration="$nextcloudTempDir/Nextcloud/docker-compose.yml"

##############################################################################################
### FUNCOES ###
##############################################################################################

#Gera uma senha aleatoria
randpw(){
     < /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c${1:-13};echo;     
}
#Verifica se Docker e Docker compose estao instalados
hasDocker(){
    echo $(docker -v | grep -i "docker ver" | wc -l)
}
##############################################################################################
hasDockerCompose(){
    echo `docker-compose -v | grep -i "compose ver" | wc -l`
}
##############################################################################################
getUserInput(){
    read -p "Digite o nome do dominio (ex: nextcloud.exemplo.com.br): " dominioNextcloud
    #Se o usuario nao escrever nada no dominio, definir nextcloud.exemplo.com.br como padrao
    if [ -z "$dominioNextcloud"]
        then
            dominioNextcloud=nextcloud.exemplo.com.br
    fi

    echo "Por padrão, o Nextcloud será instalado na pasta /Nextcloud"

    read -p "Deseja alterar a pasta de instalação? [y/N]: " escolha


#Verifica se o usuario deseja instalar o nextcloud em outro local
    nextCloudInstallDir=""
    if [ "$escolha" = "y" -o "$escolha" = "Y" ]
        then
            while [ `echo -n "$nextCloudInstallDir"|wc -c` -le 3 ]
            do
                echo "AVISO: O CONTEUDO DA PASTA ESCOLHIDA SERÁ APAGADO"
                read -p "Digite o caminho COMPLETO de onde será instalado o Nextcloud: " nextCloudInstallDir
            done
    else
            nextCloudInstallDir="/Nextcloud"
    fi

    echo ""
    echo "Local de instalacao: $nextCloudInstallDir"
    echo "Dominio: $dominioNextcloud"
    echo ""
}
##############################################################################################
InstallDocker(){
    #Instalar docker se docker nao estiver instalado
    if [ "$(hasDocker)" -eq 1 ]
        then
            echo "Docker está instalado no sistema"
            systemctl enable docker
            systemctl start docker
        else
            echo "Instalando Docker..."
            curl -fsSL https://get.docker.com -o get-docker.sh
            sudo sh get-docker.sh
            systemctl enable docker
            systemctl start docker
    fi
}
##############################################################################################
InstallDockerCompose(){
    #Instalar docker-compose se docker nao estiver instalado
    if [ "$(hasDockerCompose)" -eq 1 ]
        then
            echo "Docker-Compose está instalado no sistema"
            systemctl enable docker
            systemctl start docker
        else
            echo "Instalando Docker-Compose..."
            curl -SL https://github.com/docker/compose/releases/download/v2.11.2/docker-compose-linux-x86_64 -o /usr/local/bin/docker-compose
            sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
            chmod +x /usr/local/bin/docker-compose /usr/bin/docker-compose
    fi
}
##############################################################################################
### FIM DAS FUNCOES ###
##############################################################################################

##############################################################################################
### INICIO SCRIPT ###
##############################################################################################

InstallDocker
InstallDockerCompose

#Avisa e sai do script se docker nao estiver instalado
if [ "$(hasDocker)" -eq 0 ]
    then
        echo "Docker precisa estar instalado no sistema para continuar com a instalação"
        exit 0
fi
#Avisa e sai do script se docker-compose nao estiver instalado
if [ "$(hasDockerCompose)" -eq 0 ]
    then
        echo "Docker-Compose precisa estar instalado no sistema para continuar com a instalação"
        exit 0
fi

#Avisa que o Docker e Docker-Compose foram encontrados e que o script vai iniciar

getUserInput

read -p "As informacoes acima estao corretas? [y/N] " desejaProssegui
if [ "$desejaProssegui" = "y" -o "$desejaProssegui" = "Y" ]
then
    echo ""
    echo "Iniciando instalacao em 10 segundos"
    echo "Pressione Ctrl+C caso queira cancelar a instalação"
    echo ""
    sleep 7
    echo "3"
    sleep 1
    echo "2"
    sleep 1
    echo "1"
    sleep 1
    #baixar arquivos de configuração do Nextcloud
    mkdir $nextcloudTempDir
    cd $nextcloudTempDir
    git clone https://github.com/vitorarend/Nextcloud.git

    # Editar a configuracao dos arquivos baixados anteriormente

    ### Gerando senhas para o Banco de dados e colocando elas no arquivo de configuração
    MYSQL_PASSWD=$(randpw)
    MYSQL_ROOT_PASSWD=$(randpw)
    NEXTCLOUD_USER_PASSWD=$(randpw)
    sed -i "s/nextpasswd456/$MYSQL_PASSWD/g" "$temporaryConfigFile"
    sed -i "s/rootdbpasswd123/$MYSQL_ROOT_PASSWD/g" "$temporaryConfigFile"
    ### Alterando o domínio de exemplo pelo domminio escolhido
    sed -i "s/drive.example.com/$dominioNextcloud/g" "$temporaryConfigFile"
    ### Alterar a senha do admin do nextcloud
    sed -i "s/nextcloudwbpasswd2776/$NEXTCLOUD_USER_PASSWD/g" "$temporaryConfigFile"
    ### Altera o caminho de instalação do Docker-Compose
    sed -i "s,\/Nextcloud,$nextCloudInstallDir,g" "$temporaryComposeConfiguration"
    

    # Copia os arquivos do Nextcloud para a pasta de instalacao
    mkdir -p $nextCloudInstallDir
    cp -fra $nextcloudTempDir/Nextcloud/* $nextCloudInstallDir
    cp -fra $nextcloudTempDir/Nextcloud/.* $nextCloudInstallDir
    
    cd $nextCloudInstallDir
    docker-compose up -d
    echo "Aguard alguns minutos para acessar o seu nextcloud no link: https://$dominioNextcloud"
    echo "Login: admin"
    echo "Senha: $NEXTCLOUD_USER_PASSWD"

else
    echo ""
    echo "Saindo do script..."
    echo ""
    exit 0
fi
