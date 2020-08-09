class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update,:destroy,
                            :following, :followers]
  before_action :correct_user, only: [:edit,:update]
  before_action :admin_user, only: :destroy

  def new
    @user= User.new
  end

  def index
    @menu_number = 2
    if params[:key]
      @users = User.paginate(page:params[:page],per_page: 20).where('name LIKE ?', "%#{params[:key]}%" )
    elsif params[:study_key]

      @users = User.paginate(page:params[:page],per_page: 20).where('description LIKE ?', "%#{params[:study_key]}%" )

    else
      @users = User.paginate(page:params[:page],per_page: 20)
    end
  end

  def show

    @graph_num = User.find(params[:id]).histories.count
    @menu_number = 1
    @user = User.find(params[:id])
    @study = @user.studies.find_by(date: Time.current.strftime("%Y年%m月%d日"))
    @dairy_today = @study&.content_today
    @study_yesterday =  @user.studies.find_by(date: Time.current.yesterday.strftime("%Y年%m月%d日"))
    @count_all = 0
    @time_by_fields = @user.time_by_fields
    range = Date.yesterday.beginning_of_day..Date.yesterday.end_of_day
      @time_by_field_todays =  @time_by_fields.map do |f|
            f.time_by_field_todays.find_by(created_at: range)
      end
     @user.studies.each do |f|
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
    @month_all = 0
    @user.studies.each do |f|
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

  def create
    @user = User.new(user_params)
    if @user.save
      UserMailer.account_activation(@user).deliver_now
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
    else
      render 'new'
    end
  end

  def edit
    @menu_number = 5
    @user = User.find(params[:id])
  end

  def update

    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile update"
      redirect_to @user

    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url

  end

  def feed
      @menu_number = 4
  end




  def following

    @title = "フォロー"
    @user = User.find(params[:id])

    @users = @user.following.paginate(page: params[:page])

    render 'show_follow'


  end
  def followers
    @title = "フォロワー"
    @user = User.find(params[:id])

    @users = @user.followers.paginate(page: params[:page])

    render 'show_follow'
  end


  private

    def user_params
      params.require(:user).permit(:name,:email,:password,
                        :password_confirmation,:description)
    end



    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless @user == current_user
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
