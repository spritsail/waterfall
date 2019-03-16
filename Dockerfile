FROM spritsail/alpine:3.8

ARG BUNGEECORD_BUILD=1398

LABEL maintainer="Spritsail <bungeecord@spritsail.io>" \
      org.label-schema.vendor="Spritsail" \
      org.label-schema.name="Bungeecord" \
      org.label-schema.url="https://www.spigotmc.org/wiki/bungeecord/" \
      org.label-schema.description="A minecraft server proxy" \
      org.label-schema.version=${BUNGEECORD_BUILD} \
      io.spritsail.version.bungeecord=${BUNGEECORD_BUILD}

RUN apk --no-cache add openjdk8-jre && \
    wget -O /bungeecord.jar \
        https://ci.md-5.net/job/BungeeCord/${BUNGEECORD_BUILD}/artifact/bootstrap/target/BungeeCord.jar

WORKDIR /config
VOLUME /config

CMD [ "java", "-jar", "/bungeecord.jar" ]
