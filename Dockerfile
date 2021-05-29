FROM ubuntu:21.04 AS downloader
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

FROM ubuntu:21.04
COPY --from=downloader /downloads/intellij /opt/intellij