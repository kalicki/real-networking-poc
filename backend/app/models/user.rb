class User < ApplicationRecord
  belongs_to :company, optional: true

  def generate_access_token!
    self.auth_token = generate_token
    self.save!
    self.auth_token
  end
  
  private
  
  # https://blog.bigbinary.com/2016/03/23/has-secure-token-to-generate-unique-random-token-in-rails-5.html
  def generate_token
    loop do
      token = SecureRandom.hex(10)
      break token unless User.where(auth_token: token).exists?
    end
  end
end
