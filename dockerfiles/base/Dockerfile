FROM ubuntu:latest

RUN apt-get update && apt-get install -y --no-install-recommends \
		unzip \
		curl \
		wget \
		tar \
		ca-certificates \
		jq
RUN curl -L https://github.com/ericchiang/pup/releases/download/v0.3.9/pup_linux_amd64.zip -o pup_linux_amd64.zip \
    && unzip pup_linux_amd64.zip \
    && chmod +x pup \
    && mv pup /usr/bin

RUN curl -L https://github.com/ArthurHlt/notifslack/releases/download/v1.0.0/notifslack_linux_amd64 -o notifslack \
    && chmod +x notifslack \
    && mv notifslack /usr/bin

RUN curl -L https://github.com/ArthurHlt/echo-colors/releases/download/v1.0.0/echoc_linux_amd64 -o echoc \
    && chmod +x echoc \
    && mv echoc /usr/bin
