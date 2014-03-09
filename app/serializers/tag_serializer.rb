class TagSerializer < ActiveModel::Serializer
  attributes :id, :name, :count

  def name
    "#{object.name}"
  end

  def count
    object.events.where("start_time > ?", Time.now).count
  end

end
