#!/bin/bash
set -e

echo "==> Running database migrations..."
bundle exec rails db:migrate 2>/dev/null || bundle exec rails db:create db:migrate

echo "==> Starting Puma..."
exec "$@"
