class Graph < ApplicationRecord
  validates :number, presence:true
  validates :field, length: {maximum:20}
  belongs_to :user

end
