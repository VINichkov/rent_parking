class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :fio
      t.string :login
      t.string :phone
      t.references :role, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
