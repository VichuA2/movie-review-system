FROM ruby:3.0.4

RUN apt-get update -qq && apt-get install -y \
    build-essential \
    nodejs \
    npm \
    default-libmysqlclient-dev \
    curl \
    git

WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY package.json ./
RUN npm install --legacy-peer-deps

COPY . .

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

RUN mkdir -p tmp/pids tmp/cache tmp/sockets log

EXPOSE 3000

ENTRYPOINT ["/entrypoint.sh"]
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
