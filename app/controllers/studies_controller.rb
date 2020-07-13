class StudiesController < ApplicationController

  before_action :logged_in_user, only: [:create,:show,:new,:update]
  before_action :create_graph, only: [:show]
  protect_from_forgery except: [:create, :update]
#selectなどを使ってパフォーマンス上げる
  def show
    unless current_user.months.find_by(month: Time.current.strftime("%Y年%m月"))
      month_sum = 0
        current_user.studies.each do |study|
          if Date.today.all_month.include?(Date.parse(study[:created_at].to_s))
            month_sum += study.count
          end
        end

      current_user.months.create(month:Time.current.strftime("%Y年%m月"),
                                 time_count: month_sum)
      @study = current_user.studies.find_by(date: Time.current.strftime("%Y年%m月%d日"))



    end



    @study = current_user.studies.find(params[:id])

    @studies = current_user.studies.paginate(page:params[:page],per_page: 7).order(created_at: :desc)

    @count_all = 0

    @studies.each do |f|
      @count_all += f.count
    end




    case (@count_all * 15) % 60
    when 0
      @study_all_time = "#{(@count_all * 15) / 60}時間"
    when 15
      @study_all_time = "#{(@count_all * 15) / 60}時間15分"
    when 30
      @study_all_time = "#{(@count_all * 15) / 60}時間30分"
    else 45
      @study_all_time = "#{(@count_all * 15) / 60}時間45分"

    end


    @study_yesterday = current_user.studies.find_by(date: Time.current.yesterday.strftime("%Y年%m月%d日"))

    @month_all = 0
    current_user.studies.each do |f|
      if f.created_at.strftime("%Y年%m月") == Time.current.strftime("%Y年%m月")
        @month_all += f.count
      end
    end


    case (@month_all * 15) % 60
    when 0
      @study_all_time_month = "#{(@month_all * 15) / 60}時間"
    when 15
      @study_all_time_month = "#{(@month_all * 15) / 60}時間15分"
    when 30
      @study_all_time_month = "#{(@month_all * 15) / 60}時間30分"
    else 45
      @study_all_time_month = "#{(@month_all * 15) / 60}時間45分"

    end

    


  end

  def new
    @study = current_user.studies.find_by(date: Time.zone.now.strftime("%Y年%m月%d日"))

    if @study
      redirect_to study_path(@study)
    end
  end


  def update

   @study = current_user.studies.find(params[:id])
   num =  params[:study][:time_count]

   number = @study.count + (num.to_i / 15)

   @month = current_user.months.find_by(month: Time.current.strftime("%Y年%m月"))


   if @study.update_attributes(count: number)

      n = @month.time_count + (num.to_i / 15)

      @month.update_attributes(time_count: n)

      redirect_to @study

   else
     redirect_to @study

   end


  end



  def create
    @study = current_user.studies.build(count: 0)

    if @study.save
      redirect_to @study
    else
      studies = current_user.studies

      studies.each do |study|

        if (study.created_at.to_s.match(/#{Date.today.to_s}.+/))
          @study = study
        end

      end

      redirect_to @study
    end

  end

  private

  def create_graph
    if current_user.graphs.size == 0
      200.times do |n|
        current_user.graphs.create!
      end
    end
    #方眼紙切り替えの処理
    if current_user.graphs.where(fill: false).select('fill').size == 0
      200.times do |n|
        current_user.graphs.find(n).update_attributes(fill: false,color_num: 0)
      end
    end
  end

end
