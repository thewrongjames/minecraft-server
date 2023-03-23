FROM eclipse-temurin:17

ARG PAPER_VERSION
ARG PAPER_BUILD_NUMBER

RUN useradd \
  --base-dir /opt/minecraft \
  --create-home \
  --shell /bin/bash \
  minecraft
RUN chown minecraft:minecraft /opt/minecraft
USER minecraft:minecraft

WORKDIR /opt/minecraft

RUN curl https://api.papermc.io/v2/projects/paper/versions/${PAPER_VERSION}/builds/${PAPER_BUILD_NUMBER}/downloads/paper-${PAPER_VERSION}-${PAPER_BUILD_NUMBER}.jar -o paper.jar

WORKDIR /opt/minecraft/server-files

EXPOSE 25565

# The RAM environment variable must be set to run the container.
ENTRYPOINT java -Xms${RAM} -Xmx${RAM} -jar /opt/minecraft/paper.jar --nogui

