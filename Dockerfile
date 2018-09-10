FROM elixir:1.7.3-alpine
LABEL MAINTAINER="Kyle A. Matheny <kylematheny@pm.me>"

SHELL ["sh", "-c"]

RUN apk add --update --upgrade \
    curl \
    git \
    nodejs

# ENV LANG=en_US.UTF-8 \
#     LANGUAGE=en_US:en \
#     LC_ALL=en_US.UTF-8 \
#     DEBIAN_FRONTEND=noninteractive

# update and install some software requirements
# RUN \
#     apt-get update --fix-missing \
#     && apt-get upgrade -y \
#     && apt-get install -y \
#         curl \
#         git \
#         make \
#         wget \
#         inotify-tools

# *-*-*-*-*-* Phoenix *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-

ARG PHOENIX_VERSION=1.3.4
# install Phoenix from source with some previous requirements
RUN \
    git clone --branch v$PHOENIX_VERSION https://github.com/phoenixframework/phoenix.git \
    && cd phoenix \
    && mix local.hex --force \
    && mix local.rebar --force \
    && mix do deps.get, compile \
    && mix archive.install https://github.com/phoenixframework/archives/raw/master/phoenix_new.ez --force

# *-*-*-*-*-* NodeJS *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*

# ARG NODE_VERSION=6.2.2
# RUN \
#     curl -SLO "http://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.gz" \
#     && tar -xzf "node-v$NODE_VERSION-linux-x64.tar.gz" -C /usr/local --strip-components=1 \
#     && rm "node-v$NODE_VERSION-linux-x64.tar.gz"

# *-*-*-*-*-* Health Check *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*

HEALTHCHECK CMD curl localhost:4000 || exit 1

# *-*-*-*-*-* Labels *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*

LABEL com.1986.app="phoenix" \
      com.1986.version="${PHOENIX_VERSION}" \
      com.1986.component.elixir.version="${ELIXIR_VERSION}" \
      com.1986.component.nodejs.version="${NODE_VERSION}" \
      com.1986.component.erlang.version="${ERLANG_VERSION}"

# *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-

WORKDIR /code
VOLUME ["/code"]
EXPOSE 4000

ENTRYPOINT ["mix"]
CMD ["phoenix.server"]
