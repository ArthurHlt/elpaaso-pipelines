FROM ubuntu:latest

RUN apt-get update && apt-get install -y --no-install-recommends \
		unzip \
		curl \
		wget \
		tar \
		ca-certificates
RUN curl -L https://github.com/ericchiang/pup/releases/download/v0.3.9/pup_linux_amd64.zip -o pup_linux_amd64.zip \
    && unzip pup_linux_amd64.zip \
    && chmod +x pup \
    && mv pup /usr/bin

RUN curl -L https://github.com/stedolan/jq/releases/download/jq-1.5/jq-linux64 -o jq \
    && chmod +x jq \
    && mv jq /usr/bin
