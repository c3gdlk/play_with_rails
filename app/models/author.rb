class Author < ActiveRecord::Base
  has_many :comments

  validates :name, :tile, :number,  presence: true, length: {minimum: 10} 
end
