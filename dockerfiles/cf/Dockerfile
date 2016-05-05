FROM arthurhlt/elpaaso-pipelines:base

RUN curl -L "https://cli.run.pivotal.io/stable?release=linux64-binary" -o cf.tgz \
    && tar -xvf cf.tgz \
    && chmod +x cf \
    && mv cf /usr/bin
