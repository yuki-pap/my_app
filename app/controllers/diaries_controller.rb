class DiariesController < ApplicationController
  def edit
    @study = current_user.studies.find(params[:id])
  end

  def update
    @study=current_user.studies.find(params[:id])

    @study.update_attributes(dairy_params)

    redirect_to current_user
  end



  def index
   @diaries = current_user.studies.order(created_at: :desc).paginate(page:params[:page],per_page:6)

  end


  private

   def dairy_params
     params.require(:dairy).permit(:content_today)
   end

end
