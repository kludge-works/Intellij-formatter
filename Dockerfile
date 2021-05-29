FROM ubuntu

RUN apt update && apt install -y wget

RUN wget https://download-cdn.jetbrains.com/idea/ideaIC-2021.1.1.tar.gz && tar xf

RUN tar xf ideaIC-2021.1.1.tar.gz && mv ideaIC-2021.1.1 intellij

