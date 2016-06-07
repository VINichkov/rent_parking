class CreateCityTowns < ActiveRecord::Migration
  def change
    create_table :city_towns do |t|
      t.string :name
      t.references  :area, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
