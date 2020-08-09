class TimeByField < ApplicationRecord
  belongs_to  :user
  has_many :time_by_field_todays
end
