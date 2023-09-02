FROM ruby:2.7-slim-bullseye


RUN apt-get update

# General dependencies
RUN apt-get install -y wget make gcc iputils-ping

# Install Steamcmd dependencies
RUN apt-get install -y lib32gcc-s1

# Sandstorm server won't run under root
RUN useradd -ms /bin/bash sandstorm

USER sandstorm
WORKDIR /home/sandstorm

COPY --chown=sandstorm:sandstorm . .

RUN wget https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz
RUN mv steamcmd_linux.tar.gz steamcmd/installation/
RUN cd steamcmd/installation && tar -xvf steamcmd_linux.tar.gz
RUN rm steamcmd/installation/steamcmd_linux.tar.gz

# Add config for docker container

RUN cp config/config.toml.docker config/config.toml

RUN gem install bundler:1.17.3

#WORKDIR /home/sandstorm
#RUN steamcmd/installation/steamcmd.sh +force_install_dir /home/sandstorm/sandstorm-server +login anonymous +app_update 581330 +quit

WORKDIR /home/sandstorm/admin-interface

RUN /bin/bash -c bundle

WORKDIR /home/sandstorm

CMD ./docker_start.sh
