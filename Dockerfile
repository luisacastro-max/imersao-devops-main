# Use uma imagem base oficial do Python.
# python:3.10-slim é uma boa escolha por ser leve.
FROM python:3.10-slim

# Define o diretório de trabalho dentro do contêiner.
WORKDIR /app

# Copia o arquivo de dependências primeiro para aproveitar o cache do Docker.
# Se o requirements.txt não mudar, esta camada não será reconstruída.
COPY requirements.txt .

# Instala as dependências do projeto.
# --no-cache-dir reduz o tamanho da imagem.
RUN pip install --no-cache-dir -r requirements.txt

# Copia o restante do código da aplicação para o diretório de trabalho.
COPY . .

# Expõe a porta que a aplicação vai usar.
EXPOSE 8000

# Comando para executar a aplicação com Uvicorn.
# --host 0.0.0.0 faz com que a aplicação seja acessível de fora do contêiner.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000","--reload"]