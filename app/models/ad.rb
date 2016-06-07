class Ad < ActiveRecord::Base
  belongs_to :district
  belongs_to :type_parking
  belongs_to :user
  belongs_to :period
end
