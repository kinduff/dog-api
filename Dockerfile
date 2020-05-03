FROM ruby:2.6.6

ENV APP_ENV production
ENV RACK_ENV production

WORKDIR /app

ADD Gemfile /app/Gemfile
ADD Gemfile.lock /app/Gemfile.lock

ENV LANG=C.UTF-8 \
    BUNDLE_JOBS=4 \
    BUNDLE_RETRY=3

ENV BUNDLER_WITHOUT development test

RUN bundle install

ADD . /app

EXPOSE 4567

CMD ["bundle", "exec", "rackup", "--host", "0.0.0.0", "-p", "4567"]