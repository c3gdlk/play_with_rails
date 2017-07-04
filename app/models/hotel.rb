class Hotel < ActiveRecord::Base
  has_many :rooms
  belongs_to :admin_user

  validates :title, presence: true
end    