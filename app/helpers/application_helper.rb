module ApplicationHelper
  def default_meta_tags
    {
      site: 'shu-Official',
      title: '',
      reverse: true,
      charset: 'utf-8',
      description: 'description',
      keywords: 'キーワード',
      canonical: request.original_url,
      separator: '',
      icon: [
        { href: image_url('favicon.ico') },
        { href: image_url('icon.png'), rel: 'apple-touch-icon', sizes: '180x180', type: 'image/png' },
      ],
      og: {
        site_name: 'サイト名', # もしくは site_name: :site
        title: 'タイトル', # もしくは title: :title
        description: 'description', # もしくは description: :description
        type: 'website',
        url: request.original_url,
        image: image_url('tree.jpg'),
        locale: 'ja_JP',
      },
      twitter: {
        card: 'summary',
        site: '@T_Shu_Channel',
      }
    }
  end
end
