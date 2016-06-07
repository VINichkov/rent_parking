class IndexController < ApplicationController

  def index
    #Инициализация переменных для экранной формы
    @areas = []
    Area.all.each do |elem|
      @areas<<elem.name
    end

    @sities = []
    CityTown.all.each do |elem|
      @sities<<elem.name
    end

    @districts =[]
    District.all.each do |elem|
      @districts<<elem.name
    end

    @periods =[]
    Period.all.each do |elem|
      @periods<<elem.name
    end

    @typeparkings = []
    TypeParking.all.each do |elem|
      @typeparkings<<elem.Name
    end
  end

end
