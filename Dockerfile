FROM ruby:3.2.3

RUN apt-get update -qq && apt-get install -y nodejs sqlite3 libsqlite3-dev

WORKDIR /myrails

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .
RUN rails db:migrate && rails db:seed
