FROM ubuntu:latest

RUN apt-get update && apt-get install -y --no-install-recommends \
		unzip \
		curl \
		wget \
	&& rm -rf /var/lib/apt/lists/*
RUN wget https://github.com/ericchiang/pup/releases/download/v0.3.9/pup_linux_amd64.zip \
    && unzip pup_linux_amd64.zip \
    && chmod +x pup \
    && mv pup /usr/bin
