class EnhancedPostSerializer < PostSerializer
  attributes :id, :title, :thumb

  def thumb
    view_context.asset_url object.picture.thumb.url
  end
end
