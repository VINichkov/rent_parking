class CreatePatchphotos < ActiveRecord::Migration
  def change
    create_table :patchphotos do |t|
      t.string :patch
      t.belongs_to :parking

      t.timestamps null: false
    end
  end
end
