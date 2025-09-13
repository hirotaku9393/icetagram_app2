set -o errexit

echo "=== ビルド開始 ==="

# 環境情報の確認
echo "=== 環境情報 ==="
echo "Node.js: $(node --version)"
echo "Yarn: $(yarn --version)"
echo "Ruby: $(ruby --version)"

# 依存関係のインストール
echo "=== yarn install ==="
yarn install --frozen-lockfile

# Chart.jsの存在確認
echo "=== Chart.js確認 ==="
if [ -d "node_modules/chart.js" ]; then
    echo "✅ Chart.js found in node_modules"
    ls -la node_modules/chart.js/dist/ | head -5
else
    echo "❌ Chart.js NOT found in node_modules"
fi

# JavaScriptビルド
echo "=== yarn build ==="
yarn build

# ビルド結果の確認
echo "=== ビルド結果確認 ==="
ls -la app/assets/builds/
echo "=== Chart.js in bundle check ==="
if [ -f "app/assets/builds/application.js" ]; then
    echo "Bundle size: $(wc -c < app/assets/builds/application.js) bytes"
    if grep -q "Chart" app/assets/builds/application.js; then
        echo "✅ Chart found in JavaScript bundle"
    else
        echo "❌ Chart NOT found in JavaScript bundle"
    fi
else
    echo "❌ application.js not found"
fi

# Ruby gems
echo "=== bundle install ==="
bundle install

# アセットプリコンパイル
echo "=== rails assets:precompile ==="
bundle exec rails assets:precompile

# プリコンパイル結果確認
echo "=== プリコンパイル結果 ==="
ls -la public/assets/ | grep application | head -3

echo "=== データベース ==="
bundle exec rails db:migrate
bundle exec rails db:seed

echo "=== ビルド完了 ==="