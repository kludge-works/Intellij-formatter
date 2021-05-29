FROM ubuntu:2104 AS downloader
ENV intellij-version=ideaIC-2021.1.1
WORKDIR /downloads/

RUN apt update && apt install -y wget
RUN wget "https://download-cdn.jetbrains.com/idea/ideaIC-${intellij-version}.tar.gz" && tar xf
RUN tar xf ideaIC-2021.1.1.tar.gz && mv "${intellij-version}" intellij


FROM ubuntu:2104
COPY --from=downloader /downloads/intellij .