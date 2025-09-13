set -o errexit

echo "ビルド開始"

yarn install
yarn build
bundle install
bundle exec rails assets:precompile
bundle exec rails db:migrate
bundle exec rails db:seed
