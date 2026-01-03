SitemapGenerator::Sitemap.default_host = "https://icetagram.com"

SitemapGenerator::Sitemap.create do
  # 投稿一覧ページ
  add ice_creams_path, priority: 0.8, changefreq: "daily"

  # 各投稿ページ
  IceCream.find_each do |ice_cream|
    add ice_cream_path(ice_cream), lastmod: ice_cream.updated_at
  end
end
