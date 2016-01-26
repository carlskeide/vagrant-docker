FROM phusion/baseimage:latest

MAINTAINER Carl Skeide "carl@skeide.se"

# System
ENV VAGRANT_HOME "/home/vagrant"
ENV VAGRANT_USER "vagrant"
ENV VAGRANT_PASS "vagrant"
ENV DEBIAN_FRONTEND noninteractive

# Packages
RUN apt-get -qq update &&\
    apt-get -qq install -y --no-install-recommends \
        git-core nano vim curl wget \
        python-dev python-setuptools gcc make \
        libffi-dev libssl-dev libxml2-dev libxslt-dev libicu-dev libjpeg-dev \
        libmemcached-dev libmysqlclient-dev \
        ruby ruby-dev &&\
    apt-get clean &&\
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN easy_install pip &&\
    pip install --quiet --upgrade --no-cache-dir \
        pyopenssl ndg-httpsclient pyasn1 \
        virtualenv

RUN curl -o /usr/bin/gosu -fsSL "https://github.com/tianon/gosu/releases/download/1.7/gosu-$(dpkg --print-architecture)" &&\
    chmod +x /usr/bin/gosu

# User
ADD skel /etc/skel
RUN useradd \
        -md ${VAGRANT_HOME} \
        -G docker_env \
        -s /bin/bash \
        ${VAGRANT_USER} &&\
    echo "${VAGRANT_USER}:${VAGRANT_PASS}" | chpasswd

# SSH
RUN echo "linux" > /etc/container_environment/TERM &&\
    rm -f /etc/service/sshd/down &&\
    /etc/my_init.d/00_regen_ssh_host_keys.sh
