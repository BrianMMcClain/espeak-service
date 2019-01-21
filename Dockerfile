FROM ruby:2.5.3-slim-stretch

ADD . /app
WORKDIR /app

RUN apt-get update && apt-get install -y \
    espeak \
    lame

RUN bundle install

ENTRYPOINT ["bundle", "exec", "ruby", "server.rb"]