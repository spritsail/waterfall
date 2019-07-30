ARG WATERFALL_COMMIT=9cdf9dd

FROM spritsail/alpine:3.10 AS compile

ARG WATERFALL_COMMIT

WORKDIR /build

RUN apk --no-cache add bash git jq maven nss openjdk8 && \
    \
    git config --global user.name docker-build && \
    git config --global user.email docker-build@spritsail.io && \
    git init -q && \
    git remote add origin https://github.com/PaperMC/Waterfall.git && \
    git fetch --no-tags origin +refs/heads/master && \
    git reset --hard -q ${WATERFALL_COMMIT} && \
    git submodule update --init --recursive && \
    \
    # Apply custom patches here
    wget -O- https://patch-diff.githubusercontent.com/raw/SpigotMC/BungeeCord/pull/2615.patch \
        > BungeeCord-Patches/9999-Fire-ServerChatEvent-for-server-sent-chat-messages.patch && \
    \
    ./waterfall build

FROM spritsail/alpine:3.10

ARG WATERFALL_COMMIT

LABEL maintainer="Spritsail <waterfall@spritsail.io>" \
      org.label-schema.vendor="Spritsail" \
      org.label-schema.name="Waterfall" \
      org.label-schema.url="https://github.com/PaperMC/Waterfall" \
      org.label-schema.description="BungeeCord fork that aims to improve performance and stability" \
      org.label-schema.version=${WATERFALL_COMMIT} \
      io.spritsail.version.waterfall=${WATERFALL_COMMIT}

COPY --from=compile /build/Waterfall-Proxy/bootstrap/target/Waterfall.jar /waterfall.jar
RUN apk --no-cache add openjdk8-jre nss

WORKDIR /config
VOLUME /config

CMD [ "java", "-jar", "/waterfall.jar" ]
