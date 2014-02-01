class GroupSerializer < ActiveModel::Serializer
  attributes :id, :name, :description
  has_many :users

  def description
    "#{object.description}"
  end

  def name
    "#{object.name}"
  end

end
