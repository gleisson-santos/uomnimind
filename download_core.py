import requests

url = "https://s3.setuporion.com.br/setuporion/SetupOrion"
output_file = "SetupOrion_Core"

try:
    response = requests.get(url)
    response.raise_for_status()
    with open(output_file, 'wb') as f:
        f.write(response.content)
    print(f"Sucesso! Arquivo baixado: {output_file}")
except Exception as e:
    print(f"Erro ao baixar: {e}")
