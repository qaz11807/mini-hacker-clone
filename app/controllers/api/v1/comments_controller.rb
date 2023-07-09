class Api::V1::CommentsController < Api::V1::ApplicationController
  before_action :doorkeeper_authorize!, only: [:create, :votes]
  before_action :setup_comment, only: [:create, :votes]

  def create
    comment = @comment.comments.create!(text: params[:text], user: current_user)

    serialize_response(:comment, comment)
  end

  def votes
    vote = @comment.votes.find_or_initialize_by(user: current_user)
    return error_response(:already_voted) if vote.persisted?

    vote.save!

    success_response(:ok)
  end

  private

  def setup_comment
    @comment = Comment.find_by(id: params[:id])
    return error_response(:comment_not_found) if @comment.nil?
  end
end
