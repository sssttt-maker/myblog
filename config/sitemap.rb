# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "https://shu-engineer.com"
SitemapGenerator::Sitemap.sitemaps_host = "https://s3-ap-northeast-1.amazonaws.com/#{ENV['S3_BUCKET_NAME']}"
SitemapGenerator::Sitemap.adapter = SitemapGenerator::AwsSdkAdapter.new(
  ENV['S3_BUCKET_NAME'],
  aws_access_key_id: ENV['AWS_ACCESS_KEY_ID'],
  aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
  aws_region: 'ap-northeast-1'
)

SitemapGenerator::Sitemap.create do

  add posts_path, changefreq: 'daily'
  add root_path, changefreq: 'daily'
  add about_path, changefreq: 'daily'
  add new_contact_path, changefreq: 'daily'
  # Put links creation logic here.
  #
  # The root path '/' and sitemap index file are added automatically for you.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host
  #
  # Examples:
  #
  # Add '/articles'
  #
  #   add articles_path, :priority => 0.7, :changefreq => 'daily'
  #
  # Add all articles:
  #
  posts = Post.published
  posts.find_each do |post|
    add post_path(post), lastmod: post.updated_at
  end
  Category.find_each do |category|
    add category_path(category), lastmod: category.updated_at
  end
end
