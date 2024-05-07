FROM ruby:3.3.1
ENV RAILS_ENV production
ENV RAILS_SERVE_STATIC_FILES true
ENV RAILS_LOG_TO_STDOUT true
CMD ["bundle", "exec", "puma"]
RUN mkdir /app
WORKDIR /app
RUN apt-get update && apt-get install -y build-essential libpq-dev curl software-properties-common
RUN adduser --system --no-create-home --home /app puma
RUN gem update bundler
ADD Gemfile Gemfile.lock /app/
RUN bundle install --without development test
ADD . /app
RUN SECRET_KEY_BASE=doesnotmatter bundle exec rails assets:precompile
RUN chown -R puma /app/tmp /app/db/schema.rb
USER puma
