FROM elixir:1.3.3-slim
MAINTAINER Kyle A. Matheny <kamathen@us.ibm.com>

RUN \
  apt-get update \
  && apt-get install -y git curl \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ARG PHOENIX_VERSION=1.2.1
# install Phoenix from source with some previous requirements
RUN \
    git clone --branch v$PHOENIX_VERSION https://github.com/phoenixframework/phoenix.git \
    && cd phoenix \
    && mix local.hex --force \
    && mix local.rebar --force \
    && mix do deps.get, compile \
    && mix archive.install https://github.com/phoenixframework/archives/raw/master/phoenix_new.ez --force

# *-*-*-*-*-* NodeJS *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*

ARG NODE_VERSION=6.7.0
RUN \
    curl -SLO "http://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.gz" \
    && tar -xzf "node-v$NODE_VERSION-linux-x64.tar.gz" -C /usr/local --strip-components=1 \
    && rm "node-v$NODE_VERSION-linux-x64.tar.gz"

HEALTHCHECK CMD curl localhost:4000 || exit 1

LABEL com.1986.app="phoenix" \
      com.1986.version="${PHOENIX_VERSION}" \
      com.1986.component.elixir.version="${ELIXIR_VERSION}" \
      com.1986.component.nodejs.version="${NODE_VERSION}"

# *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-

WORKDIR /code
VOLUME ["/code"]
EXPOSE 4000

ENTRYPOINT ["mix"]
CMD ["phoenix.server"]
