class StaticPagesController < ApplicationController
  def home

    @view = "home"

    @history = current_user.histories.find_by(number: 1)

    @url = @history.image[:medium].url




  end

  def help
  end

  def about
  end

  def contact

  end
end
