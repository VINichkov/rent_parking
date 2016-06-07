class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.references :ad, index: true, foreign_key: true
      t.string :name
      t.string :path
      t.text :content

      t.timestamps null: false
    end
  end
end
