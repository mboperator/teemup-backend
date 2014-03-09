class TagSerializer < ActiveModel::Serializer
  attributes :id, :name, :count

  def name
    "#{object.name}"
  end

  def count
    object.events.current.count
  end

end
