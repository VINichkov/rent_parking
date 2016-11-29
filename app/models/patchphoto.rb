class Patchphoto < ActiveRecord::Base
  belongs_to :parking
  dragonfly_accessor  :image
end
