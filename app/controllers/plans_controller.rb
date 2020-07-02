class PlansController < ApplicationController
 def edit
   @study = current_user.studies.find(params[:id])
 end

 def update
   @study=current_user.studies.find(params[:id])

   @study.update_attributes(plan_params)

   if @study.date == Time.current.strftime("%Y年%m月%d日")
      redirect_to @study
   else
     @study = current_user.studies.find_by(date:Time.current.strftime("%Y年%m月%d日") )
     redirect_to @study
   end

 end

 def new
 end

 def create
   @study = current_user.studies.build(count: 0)

 end




  private

  def plan_params

   params.require(:plan).permit(:content_plan)

  end


end
