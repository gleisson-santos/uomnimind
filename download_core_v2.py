import urllib.request

url = "https://s3.setuporion.com.br/setuporion/SetupOrion"
output_file = "SetupOrion_Core"

try:
    with urllib.request.urlopen(url) as response, open(output_file, 'wb') as out_file:
        data = response.read()
        out_file.write(data)
    print(f"Sucesso! Arquivo baixado: {output_file}")
except Exception as e:
    print(f"Erro ao baixar: {e}")
