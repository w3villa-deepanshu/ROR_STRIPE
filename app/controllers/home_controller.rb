class HomeController < ApplicationController
  def index
    @upcoming_workshops = Workshop.upcoming_workshop
    @past_workshops = Workshop.past_workshop
  end
end
