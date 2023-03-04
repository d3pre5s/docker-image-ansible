FROM python:3-alpine

ENV ANSIBLE_FORCE_COLOR="true"
ENV ANSIBLE_HOST_KEY_CHECKING="false" 

RUN apk add --update --no-cache \
    git \
    openssh-client \
    rsync \
    libffi-dev \
    musl-dev 
#    openssl-dev \
#    cargo \

RUN mkdir ~/.ssh && \
    ssh-keyscan -t rsa gitlab.com >> ~/.ssh/known_hosts

RUN apk add --update --no-cache \
    --virtual .build-deps \
    make \
    gcc \
    && pip install --no-cache-dir ansible \
    && apk del .build-deps
RUN apk add yaml-dev

COPY ansible.cfg .
