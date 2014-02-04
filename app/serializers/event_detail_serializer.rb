class EventDetailSerializer < EventSerializer
  attributes :created_by

  def created_by
    object.created_by.full_name
  end
end
