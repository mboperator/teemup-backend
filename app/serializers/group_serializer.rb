class GroupSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :created_by , :members
  def description
    "#{object.description}"
  end

  def name
    "#{object.name}"
  end

  def created_by
    "#{object.created_by.first_name} #{object.created_by.last_name}"
  end

  def members
    object.users
  end

  def admins

  end

end
