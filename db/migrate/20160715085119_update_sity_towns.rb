class UpdateSityTowns < ActiveRecord::Migration
  def change
    change_table :city_towns do |t|
      t.boolean :capital
    end
  end
end
