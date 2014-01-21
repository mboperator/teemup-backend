class User < ActiveRecord::Base
  has_secure_password

  has_many :api_keys

  validates :email, presence: true, uniqueness: true, format: /\A*.+@.+\z/
  validates :password, presence: true, length: { minimum: 6 }, if: :password

  before_save { self.email = email.downcase }
  after_save :create_access_token

  private
  def create_access_token
    self.api_keys.create!
  end

end
