# Based on Phoenix Image by Marcelo Gonçalves <marcelocg@gmail.com>
FROM ubuntu:latest
MAINTAINER Kyle A. Matheny <kamathen@us.ibm.com>

# Elixir requires UTF-8
RUN locale-gen en_US.UTF-8

ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8

# update and install some software requirements
RUN \
    apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y \
        curl \
        git \
        make \
        wget \
        inotify-tools

# *-*-*-*-*-* Erlang *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*

WORKDIR /

# download and install Erlang package
RUN \
    wget http://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb \
    && dpkg -i erlang-solutions_1.0_all.deb \
    && rm erlang-*.deb \
    && apt-get update

# install erlang from package
RUN \
    apt-get install -y \
        erlang \
        erlang-inets \
        erlang-ssl

# *-*-*-*-*-* Elixir *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*

ARG ELIXIR_VERSION=1.3.0
# install elixir from source
RUN \
    git clone --branch v$ELIXIR_VERSION https://github.com/elixir-lang/elixir.git \
    && cd elixir \
    && make

ENV PATH $PATH:/elixir/bin

# *-*-*-*-*-* Phoenix *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-

ARG PHOENIX_VERSION=1.2.0
# install Phoenix from source with some previous requirements
RUN \
    git clone --branch v$PHOENIX_VERSION https://github.com/phoenixframework/phoenix.git \
    && cd phoenix \
    && mix local.hex --force \
    && mix local.rebar --force \
    && mix do deps.get, compile \
    && mix archive.install https://github.com/phoenixframework/archives/raw/master/phoenix_new.ez --force

# *-*-*-*-*-* NodeJS *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*

ARG NODE_VERSION=6.2.2
RUN \
    curl -SLO "http://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.gz" \
    && tar -xzf "node-v$NODE_VERSION-linux-x64.tar.gz" -C /usr/local --strip-components=1 \
    && rm "node-v$NODE_VERSION-linux-x64.tar.gz"

WORKDIR /code

ENTRYPOINT ["mix"]

CMD ["phoenix.server"]
