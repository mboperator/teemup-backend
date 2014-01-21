class UserSerializer < ActiveModel::Serializer
  attributes :id, :full_name, :email, :phone_number
  
  def full_name
    "#{object.first_name} #{object.last_name}"
  end
end
