class StudiesController < ApplicationController

  before_action :logged_in_user, only: [:create,:show,:new,:update]
  before_action :create_graph, only:[:show]
  before_action :create_marker, only:[:show]
  protect_from_forgery except: [:create, :update]
#selectなどを使ってパフォーマンス上げる


  def show

    #グラフの作成


    unless current_user.months.find_by(month: Time.current.strftime("%Y年%m月"))
      month_sum = 0
        current_user.studies.each do |study|
          if Date.today.all_month.include?(Date.parse(study[:created_at].to_s))
            month_sum += study.count
          end
        end

      current_user.months.create(month:Time.current.strftime("%Y年%m月"),
                                 time_count: month_sum)

    end



      @study = current_user.studies.find_by(date: Time.current.strftime("%Y年%m月%d日"))

      @studies = current_user.studies.paginate(page:params[:page],per_page: 7).order(created_at: :desc)

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
    unless current_user.graphs.exists?
      (1..200).to_a.each do |f|
        current_user.graphs.create(number: f)
      end
    end
  end

  def create_marker
    unless current_user.markers.exists?
       current_user.markers.create(color:"Red",number:1,field:"未登録")
       current_user.markers.create(color:"Yellow",number:2,field:"未登録")
       current_user.markers.create(color:"Blue",number:3,field:"未登録")
       current_user.markers.create(color:"Light-Blue",number:4,field:"未登録")
       current_user.markers.create(color:"Green",number:5,field:"未登録")
       current_user.markers.create(color:"Yellow-green",number:6,field:"未登録")
    end
  end





end
