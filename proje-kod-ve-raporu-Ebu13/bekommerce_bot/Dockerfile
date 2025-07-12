FROM python:3.9-slim

WORKDIR /app

# Sistem bağımlılıkları
RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    libpq-dev \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

# Gereksinimler dosyasını kopyala
COPY requirements.txt /app/requirements.txt

# PyTorch CPU için özel index veriyoruz
RUN pip install --no-cache-dir --upgrade pip \
 && pip install --no-cache-dir -r requirements.txt \
     --extra-index-url https://download.pytorch.org/whl/cpu \
     --retries 5 \
     --timeout 60

# Uygulama dosyalarını ve modelleri kopyala
COPY . /app
COPY models/ /app/models/

EXPOSE 5000

CMD ["python", "app.py"]
