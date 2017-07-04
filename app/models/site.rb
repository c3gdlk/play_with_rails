class Site < ActiveRecord::Base
  has_many :emails

  validates :url, presence: true
end
