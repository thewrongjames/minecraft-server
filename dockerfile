FROM eclipse-temurin:17

ARG PAPER_VERSION
ARG PAPER_BUILD_NUMBER

RUN useradd \
  --base-dir /opt \
  --create-home \
  --shell /bin/bash \
  minecraft
USER minecraft:minecraft

WORKDIR /opt/minecraft

COPY scripts/entrypoint.sh /opt/minecraft

RUN curl https://api.papermc.io/v2/projects/paper/versions/${PAPER_VERSION}/builds/${PAPER_BUILD_NUMBER}/downloads/paper-${PAPER_VERSION}-${PAPER_BUILD_NUMBER}.jar -o paper.jar

WORKDIR /opt/minecraft/server-files

EXPOSE 25565

# The RAM environment variable must be set to run the container.
ENTRYPOINT ["/bin/sh", "/opt/minecraft/entrypoint.sh"]
  