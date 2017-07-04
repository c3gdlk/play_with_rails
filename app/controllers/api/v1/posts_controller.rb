class Api::V1::PostsController < Api::V1::BaseController
  before_action :authenticate_user!

  serialization_scope :view_context

  def index
    posts = Post.all
    render json: posts, status: 200, each_serializer: EnhancedPostSerializer
  end
end
