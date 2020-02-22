class CreateBrands < ActiveRecord::Migration[5.2]
  def change
    create_table :brands do |t|
      t.string :name, null:false, default: ""
      t.string :initial_word, null:false, default: ""
    end
  end
end
