class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @posts = Post.recent.page(params[:page]).per(2)
  end

  def show
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(permitted_params)

    if @post.save
      redirect_to posts_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if post.update(permitted_params)
      redirect_to posts_path
    else
      render :edit
    end
  end

  def destroy
    post.destroy

    redirect_to posts_path
  end

  private

  def post
    @post ||= Post.find(params[:id])
  end
  helper_method :post

  def permitted_params
    params.require(:post).permit(:title, :body, :picture, :picture_cache)
  end
end
