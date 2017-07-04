class PostSerializer < ActiveModel::Serializer
  attributes :id, :title

  def title
    object.title.humanize
  end
end
