FROM ruby:2.3.1
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
ENV APP_ROOT /myapp

# Rails App
RUN mkdir -p $APP_ROOT
WORKDIR $APP_ROOT
COPY Gemfile $APP_ROOT/Gemfile
COPY Gemfile.lock $APP_ROOT/Gemfile.lock
RUN bundle install
COPY . $APP_ROOT
RUN mkdir -p $APP_ROOT/tmp/sockets

# Expose volumes to frontend
VOLUME $APP_ROOT/public
VOLUME $APP_ROOT/tmp

# Start Server
CMD bundle exec puma

