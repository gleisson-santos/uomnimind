# 🧠 Uomnimind - Automação Inteligente de Infraestrutura

**Uomnimind** é um conjunto de ferramentas e scripts de automação projetado para provisionar, configurar e gerenciar ambientes de servidores VPS, com foco específico em integrações seguras via VPN (Fortinet) e execução de robôs de dados (Python/Selenium).

Este repositório serve como um "Core" para implantação rápida de ambientes de extração de dados e automação de processos.

![Status](https://img.shields.io/badge/Status-Active-success)
![Python](https://img.shields.io/badge/Python-3.x-blue)
![Shell](https://img.shields.io/badge/Shell-Bash-yellow)

## 🎯 Objetivo

Facilitar o deploy de **Robôs de Automação** em servidores Linux (Ubuntu), garantindo que todas as dependências (VPN, Drivers, Browsers) sejam instaladas e configuradas corretamente com intervenção humana mínima.

## 📂 Estrutura do Projeto

*   **`SetupOrion_Core`**: Binário/Core principal do sistema de automação (baixado via script).
*   **`download_core.py`**: Script Python para baixar a versão mais recente do Core direto do servidor de distribuição.
*   **`GUIA_VPS.md`**: Documentação passo-a-passo para configuração manual/assistida de uma nova VPS.
*   **`run_job.sh`**: Wrapper Shell Script para gerenciar a execução de jobs (conecta VPN -> executa tarefa -> desconecta).
*   **`vpn_config`**: Template de configuração para conexão segura via OpenFortiVPN.

## 🚀 Funcionalidades

1.  **Instalação de Dependências**: Scripts para instalar Python, Pip, Chrome Stable, OpenFortiVPN e libs gráficas (Xvfb) em Ubuntu.
2.  **Gestão de VPN**: Automação da conexão via `openfortivpn` com tratamento de certificados trusted-cert.
3.  **Agendamento de Tarefas**: Instruções claras para configuração de Cron Jobs (ex: execução diária às 06:30).
4.  **Bootstrapping**: Download automático dos artefatos mais recentes do sistema (SetupOrion).

## 🛠️ Como Utilizar

### 1. Preparação da VPS
Siga o **[GUIA_VPS.md](./GUIA_VPS.md)** para preparar seu servidor Ubuntu 22.04/24.04.

### 2. Download do Core
Execute o script de download para obter a versão mais atual do executor:
```bash
python3 download_core.py
```

### 3. Configuração da VPN
Edite o arquivo `vpn_config` com suas credenciais:
```ini
host = vpn.exemplo.com
port = 443
username = seu_usuario
password = sua_senha
# trusted-cert será gerado na primeira conexão
```

### 4. Execução Manual
Para testar o fluxo completo (VPN + Robô):
```bash
chmod +x run_job.sh
./run_job.sh
```

## 📦 Requisitos do Sistema

*   **SO**: Ubuntu Linux 22.04 LTS ou superior.
*   **Rede**: Acesso liberado para saída HTTPS e porta da VPN.
*   **Python**: 3.10+.

## 🤝 Contribuição

Sinta-se à vontade para enviar PRs com melhorias nos scripts de instalação ou novas integrações de VPN.

## 📝 Licença

Proprietário. Todos os direitos reservados.
