FROM debian:jessie
MAINTAINER Ash Wilson <ash.wilson@rackspace.com>

RUN apt-get update
RUN apt-get install -qy git python-pip nodejs npm python3 python3-venv locales
RUN update-alternatives --install /usr/bin/node node /usr/bin/nodejs 10

RUN adduser --disabled-password --gecos "" --home /home/strider strider
RUN mkdir /home/strider/.strider
RUN chown -R strider:strider /home/strider/.strider

VOLUME /home/strider/.strider
EXPOSE 3000
WORKDIR /home/strider

USER strider
ENV HOME /home/strider
RUN pyvenv /home/strider/py3-env
RUN npm install strider
COPY override/worker.js /home/strider/node_modules/strider/node_modules/strider-custom/worker.js

ENTRYPOINT ["/home/strider/node_modules/.bin/strider"]
