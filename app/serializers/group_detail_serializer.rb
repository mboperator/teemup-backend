class GroupDetailSerializer < GroupSerializer
  has_many :admins
  has_one :created_by
end
