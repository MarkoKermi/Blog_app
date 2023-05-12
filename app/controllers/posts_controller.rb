class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.includes(:comments).order(created_at: :desc)
    # @comments = Comments.new
  end

  def show
    @post = Post.includes(:comments).find(params[:id])
    puts "**********************************"
    puts @post.id
    @user = @post.author
  end

  def new
    @post = Post.new
    @user = current_user
  end

  def create
    @post = current_user.posts.create(post_params)
    if @post.valid?
      redirect_to user_post_path(current_user, @post), notice: 'The post was created'
    else
      redirect_to new_user_post_path(current_user), alert: 'The post was not created'
    end
  end

  private

  def post_params
    post = params.require(:post).permit(:title, :text)
    post[:comments_counter] = 0
    post[:likes_counter] = 0
    post
  end
end
