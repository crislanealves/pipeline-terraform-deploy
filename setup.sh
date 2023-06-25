#!/usr/bin/env bash

# green
green() {
  echo -e "\033[1;32m$@\033[0m"
}

# blue
blue() {
  echo -e "\033[1;34m$@\033[0m"
}
  
#install Google SDK

blue "$(tput sitm)Verificando se o sistema operacional atende aos requisitos necessários ...$(tput sgr0)"

sudo apt-get install apt-transport-https ca-certificates gnupg

green "$(tput bold)Requisitos verificados e aceitos com sucesso!$(tput sgr0)"

blue "$(tput sitm)Adiciondo o URI de distribuição da CLI gcloud como uma origem de pacote.$(tput sgr0)"

echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list

blue "$(tput sitm)Importando a chave pública do Google Cloud...$(tput sgr0)"

curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -

blue "$(tput sitm)Atualizando e instalando a CLI gcloud...$(tput sgr0)"

sudo apt-get update && sudo apt-get install google-cloud-cli
 
green "$(tput bold)Google SDK instalado com sucesso! $(tput sgr0)"

blue "$(tput bold)Clique no link abaixo para que o Google Cloud SDK acesse sua conta do Google$(tput sgr0)"

gcloud auth login