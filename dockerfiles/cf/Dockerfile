FROM arthurhlt/elpaaso-pipelines:base

RUN curl -L "https://cli.run.pivotal.io/stable?release=linux64-binary" -o cf.tgz \
    && tar -xvf cf.tgz \
    && chmod +x cf \
    && mv cf /usr/bin

RUN curl -L "https://github.com/concourse/autopilot/releases/download/0.0.2/autopilot-linux" -o autopilot \
    && chmod +x autopilot \
    && cf install-plugin ./autopilot

