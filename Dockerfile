# ✅ Updated & Supported Base Image
FROM python:3.10-slim-bullseye

# 🧹 Reduce interaction & avoid prompts during install
ENV DEBIAN_FRONTEND=noninteractive

# ✅ System Packages Install (combined for faster layers)
RUN apt update && \
    apt upgrade -y && \
    apt install -y \
        git \
        curl \
        wget \
        bash \
        neofetch \
        ffmpeg \
        python3-pip \
        software-properties-common && \
    apt clean && rm -rf /var/lib/apt/lists/*

# ✅ Python requirements
COPY requirements.txt .
RUN pip install --upgrade pip wheel
RUN pip install --no-cache-dir -r requirements.txt

# ✅ App setup
WORKDIR /app
COPY . .

# ✅ Expose for Render/Flask
EXPOSE 8000

# ✅ Start Flask + custom script
CMD flask run -h 0.0.0.0 -p 8000 & python3 -m devgagan
