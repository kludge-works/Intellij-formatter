FROM ubuntu@sha256:86ac87f73641c920fb42cc9612d4fb57b5626b56ea2a19b894d0673fd5b4f2e9 AS downloader
ARG intellijVersion=2021.1.1
WORKDIR /downloads/

# ENV caCertificatesVersion=20210119build1
# ENV wgetVersion=1.21-1ubuntu3

RUN apt-get update && \
    apt-get install wget ca-certificates \
    -y --no-install-recommends && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    wget --progress=dot:giga "https://download-cdn.jetbrains.com/idea/ideaIC-${intellijVersion}.tar.gz" && \
    tar xvf "ideaIC-${intellijVersion}.tar.gz" && \
    rm "ideaIC-${intellijVersion}.tar.gz"  && \
    mv idea-* intellij

FROM ubuntu@sha256:86ac87f73641c920fb42cc9612d4fb57b5626b56ea2a19b894d0673fd5b4f2e9
COPY --from=downloader /downloads/intellij /opt/intellij

RUN mkdir -p /home/headless && \
    groupadd -r headless &&\
    useradd -r -g headless -d /home/app -s /sbin/nologin -c "Docker image user" headless

# Set the home directory to our app user's home.
ENV HOME=/home/headless

# Chown all the files to the app user.
RUN chown -R headless:headless /opt/intellij

# Change to the app user.
USER headless
