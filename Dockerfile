FROM rgibert/openjdk-jre
MAINTAINER Richard Gibert <richard@gibert.ca>
ENV MINECRAFT_HOME=/var/lib/minecraft
ENV MINECRAFT_USER=minecraft
ENV MINECRAFT_MIRROR='https://s3.amazonaws.com/Minecraft.Download/versions'
ENV MINECRAFT_VER=1.8.8
RUN apk-install openssl && \
    mkdir -p /usr/local/bin ${MINECRAFT_HOME} && \
    wget -O /usr/local/bin/minecraft_server.jar ${MINECRAFT_MIRROR}/${MINECRAFT_VER}/minecraft_server.${MINECRAFT_VER}.jar && \
    echo "${MINECRAFT_VER}" > ${MINECRAFT_HOME}/version.txt && \
    echo 'eula=true' > ${MINECRAFT_HOME}/eula.txt
COPY usr/local/bin/entrypoint /usr/local/bin/entrypoint
RUN adduser -s /bin/false -D ${MINECRAFT_USER} && \
    chown -R ${MINECRAFT_USER}:${MINECRAFT_USER} ${MINECRAFT_HOME}
VOLUME ${MINECRAFT_HOME}
EXPOSE 25565
ENTRYPOINT [ "/usr/local/bin/entrypoint" ]
CMD [ "minecraft" ]

