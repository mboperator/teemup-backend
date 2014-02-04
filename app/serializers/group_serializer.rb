class GroupSerializer < ActiveModel::Serializer
  attributes :id, :name, :description

  def description
    "#{object.description}"
  end

  def name
    "#{object.name}"
  end

end
