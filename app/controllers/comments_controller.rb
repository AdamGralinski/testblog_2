class CommentsController < ApplicationController
  def create
    post = Post.find(params[:post_id])
    comment = post.comments.create(params[:comment])
    comment.commenter = User.nickname
    comment.voteup_count = 0
    comment.votedown_count = 0
    comment.users_vote = Array.new
    comment.user_id = current_user.id
    comment.save
    redirect_to post_path(post)
  end

  def destroy
      post = Post.find(params[:id])
      comment = post.comments.find(params[:post_id])
      comment.destroy
      redirect_to post_path(post)
    end

    def voteup
      post = Post.find(params[:id])
      comment = post.comments.find(params[:post_id])
      comment.voteup_count += 1
      comment.save
      redirect_to post_path(post)
    end

    def votedown
      post = Post.find(params[:id])
      comment = post.comments.find(params[:post_id])
      comment.votedown_count += 1
      try_abusive()
      comment.save
      redirect_to post_path(post)
    end

    def try_abusive
      post = Post.find(params[:id])
      comment = post.comments.find(params[:post_id])
      if comment.votedown_count >= 2
        comment.abusive = true
        comment.save
      end
    end

    def not_abusive
      post = Post.find(params[:id])
      comment = post.comments.find(params[:post_id])
      comment.abusive = false
      comment.save
      redirect_to post_path(post)
    end
end
