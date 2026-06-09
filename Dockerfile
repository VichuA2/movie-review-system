FROM ruby:3.0.4

RUN apt-get update -qq && apt-get install -y \
    build-essential \
    nodejs \
    npm \
    sqlite3 \
    libsqlite3-dev \
    default-libmysqlclient-dev

WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY package.json package-lock.json ./
RUN npm install

COPY . .

EXPOSE 3000

CMD ["bash", "-c", "bundle exec rails db:migrate && bundle exec rails server -b 0.0.0.0 -p 3000"]
