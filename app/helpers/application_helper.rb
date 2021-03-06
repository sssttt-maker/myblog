module ApplicationHelper
  def default_meta_tags
    {
      site: 'shu-Official',
      title: '',
      reverse: true,
      charset: 'utf-8',
      description: '休学中大学生のポートフォリオ兼ブログ',
      keywords: 'shu,rails,プログラミング,休学,エンジニア,ブログ',
      canonical: request.original_url,
      separator: '|',
      icon: [
        { href: image_url('favicon.ico') },
        { href: image_url('icon.png'), rel: 'apple-touch-icon', sizes: '180x180', type: 'image/png' },
      ],
      og: {
        site_name: :site, # もしくは site_name: :site
        title: :title, # もしくは title: :title
        description: :description, # もしくは description: :description
        type: 'website',
        url: request.original_url,
        image: image_url('blog.jpg'),
        locale: 'ja_JP',
      },
      twitter: {
        card: 'summary',
        site: '@T_Shu_Channel',
      }
    }
  end
end
