class IndexController < ApplicationController
  layout 'application'
  def index

  end

  def allm
    @marker=Parking.all
  end
end
