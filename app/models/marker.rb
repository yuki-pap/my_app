class Marker < ApplicationRecord
  validates :color, presence:true
  validates :field, length: {maximum:20}

  belongs_to :user




end
