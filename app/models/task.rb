class Task < ApplicationRecord
  belongs_to :study
  validates :content,length: {maximum:40}
end
