class LikesController < ApplicationController
  def create
    post = Post.includes(:likes).find(params[:post_id])
    likes = post.likes_by(current_user)

    likes.any? ? likes.each(&:destroy) : Like.create(post:, author:current_user)
    # Like.create(post: @post, author: current_user)
    # Like.update_likes_counter(@post)
    # redirect_to user_post_path(@post.author)
  end
end