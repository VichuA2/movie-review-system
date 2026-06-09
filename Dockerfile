FROM ruby:3.0.4

RUN apt-get update -qq && apt-get install -y \
    build-essential \
    nodejs \
    npm \
    sqlite3 \
    libsqlite3-dev

WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY package.json package-lock.json ./
RUN npm install

COPY . .

ENV RAILS_ENV=production
ENV SECRET_KEY_BASE=dummy_secret_key_for_assets

RUN bundle exec rails assets:precompile

EXPOSE 3000

CMD ["bash", "-c", "bundle exec rails db:migrate && bundle exec rails server -b 0.0.0.0 -p 3000"]
