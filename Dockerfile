FROM ubuntu:2104
ENV intellij-version=ideaIC-2021.1.1

RUN apt update && apt install -y wget

RUN wget "https://download-cdn.jetbrains.com/idea/ideaIC-${intellij-version}.tar.gz" && tar xf

RUN tar xf ideaIC-2021.1.1.tar.gz && mv "${intellij-version}" intellij

