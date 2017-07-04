class Post < ActiveRecord::Base
  attr_accessor :encoded_picture

  has_many :comments
  has_many :categories_posts
  has_many :categories, through: :categories_posts

  scope :with_body, -> { where.not(body: nil) }
  scope :recent,    -> { order(updated_at: :desc) }
  scope :recent_with_body, -> { with_body.recent }

  before_validation :print_title
  before_save :generate_body, unless: :body_present?
  before_save :decode_file, if: -> { encoded_picture.present?  }
  after_save  :print_success

  validates :title, presence: true, length: { minimum: 3 }

  mount_uploader :picture, PostPictureUploader

  private

  def decode_file
    filename = SecureRandom.hex(20)
    tmp_file = Tempfile.new(%W(#{filename} .jpg))

    File.open(tmp_file, 'wb') do|f|
      f.write(Base64.decode64(encoded_picture))
    end

    self.picture = tmp_file

    tmp_file.close
    tmp_file.unlink
  end

  def body_present?
    body.present?
  end

  def print_title
    puts title
  end

  def generate_body

      self.body = 'A' * 100

  end

  def print_success
    puts 'Success'
  end
end
