FROM node:16.15.1-bullseye-slim

RUN apt update --fix-missing && \
    apt upgrade -y
RUN apt install -y \
      git \
      curl \
      vim
RUN curl -L https://foundry.paradigm.xyz | bash
RUN /root/.foundry/bin/foundryup
