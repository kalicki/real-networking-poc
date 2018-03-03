class User < ApplicationRecord
  belongs_to :company

  validates :name, :email, :password_digest, presence: true
  validates :email, uniqueness: true, format: /@/

  def generate_access_token!
    self.access_token = SecureRandom.urlsafe_base64(16)
    self.save!
    self.access_token
  end
end
