FROM rgibert/openjdk-jre:latest
MAINTAINER Richard Gibert <richard@gibert.ca>
ENV MINECRAFT_HOME=/var/lib/minecraft MINECRAFT_USER=minecraft MINECRAFT_MIRROR='https://s3.amazonaws.com/Minecraft.Download/versions'
ENV MINECRAFT_VER=1.8.8
COPY usr/local/bin/entrypoint /usr/local/bin/entrypoint
RUN \
    apt-get update && \
    apt-get install -y \
        wget \
        && \
    mkdir -p /usr/local/bin ${MINECRAFT_HOME} && \
    wget -O /usr/local/bin/minecraft_server.jar ${MINECRAFT_MIRROR}/${MINECRAFT_VER}/minecraft_server.${MINECRAFT_VER}.jar && \
    echo "${MINECRAFT_VER}" > ${MINECRAFT_HOME}/version.txt && \
    echo 'eula=true' > ${MINECRAFT_HOME}/eula.txt \
    adduser -s /bin/false -D ${MINECRAFT_USER} && \
    chown -R ${MINECRAFT_USER}:${MINECRAFT_USER} ${MINECRAFT_HOME} && \
    apt-get remove wget && \
    rm -rf /var/lib/apt/lists/*
VOLUME ${MINECRAFT_HOME}
EXPOSE 25565
ENTRYPOINT [ "/usr/local/bin/entrypoint" ]
CMD [ "minecraft" ]

