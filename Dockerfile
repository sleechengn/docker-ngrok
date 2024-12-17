FROM rockylinux:9.1.20230215
WORKDIR /opt
RUN dnf update -y
RUN dnf install -y wget
RUN wget https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-amd64.tgz

RUN tar -zxvf ngrok-v3-stable-linux-amd64.tgz
RUN mkdir ngrok-stable
RUN mv ngrok ngrok-stable

ADD ./docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh

RUN dnf -y install nginx
ADD ./ui.conf /etc/nginx/conf.d/

RUN dnf -y install nano jq

COPY ./config.sh /
RUN chmod +x /config.sh
COPY ./monitor.sh /
RUN chmod +x /monitor.sh

#install openjdk21
RUN mkdir /opt/java
WORKDIR /opt/java
RUN wget https://download.java.net/openjdk/jdk8u44/ri/openjdk-8u44-linux-x64.tar.gz
RUN tar -zxvf ./openjdk-8u44-linux-x64.tar.gz \
        && rm -rf ./openjdk-8u44-linux-x64.tar.gz
ENV JAVA_HOME=/opt/java/java-se-8u44-ri
RUN ln -s /opt/java/java-se-8u44-ri/bin/java /usr/bin/java
RUN ln -s /opt/java/java-se-8u44-ri/bin/javac /usr/bin/javac

WORKDIR /opt
RUN mkdir -p /opt/bin
RUN mkdir -p /opt/lib
COPY ./mail-cli.jar /opt/bin/
ENV URL=
ENV DOMAIN=
ENV TOKEN=

ENV SMTP_HOST=
ENV SMTP_PORT=
ENV SMTP_USER=
ENV SMTP_PASSWD=
ENV SMTP_FROM=
ENV SMTP_TO=

ENV MSUBJECT=

ENTRYPOINT /docker-entrypoint.sh

RUN echo "alias ll='ls -l -a'" >> /root/.bashrc
RUN echo export LANG="C.UTF-8" >> /root/.bashrc
