class GroupSerializer < ActiveModel::Serializer
  attributes :id, :name, :description
  has_many :users
  has_many :admins
  has_one :created_by
  has_many :events

  def description
    "#{object.description}"
  end

  def name
    "#{object.name}"
  end
end
