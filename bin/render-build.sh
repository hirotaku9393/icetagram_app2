set -o errexit

yarn install
yarn build
bundle install
bundle exec rails assets:precompile
bundle exec rails db:migrate
bundle exec rails db:seed
