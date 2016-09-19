FROM xenolog/u1604
MAINTAINER Sergey Vasilenko <stalk@makeworld.ru>
RUN gpg --keyserver keyserver.ubuntu.com --recv-keys F9C59A45
RUN gpg -a --export F9C59A45 | apt-key add -
RUN LANG=en_US.UTF-8 add-apt-repository -y -u ppa:cz.nic-labs/bird
RUN apt-get update -y
RUN echo manual > /etc/init/bird.override
RUN echo manual > /etc/init/bird6.override
RUN TERM=screen apt-get install -y bird