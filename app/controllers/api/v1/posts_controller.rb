class Api::V1::PostsController < Api::V1::ApplicationController
  before_action :setup_user, only: [:create, :add_comment, :vote]
  before_action -> { setup_user(optional: true) }, only: [:index, :show]
  before_action :setup_post, only: [:show, :add_comment, :vote]

  def index
    per_page = params[:per_page] || Post::PER_PAGE
    page = params[:page] || 1
    posts = Post.includes(:user, :votes).all.sort_by_weight.page(page).per(per_page)

    serialize_response(:post_summary, posts)
  end

  def show
    serialize_response(:post, @post, with_comments: true)
  end

  def create
    post = @user.posts.create!(post_params)

    serialize_response(:post, post)
  end

  def add_comment
    comment = @post.comments.create!(text: params[:text], user: @user)

    serialize_response(:comment, comment)
  end

  def vote
    vote = @post.votes.find_or_initialize_by(user: @user)

    if vote.persisted?
      vote.destroy!
    else
      vote.save!
    end

    success_response(:ok)
  end

  private

  def post_params
    params.permit(:title, :url)
  end

  def setup_post
    @post = Post.find_by(id: params[:id])
    return error_response(:post_not_found) if @post.nil?
  end
end
