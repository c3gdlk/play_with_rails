class Email < ActiveRecord::Base
  validates :email, presence: true
end
