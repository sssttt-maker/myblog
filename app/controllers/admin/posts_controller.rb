class Admin::PostsController < ApplicationController
  layout "admin"
  before_action :authenticate_user!
  before_action :hash_init, only: %i[index new create edit]

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
      @posts = current_user.posts.all
    end

    def published
      @posts = current_user.posts.published
    end

    def drafts
      @posts = current_user.posts.draft
    end

  private

  def post_params
    params.require(:post).permit(:title, :text, :published, :image, :tag_list, category_ids: [])
  end

  def hash_init
    case Rails.env
    when 'development'
      options = {
        bucket: ENV['DEVELOPMENT_S3_BUCKET_NAME'],
        region: 'ap-northeast-1', # japan[Tokyo]
        keyStart: 'uploads/', # uploads/filename.png
        acl: 'public-read',
        accessKey: Rails.application.credentials.dig(:aws, :access_key_id),
        secretKey: Rails.application.credentials.dig(:aws, :secret_access_key),
      }
      @aws_data = FroalaEditorSDK::S3.data_hash(options)
    when 'production'
      options = {
        bucket: 'myblog-production',
        region: 'ap-northeast-1', # japan[Tokyo]
        keyStart: 'uploads/', # uploads/filename.png
        acl: 'public-read',
        accessKey: Rails.application.credentials.dig(:aws, :access_key_id),
        secretKey: Rails.application.credentials.dig(:aws, :secret_access_key),
      }
      @aws_data = FroalaEditorSDK::S3.data_hash(options)
    end
  end
end
