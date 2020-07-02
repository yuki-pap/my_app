class EvaluatesController < ApplicationController
  def update
    @study = current_user.studies.find(params[:id])

    unless @study.value
      @study.update_attributes(value: true)
    end
    redirect_to @study

  end



end
