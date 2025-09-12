set -o errexit

echo "ビルド開始"

bundle install
bundle exec rails assets:precompile
bundle exec rails db:clean
bundle exec rails db:migrate
bundle exec rails db:seed
