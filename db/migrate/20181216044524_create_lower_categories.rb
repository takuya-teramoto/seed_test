class CreateLowerCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :lower_categories do |t|
      t.string :name, null:false, default: ""
      t.references :middle_category, foreign_key: true
    end
  end
end
