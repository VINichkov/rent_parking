class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :surname
      t.string :login
      t.string :email
      t.string :namberphone
      t.belongs_to :role, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
