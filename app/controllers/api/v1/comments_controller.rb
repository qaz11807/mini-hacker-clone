class Api::V1::CommentsController < Api::V1::ApplicationController
  before_action :setup_user, only: [:add_comment, :vote]
  before_action :setup_comment, only: [:add_comment, :vote]

  def add_comment
    comment = @comment.children.create!(text: params[:text], user: @user, post: @comment.post)

    serialize_response(:comment, comment)
  end

  def vote
    vote = @comment.votes.find_or_initialize_by(user: @user)

    if vote.persisted?
      vote.destroy!
    else
      vote.save!
    end

    success_response(:ok)
  end

  private

  def setup_comment
    @comment = Comment.find_by(id: params[:id])
    return error_response(:comment_not_found) if @comment.nil?
  end
end
