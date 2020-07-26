class Api::V1::ChartsController < ApiController
  def day
    day_hash ={}
      studies = current_user.studies.order(created_at: :desc).first(30)

    studies.each_with_index do |f,i|
      day_hash[30 - i] = {time:(f.count.to_f / 4).to_s,day: f.created_at.strftime("%m月%d日")}
    end

    (1..30).each do |i|
      unless day_hash[i]
        day_hash[i] = 0
      end
    end

    render :json => day_hash

  end

  def month
    month_hash = {}
    months = current_user.months.first(12)

    months.each_with_index do |f,i|
      month_hash[11 - i] = (f.time_count.to_f / 4).to_s
    end

    (1..12).each do |i|
      unless month_hash[i]
        month_hash[i] = 0
      end
    end

    render :json => month_hash

  end


end
