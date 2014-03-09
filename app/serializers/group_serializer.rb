class GroupSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :count

  def description
    "#{object.description}"
  end

  def name
    "#{object.name}"
  end

  def count
    object.events.where("start_time > ?", Time.now).count
  end

end
