class AnalysesController < ApplicationController

  def index
    @history = current_user.histories.find_by(number: 1)
  end

  
end
