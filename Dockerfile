FROM ubuntu@sha256:42d5c74d24685935e6167271ebb74c5898c5adf273dae80a82f9e39e8ae0dab4 AS downloader
ARG intellijVersion=2021.1.1
WORKDIR /downloads/

ENV caCertificatesVersion=20210119build1
ENV wgetVersion=1.21-1ubuntu3

RUN apt-get update && \
    apt-get install wget=${wgetVersion} ca-certificates=${caCertificatesVersion} \
    -y --no-install-recommends && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    wget --progress=dot:giga "https://download-cdn.jetbrains.com/idea/ideaIC-${intellijVersion}.tar.gz" && \
    tar xvf "ideaIC-${intellijVersion}.tar.gz" && \
    rm "ideaIC-${intellijVersion}.tar.gz"  && \
    mv idea-* intellij

FROM ubuntu@sha256:42d5c74d24685935e6167271ebb74c5898c5adf273dae80a82f9e39e8ae0dab4
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
