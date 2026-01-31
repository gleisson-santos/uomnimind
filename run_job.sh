#!/bin/bash

# Define os caminhos
DIR_PROJETO="/root/meu_projeto"
ARQUIVO_CONFIG="$DIR_PROJETO/vpn_config"
SCRIPT_PYTHON="$DIR_PROJETO/seu_script.py"
LOG_FILE="$DIR_PROJETO/execucao.log"

echo "--- Iniciando Job: $(date) ---" >> $LOG_FILE

# 1. Iniciar a VPN em background (modo daemon)
echo "Conectando VPN..." >> $LOG_FILE
# sudo openfortivpn -c $ARQUIVO_CONFIG > /dev/null 2>&1 &
# Usamos 'nohup' ou rodamos direto se for root. Vamos assumir root na VPS.
openfortivpn -c $ARQUIVO_CONFIG --persistent=0 > /var/log/vpn_output.log 2>&1 &
VPN_PID=$!

# 2. Esperar a conexão estabilizar (10 a 15 segundos)
sleep 15

# Verifica se conectou (pingando o gateway ou um IP interno)
# Opcional: Adicionar verificação aqui.

# 3. Rodar o Script Python
echo "Rodando script Python..." >> $LOG_FILE
# Ativar venv se necessario: source venv/bin/activate
python3 $SCRIPT_PYTHON >> $LOG_FILE 2>&1

# 4. Matar a VPN
echo "Encerrando VPN..." >> $LOG_FILE
kill $VPN_PID

echo "--- Fim do Job: $(date) ---" >> $LOG_FILE
echo "---------------------------------" >> $LOG_FILE
