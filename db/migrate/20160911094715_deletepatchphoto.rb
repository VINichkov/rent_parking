class Deletepatchphoto < ActiveRecord::Migration
  def change
    remove_column :patchphotos, :patch, :string
    add_column :patchphotos, :image_uid, :string
  end
end
