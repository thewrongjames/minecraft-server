FROM eclipse-temurin:17

# ARG RAM
# ARG PAPER_VERSION
# ARG PAPER_BUILD_NUMBER

ENV RAM=3G
ENV PAPER_VERSION=1.19.4
ENV PAPER_BUILD_NUMBER=466

WORKDIR /server-jar

RUN curl https://api.papermc.io/v2/projects/paper/versions/${PAPER_VERSION}/builds/466/downloads/paper-${PAPER_VERSION}-${PAPER_BUILD_NUMBER}.jar -o paper.jar

WORKDIR /server-files

EXPOSE 25565

ENTRYPOINT java -Xms$RAM -Xmx$RAM -jar ../server-jar/paper.jar --nogui   

