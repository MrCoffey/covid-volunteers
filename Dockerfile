FROM ruby:2.6.3-alpine3.10

ENV RAILS_ENV=production

COPY . /app
WORKDIR /app

RUN apk add --update \
  git \
  build-base \
  ca-certificates \
  libxml2 \
  libxslt \
  gcc \
  ruby-dev \
  nodejs \
  imagemagick \
  postgresql-dev \
  postgresql \
  yarn \
  && rm -rf /var/cache/apk/* \
  && gem install bundler --no-document

RUN bundle lock --add-platform x86-mingw32 x86-mswin32 x64-mingw32 java
RUN bundle install
RUN yarn install

EXPOSE 3000

CMD ["sh", "entrypoint.sh"]
