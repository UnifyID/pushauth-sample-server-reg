class User < ApplicationRecord
  has_secure_password

  validates :username, presence: true, uniqueness: { case_sensitive: false }

  before_create :generate_verification_code

  def consume_verification_code(provided_code)
    if provided_code == self.verification_code && !self.verification_used
      self.update_attributes(verification_used: true)
    end
  end

  private
  def generate_verification_code
    self.verification_code = rand(1000...9999)
  end
end
