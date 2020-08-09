class AnalysesController < ApplicationController

  def index
    @history = current_user.histories.find_by(number: 1)
    @user = current_user
    @study = @user.studies.find_by(date: Time.current.strftime("%Y年%m月%d日"))

  end


end
