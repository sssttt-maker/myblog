class Admin::PostsController < ApplicationController
  require 'aws-sdk-s3'
  layout "admin"
  before_action :authenticate_user!

  def new
    @post = current_user.posts.new
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      redirect_to post_path(@post), notice: "記事を投稿しました。"
    else
      render :new
    end
  end

    def edit
      @post = current_user.posts.find(params[:id])
    end

    def update
      @post = current_user.posts.find(params[:id])
      if @post.update!(post_params)
        redirect_to post_path(@post), notice: "記事を編集しました。"
      else
        render :edit
      end
    end

    def destroy
      @post = current_user.posts.find(params[:id])
      @post.destroy
      redirect_back(fallback_location: root_path, notice: "記事「#{@post.title}」を削除しました。")
    end

    def all
      @posts = current_user.posts.with_attached_image.includes(:categories)
    end

    def published
      @posts = current_user.posts.published.with_attached_image.includes(:categories)
    end

    def drafts
      @posts = current_user.posts.draft.with_attached_image.includes(:categories)
    end

    def upload_image
    @file = params[:file].tempfile
    @key_name = "#{SecureRandom.hex}"  # バケットに置く際のキー名
    @s3 = Aws::S3::Resource.new(
      region: 'ap-northeast-1',  # リージョン東京
      credentials: Aws::Credentials.new(
        ENV['AWS_ACCESS_KEY_ID'],
        ENV['AWS_SECRET_ACCESS_KEY']
      )
    )
    obj = @s3.bucket(ENV['S3_BUCKET_NAME']).object(@key_name)
    obj.put(body: @file, acl: 'public-read')
    render(json: { url: obj.public_url })
  end

  private

  def post_params
    params.require(:post).permit(:title, :description, :text, :published, :image, :tag_list, category_ids: [])
  end

end
