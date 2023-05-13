class LikesController < ApplicationController
  def create
    # post = Post.includes(:likes).find(params[:post_id])
    # likes = post.likes_by(current_user)

    # likes.any? ? likes.each(&:destroy) : Like.create(post:, author:current_user)
    # # Like.create(post: @post, author: current_user)
    # # Like.update_likes_counter(@post)
    # redirect_to user_post_path(@post.author)

    # @post = Post.find(params[:post_id])
    # Like.create(post: @post, author: current_user)
    # Like.update_likes_counter(@post)
    # # redirect_to user_posts_path(@post.author)
    # post = Post.includes(:likes).find(params[:post_id])
    # likes = post.likes_by(current_user)

    # likes.any? ? likes.each(&:destroy) : Like.create(post:, author: current_user)

    # redirect_to user_posts_path(post.author)
    user = current_user
    post = Post.find(params[:post_id])
    new_like = Like.create(post: post, author: user)
    if new_like.valid?
      flash[:success] = 'commented successfully'
      respond_to do |format|
        format.html { redirect_to request.referrer, notice: 'Liked' }
      end
    else
      flash[:alert] = 'error creating comment'
    end
  end
end
