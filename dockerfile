FROM eclipse-temurin:17

ARG PAPER_VERSION
ARG PAPER_BUILD_NUMBER

WORKDIR /opt

RUN curl https://api.papermc.io/v2/projects/paper/versions/${PAPER_VERSION}/builds/${PAPER_BUILD_NUMBER}/downloads/paper-${PAPER_VERSION}-${PAPER_BUILD_NUMBER}.jar -o paper.jar

WORKDIR /opt/server-files

EXPOSE 25565

# The RAM environment variable must be set to run the container.
ENTRYPOINT java -Xms${RAM} -Xmx${RAM} -jar /opt/paper.jar --nogui

