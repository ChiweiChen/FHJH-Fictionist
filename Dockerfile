FROM ruby:2.5

WORKDIR /usr/src/app

RUN apt-get update -yqq
RUN apt-get install -yqq --no-install-recommends nodejs
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt update && apt install yarn
RUN apt install vim -y

RUN git config --global user.name "ChiweiChen"
RUN git config --global user.email chiwei0705@gmail.com

