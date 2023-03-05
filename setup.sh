#!/bin/bash

echo "Verificando compatibilidade do sistema operacional ..."

sudo apt-get install apt-transport-https ca-certificates gnupg

echo "Iniciando a instalação"

echo "Passo 1: Executando comando de compatibilidade"

echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list

echo "Passo 2: Importando a chave pública do Google Cloud"

#curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -

echo "Passo 3: Atualizando e instalando a CLI gcloud"

sudo apt-get update && sudo apt-get install google-cloud-cli

echo "Passo 4: Autenticação"

gcloud auth application-default login




