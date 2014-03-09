class TagSerializer < ActiveModel::Serializer
  attributes :id, :name, :count

  def name
    "#{object.name}"
  end

  def count
    object.events.where("start_time > ?", Time.now).where("start_time < ?", Time.now + (60*60*24)).count
  end

end
