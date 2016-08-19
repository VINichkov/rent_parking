class CreateParkings < ActiveRecord::Migration
  def change
    create_table :parkings do |t|
      t.string :name
      t.string :adress
      t.float :latitude
      t.float :langitude
      t.boolean :accessible
      t.boolean :open24
      t.boolean :covered
      t.boolean :sitestaff
      t.boolean :overnight
      t.boolean :valet
      t.boolean :restrictions
      t.boolean :descriptions
      t.float :price
      t.boolean :typerent
      t.belongs_to :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
