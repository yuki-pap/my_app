class RanksController < ApplicationController
  def today
    @all_ranks = User.find(Study.where(date: Time.current.strftime("%Y年%m月%d日")).order(count: :desc).limit(10).pluck(:user_id))
  end



  def month

    @all_ranks = User.find(Month.where(month: Time.current.strftime("%Y年%m月")).order(time_count: :desc).limit(30).pluck(:user_id))

  end

  


end
