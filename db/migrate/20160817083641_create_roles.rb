class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string :code
      t.string :name
      t.text :descriptions

      t.timestamps null: false
    end
  end
end
