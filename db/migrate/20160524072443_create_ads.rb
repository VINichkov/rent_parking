class CreateAds < ActiveRecord::Migration
  def change
    create_table :ads do |t|
      t.references :district, index: true, foreign_key: true
      t.references :type_parking, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.references :period, index: true, foreign_key: true
      t.text :content

      t.timestamps null: false
    end
  end
end
