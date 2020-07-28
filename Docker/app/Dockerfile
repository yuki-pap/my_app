
FROM ruby:2.6.6


RUN rm /bin/sh && ln -s /bin/bash /bin/sh


RUN apt-get update -qq && apt-get install -y build-essential libpq-dev

RUN apt-get update && apt-get install -y curl apt-transport-https wget && \
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
apt-get update && apt-get install -y yarn

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - && \
apt-get install -y nodejs

RUN apt-get install -y cron

ENV RAILS_ROOT /my_app



RUN mkdir -p $RAILS_ROOT

WORKDIR $RAILS_ROOT


COPY Gemfile Gemfile

COPY Gemfile.lock Gemfile.lock


RUN bundle install


COPY . .

RUN mkdir -p tmp/sockets
