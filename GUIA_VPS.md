# GUIA DE INSTALAÇÃO: VPS + PYTHON + VPN (Fortinet)

Este guia assume que você alugou uma VPS com **Ubuntu 22.04** ou **24.04**.

## 1. Acessando a VPS
Abra seu terminal (ou CMD) e digite:
`ssh root@ip-da-sua-vps`
(Digite a senha que a provedora te enviou).

## 2. Instalando as Ferramentas Básicas
Copie e cole este bloco de comandos no terminal da VPS para instalar tudo de uma vez:

```bash
# Atualizar sistema
apt update && apt upgrade -y

# Instalar Python, Pip, Unzip e a VPN (openfortivpn)
apt install -y python3-pip unzip openfortivpn xvfb libxi6 libgconf-2-4

# Instalar Google Chrome (Estável)
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
apt install -y ./google-chrome-stable_current_amd64.deb

# Instalar Bibliotecas Python
pip3 install selenium webdriver-manager pandas openpyxl
# (Adicione outras bibliotecas que seu script usa aqui)
```

## 3. Configurando o Projeto
1. Crie uma pasta: `mkdir /root/meu_projeto`
2. Envie seus arquivos do computador para a VPS (pode usar um programa como **FileZilla** ou comando `scp`).
   - Arquivos para enviar:
     - `seu_script.py`
     - `vpn_config` (Edite este arquivo com seus dados antes de enviar!)
     - `run_job.sh`

## 4. Testando a VPN Manualmente (Importante!)
Na primeira vez, rode a VPN manualmente para pegar o "trusted-cert" (Certificado de Segurança).

No terminal da VPS:
`openfortivpn -c /root/meu_projeto/vpn_config`

*Se der erro de certificado*, ele vai mostrar uma linha assim:
`ERROR:  Gateway certificate validation failed...`
`... trusted-cert = c44a7b...`

Copie esse código hash, abra o arquivo `vpn_config` e adicione uma linha:
`trusted-cert = c44a7b...`

## 5. Configurando o Script de Automação
Dê permissão de execução para o script:
`chmod +x /root/meu_projeto/run_job.sh`

Teste rodando ele uma vez na mão:
`./root/meu_projeto/run_job.sh`
(Verifique se criou o arquivo `execucao.log` e se os dados foram baixados).

## 6. Agendando para 06:30 da manhã (Cron)
1. Digite `crontab -e`
2. Escolha o editor (digite 1 para nano).
3. Vá até o final do arquivo e cole esta linha:

`30 06 * * * /root/meu_projeto/run_job.sh`

4. Aperte `Ctrl+O` (Enter) para salvar e `Ctrl+X` para sair.

**PRONTO!** Seu robô agora roda todo dia às 06:30, conecta na VPN, baixa os dados e desliga.
