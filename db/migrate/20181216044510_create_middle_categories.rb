class CreateMiddleCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :middle_categories do |t|
      t.string :name, null:false, default: ""
      t.references :upper_category, foreign_key: true
      t.references :size_type, foreign_key: true
    end
  end
end
