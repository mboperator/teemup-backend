class EventDetailSerializer < EventSerializer
  has_many :confirmed_users
  has_many :admin_users
end
