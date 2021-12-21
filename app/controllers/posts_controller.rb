class PostsController < ApplicationController
  before_action :search
  before_action :authenticate_user!, except: [:index, :show, :search]
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :move_to_index, only: [:edit, :update, :destroy]

  def index
    @posts = Post.page(params[:page]).per(10).order('updated_at DESC')
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @like = Like.new
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to root_path(@post.id)
    else
      redirect_to edit_post_path(@post.id)
    end
    if params[:delete_image]
      @post.image = nil
      @post.save!
    end
  end

  def destroy
    @post.destroy
    redirect_to root_path
  end

  def search
    if params[:q]&.dig(:title)
      squished_keywords = params[:q][:title].squish
      params[:q][:title_cont_any] = squished_keywords.split(' ')
    end
    @q = Post.ransack(params[:q])
    @posts = @q.result.page(params[:page]).per(10).order('updated_at DESC')
  end

  private

  def post_params
    params.require(:post).permit(:title, :text, :reference, :genre_id, :image).merge(user_id: current_user.id)
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def move_to_index
    redirect_to action: :index if current_user.id != @post.user_id
  end

end
