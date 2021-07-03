class Room < ApplicationRecord
  before_create :generate_token

  belongs_to :user
  has_many :messages, dependent: :destroy

  private

  def generate_token
    self.token = SecureRandom.hex(2)
  end
end
