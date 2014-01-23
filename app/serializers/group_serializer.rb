class GroupSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :created_by , :members
  def description
    "#{object.description}"
  end

  def name
    "#{object.name}"
  end

  def created_by
    User.find(object.created_by_id).full_name
  end

  def members
    object.users
  end

  def admins

  end

end
