class Study < ApplicationRecord
  belongs_to :user

  validates :user_id,presence: true, uniqueness: {scope: :date}
  validates :date,presence: true
  validates :count, numericality: { only_integer: true, greater_than:-1,less_than:97}
  validates :count, presence: true
  validates :content_today,length: {maximum:140}
  after_initialize :set_default, if: :new_record?


  def count_time
    num = self.count
    case (num * 15) % 60
    when 0
      "#{(num * 15) / 60}時間"
    when 15
      "#{(num * 15) / 60}時間15分"
    when 30
      "#{(num * 15) / 60}時間30分"
    else 45
      "#{(num * 15) / 60}時間45分"

    end
  end



   #created_atのフォーマット変換
  def format_date
    self.created_at.strftime("%Y年%m月%d日")

  end

  private

   def set_default
     self.date ||= Time.zone.now.strftime("%Y年%m月%d日")
   end


  private






end
