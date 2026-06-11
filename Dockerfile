FROM node:20-bookworm-slim

RUN apt-get update && apt-get install -y \
    chromium \
    fonts-liberation \
    libasound2 \
    libatk-bridge2.0-0 \
    libatk1.0-0 \
    libcups2 \
    libdbus-1-3 \
    libdrm2 \
    libgbm1 \
    libgtk-3-0 \
    libnspr4 \
    libnss3 \
    libx11-xcb1 \
    libxcomposite1 \
    libxdamage1 \
    libxfixes3 \
    libxrandr2 \
    libxss1 \
    libxtst6 \
    xdg-utils \
    curl \
    git \
    --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

# Install puppeteer-core globally so it's available in /home/container
RUN npm install -g puppeteer-core \
    && mkdir -p /home/container/node_modules \
    && ln -s /usr/local/lib/node_modules/puppeteer-core /home/container/node_modules/puppeteer-core

ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true
ENV CHROMIUM_PATH=/usr/bin/chromium

WORKDIR /home/container

ENTRYPOINT ["/bin/bash", "-c"]
CMD ["node /home/container/runner.js"]
