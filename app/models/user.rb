class User < ApplicationRecord
  before_create :generate_nickname

  has_many :rooms, dependent: :destroy

  scope :online, -> { User.where(online: true) }

  private

  def generate_nickname
    self.nickname = Faker::Name.first_name.downcase
  end
end
