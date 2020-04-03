FROM ruby:2.3.0

ENV APP_ENV production
ENV RACK_ENV production

WORKDIR /app

ADD Gemfile /app/Gemfile
ADD Gemfile.lock /app/Gemfile.lock
RUN bundle install --system

ADD . /app

EXPOSE 4567

CMD ["rake", "server"]