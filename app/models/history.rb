class History < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
  include ImageUploader::Attachment.new(:image)
  include ImageUploader[:image]
  #validates :number, numericality: { only_integer: true, greater_than:0}

  #validate :picture_size
  def picture_size
    if picture.size > 5.megabytes
      errors.add(:picture,"画像は5MB までです。")

    end
  end

end
