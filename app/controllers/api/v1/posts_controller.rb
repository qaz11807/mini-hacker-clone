class Api::V1::PostsController < Api::V1::ApplicationController
  before_action :setup_user, only: [:create, :add_comment]
  before_action -> { setup_user(optional: true) }
  before_action :setup_post, only: [:show, :add_comment]

  def index
    per_page = params[:per_page] || Post::PER_PAGE
    page = params[:page] || 1
    posts = Post.includes(:user).all.sort_by_weight.page(page).per(per_page)

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

  private

  def post_params
    params.permit(:title, :url)
  end

  def setup_post
    @post = Post.find_by(id: params[:id])
    return error_response(:post_not_found) if @post.nil?
  end
end
