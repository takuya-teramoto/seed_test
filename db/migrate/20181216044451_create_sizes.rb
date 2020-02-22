class CreateSizes < ActiveRecord::Migration[5.2]
  def change
    create_table :sizes do |t|
      t.string :name, null:false, default: ""
      t.references :size_type, foreign_key: true
    end
  end
end
