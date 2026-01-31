#!/bin/bash

# Cores
GREEN='\033[0;32m'
NC='\033[0m'

echo -e "${GREEN}--- Iniciando Instalação do UomniMind Stack ---${NC}"

# 1. Criar rede externa
echo "Criando rede Docker 'proxy'..."
docker network create proxy || true

# 2. Configurar .env
if [ ! -f .env ]; then
    echo "Copiando .env.example para .env..."
    cp .env.example .env
    echo "POR FAVOR, EDITE O ARQUIVO .env COM SEU DOMÍNIO E EMAIL ANTES DE CONTINUAR."
    exit 1
fi

# 3. Subir Core
echo "Subindo Traefik..."
cd core/traefik
touch acme.json && chmod 600 acme.json
docker compose up -d
cd ../..

echo "Subindo Portainer..."
cd core/portainer
docker compose up -d
cd ../..

echo -e "${GREEN}--- Core Instalado! ---${NC}"
echo "Acesse o Traefik em: https://traefik.seu-dominio.com"
echo "Acesse o Portainer em: https://portainer.seu-dominio.com"
