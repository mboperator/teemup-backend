class GroupSerializer < ActiveModel::Serializer
  attributes :id, :name, :description
  has_many :users
  has_many :admins
  has_one :created_by

  def description
    "#{object.description}"
  end

  def name
    "#{object.name}"
  end
end
