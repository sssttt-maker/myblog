# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "https://shu-engineer.com"

SitemapGenerator::Sitemap.create do

  add posts_path, changefreq: 'daily'
  add root_path, changefreq: 'daily'
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
  Post.find_each do |post|
    add post_path(post), lastmod: post.updated_at
  end
end
