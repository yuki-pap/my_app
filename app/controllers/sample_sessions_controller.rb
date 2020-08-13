class SampleSessionsController < ApplicationController
  def create
    user = User.find_by(email: "example@railstutorial.org")
    log_in user
    redirect_to study_path(user.studies.find_by(date: Time.current.strftime("%Y年%m月%d日")))
  end
end
