FROM ruby:2.6.5-alpine3.9

RUN apk update
RUN apk upgrade

RUN apk add --no-cache \
      bash git vim openssh openssl yarn sudo su-exec shadow tzdata \
      mysql-client mysql-dev\
      build-base libxml2-dev libxslt-dev

ARG UID=1000
ARG GID=1000

RUN mkdir /var/mail
RUN groupadd -g $GID devel
RUN useradd -u $UID -g devel -m devel
RUN echo "devel ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# install rails
WORKDIR /tmp
COPY init/Gemfile /tmp/Gemfile
COPY init/Gemfile.lock /tmp/Gemfile.lock
RUN bundle install

COPY ./apps /apps

RUN apk add --no-cache openssl

WORKDIR /apps

USER devel

RUN openssl rand -hex 64 > /home/devel/.secret_key_base
RUN echo $'export SECRET_KEY_BASE=$(cat /home/devel/.secret_key_base)' \
  >> /home/devel/.bashrc

COPY init/application_template/ /tmp/application_template/
